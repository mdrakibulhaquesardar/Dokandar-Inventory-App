import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse, validationErrorResponse } from '@/lib/errors'

const updateProductSchema = z.object({
  name: z.string().min(1).optional(),
  category: z.string().min(1).optional(),
  unitPrice: z.number().min(0).optional(),
  buyingPrice: z.number().min(0).optional(),
  isActive: z.boolean().optional(),
  stockAdjustment: z.number().optional(), // signed quantity change
  adjustmentNote: z.string().optional(),
})

export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const product = await prisma.product.findFirst({
      where: { id, storeId },
      include: {
        stockHistories: { orderBy: { createdAt: 'desc' }, take: 10 },
      },
    })

    if (!product) return notFoundResponse('Product')
    return successResponse({ product })
  } catch (error) {
    console.error('Get product error:', error)
    return errorResponse('Internal server error')
  }
}

export async function PUT(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const body = await request.json()
    const parsed = updateProductSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const existing = await prisma.product.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Product')

    const { stockAdjustment, adjustmentNote, ...updateData } = parsed.data

    const product = await prisma.$transaction(async (tx) => {
      const updatedProduct = await tx.product.update({
        where: { id },
        data: {
          ...updateData,
          ...(stockAdjustment !== undefined
            ? { stockQuantity: { increment: stockAdjustment } }
            : {}),
        },
      })

      if (stockAdjustment !== undefined && stockAdjustment !== 0) {
        await tx.stockHistory.create({
          data: {
            productId: id,
            storeId,
            quantityChange: stockAdjustment,
            type: stockAdjustment > 0 ? 'IN' : 'OUT',
            note: adjustmentNote ?? 'Manual stock adjustment',
          },
        })
      }

      return updatedProduct
    })

    return successResponse({ product })
  } catch (error) {
    console.error('Update product error:', error)
    return errorResponse('Internal server error')
  }
}

export async function DELETE(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const existing = await prisma.product.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Product')

    // Soft delete by deactivating
    await prisma.product.update({ where: { id }, data: { isActive: false } })

    return successResponse({ message: 'Product deactivated successfully' })
  } catch (error) {
    console.error('Delete product error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
