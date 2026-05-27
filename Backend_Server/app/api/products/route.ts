import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, validationErrorResponse } from '@/lib/errors'

const createProductSchema = z.object({
  sku: z.string().min(1, 'SKU is required'),
  name: z.string().min(1, 'Product name is required'),
  category: z.string().min(1, 'Category is required'),
  stockQuantity: z.number().min(0).default(0),
  unitPrice: z.number().min(0, 'Unit price must be >= 0'),
  buyingPrice: z.number().min(0, 'Buying price must be >= 0'),
  isActive: z.boolean().default(true),
})

export async function GET(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const { searchParams } = new URL(request.url)
    const page = parseInt(searchParams.get('page') ?? '1')
    const limit = parseInt(searchParams.get('limit') ?? '20')
    const category = searchParams.get('category')
    const isActive = searchParams.get('isActive')
    const skip = (page - 1) * limit

    const where: Record<string, unknown> = { storeId }
    if (category) where.category = category
    if (isActive !== null) where.isActive = isActive === 'true'

    const [products, total] = await Promise.all([
      prisma.product.findMany({
        where,
        skip,
        take: limit,
        orderBy: { createdAt: 'desc' },
      }),
      prisma.product.count({ where }),
    ])

    return successResponse({
      products,
      pagination: { page, limit, total, pages: Math.ceil(total / limit) },
    })
  } catch (error) {
    console.error('Get products error:', error)
    return errorResponse('Internal server error')
  }
}

export async function POST(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const body = await request.json()
    const parsed = createProductSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const { sku, name, category, stockQuantity, unitPrice, buyingPrice, isActive } = parsed.data

    // Check SKU uniqueness within store
    const existing = await prisma.product.findUnique({
      where: { sku_storeId: { sku, storeId } },
    })
    if (existing) return errorResponse('SKU already exists in this store', 409)

    const product = await prisma.product.create({
      data: { sku, name, category, stockQuantity, unitPrice, buyingPrice, isActive, storeId },
    })

    // Create initial stock history if stock > 0
    if (stockQuantity > 0) {
      await prisma.stockHistory.create({
        data: {
          productId: product.id,
          storeId,
          quantityChange: stockQuantity,
          type: 'IN',
          note: 'Initial stock on product creation',
        },
      })
    }

    return successResponse({ product }, 201)
  } catch (error) {
    console.error('Create product error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
