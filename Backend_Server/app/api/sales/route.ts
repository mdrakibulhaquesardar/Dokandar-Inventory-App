import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, validationErrorResponse } from '@/lib/errors'

const saleItemSchema = z.object({
  productId: z.string().min(1, 'Product ID is required'),
  quantity: z.number().positive('Quantity must be positive'),
  unitPrice: z.number().min(0, 'Unit price must be >= 0'),
})

const createSaleSchema = z.object({
  invoiceNumber: z.string().min(1, 'Invoice number is required'),
  customerId: z.string().min(1, 'Customer ID is required'),
  totalAmount: z.number().min(0),
  discount: z.number().min(0).default(0),
  paidAmount: z.number().min(0),
  notes: z.string().optional(),
  isCompleted: z.boolean().default(true),
  saleDate: z.string().datetime().optional(),
  items: z.array(saleItemSchema).min(1, 'At least one item is required'),
})

export async function GET(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const { searchParams } = new URL(request.url)
    const page = parseInt(searchParams.get('page') ?? '1')
    const limit = parseInt(searchParams.get('limit') ?? '20')
    const customerId = searchParams.get('customerId')
    const from = searchParams.get('from')
    const to = searchParams.get('to')
    const skip = (page - 1) * limit

    const where: Record<string, unknown> = { storeId }
    if (customerId) where.customerId = customerId
    if (from || to) {
      where.saleDate = {
        ...(from ? { gte: new Date(from) } : {}),
        ...(to ? { lte: new Date(to) } : {}),
      }
    }

    const [sales, total] = await Promise.all([
      prisma.sale.findMany({
        where,
        skip,
        take: limit,
        orderBy: { saleDate: 'desc' },
        include: {
          customer: { select: { id: true, name: true, phone: true } },
          items: { include: { product: { select: { id: true, name: true, sku: true } } } },
        },
      }),
      prisma.sale.count({ where }),
    ])

    return successResponse({
      sales,
      pagination: { page, limit, total, pages: Math.ceil(total / limit) },
    })
  } catch (error) {
    console.error('Get sales error:', error)
    return errorResponse('Internal server error')
  }
}

export async function POST(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const body = await request.json()
    const parsed = createSaleSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const { invoiceNumber, customerId, totalAmount, discount, paidAmount, notes, isCompleted, saleDate, items } = parsed.data

    const dueAmount = totalAmount - discount - paidAmount

    const sale = await prisma.$transaction(async (tx) => {
      // Verify customer belongs to this store
      const customer = await tx.customer.findFirst({ where: { id: customerId, storeId } })
      if (!customer) throw new Error('Customer not found in this store')

      // Verify invoice uniqueness
      const existing = await tx.sale.findUnique({
        where: { invoiceNumber_storeId: { invoiceNumber, storeId } },
      })
      if (existing) throw new Error('Invoice number already exists')

      // Validate products and compute line totals
      const saleItemsData = await Promise.all(
        items.map(async (item) => {
          const product = await tx.product.findFirst({ where: { id: item.productId, storeId, isActive: true } })
          if (!product) throw new Error(`Product ${item.productId} not found`)
          if (product.stockQuantity < item.quantity) {
            throw new Error(`Insufficient stock for product: ${product.name}`)
          }
          return {
            productId: item.productId,
            productName: product.name,
            quantity: item.quantity,
            unitPrice: item.unitPrice,
            totalPrice: item.quantity * item.unitPrice,
          }
        })
      )

      // Create sale
      const sale = await tx.sale.create({
        data: {
          invoiceNumber,
          customerId,
          storeId,
          totalAmount,
          discount,
          paidAmount,
          dueAmount,
          notes,
          isCompleted,
          saleDate: saleDate ? new Date(saleDate) : new Date(),
          items: { create: saleItemsData },
        },
        include: {
          items: true,
          customer: { select: { id: true, name: true, phone: true } },
        },
      })

      // Decrement stock and record stock history for each item
      for (const item of saleItemsData) {
        await tx.product.update({
          where: { id: item.productId },
          data: { stockQuantity: { decrement: item.quantity } },
        })
        await tx.stockHistory.create({
          data: {
            productId: item.productId,
            storeId,
            quantityChange: -item.quantity,
            type: 'OUT',
            note: `Sale invoice: ${invoiceNumber}`,
          },
        })
      }

      // Update customer totals
      await tx.customer.update({
        where: { id: customerId },
        data: {
          totalPurchase: { increment: totalAmount },
          totalPaid: { increment: paidAmount },
          totalDue: { increment: dueAmount },
        },
      })

      return sale
    })

    return successResponse({ sale }, 201)
  } catch (error) {
    if (error instanceof Error) {
      return errorResponse(error.message, 400)
    }
    console.error('Create sale error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
