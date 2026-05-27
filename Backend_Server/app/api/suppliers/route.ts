import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, validationErrorResponse } from '@/lib/errors'

const createSupplierSchema = z.object({
  supplierCode: z.string().min(1, 'Supplier code is required'),
  name: z.string().min(1, 'Supplier name is required'),
  company: z.string().optional(),
  phone: z.string().optional(),
  email: z.string().email().optional(),
  address: z.string().optional(),
})

export async function GET(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const { searchParams } = new URL(request.url)
    const page = parseInt(searchParams.get('page') ?? '1')
    const limit = parseInt(searchParams.get('limit') ?? '20')
    const q = searchParams.get('q')
    const skip = (page - 1) * limit

    const where: Record<string, unknown> = { storeId }
    if (q) {
      where.OR = [
        { name: { contains: q, mode: 'insensitive' } },
        { supplierCode: { contains: q, mode: 'insensitive' } },
        { company: { contains: q, mode: 'insensitive' } },
        { phone: { contains: q, mode: 'insensitive' } },
      ]
    }

    const [suppliers, total] = await Promise.all([
      prisma.supplier.findMany({ where, skip, take: limit, orderBy: { name: 'asc' } }),
      prisma.supplier.count({ where }),
    ])

    return successResponse({
      suppliers,
      pagination: { page, limit, total, pages: Math.ceil(total / limit) },
    })
  } catch (error) {
    console.error('Get suppliers error:', error)
    return errorResponse('Internal server error')
  }
}

export async function POST(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const body = await request.json()
    const parsed = createSupplierSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const { supplierCode } = parsed.data

    const existing = await prisma.supplier.findUnique({
      where: { supplierCode_storeId: { supplierCode, storeId } },
    })
    if (existing) return errorResponse('Supplier code already exists in this store', 409)

    const supplier = await prisma.supplier.create({
      data: { ...parsed.data, storeId },
    })

    return successResponse({ supplier }, 201)
  } catch (error) {
    console.error('Create supplier error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
