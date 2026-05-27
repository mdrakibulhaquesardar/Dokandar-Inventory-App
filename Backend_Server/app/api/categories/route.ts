import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, validationErrorResponse } from '@/lib/errors'

const createCategorySchema = z.object({
  name: z.string().min(1, 'Category name is required'),
})

export async function GET(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const categories = await prisma.category.findMany({
      where: { storeId },
      orderBy: { name: 'asc' },
    })

    return successResponse({ categories })
  } catch (error) {
    console.error('Get categories error:', error)
    return errorResponse('Internal server error')
  }
}

export async function POST(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const body = await request.json()
    const parsed = createCategorySchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const { name } = parsed.data

    // Check uniqueness within store
    const existing = await prisma.category.findUnique({
      where: { name_storeId: { name, storeId } },
    })
    if (existing) return errorResponse('Category already exists', 409)

    const category = await prisma.category.create({
      data: { name, storeId },
    })

    return successResponse({ category }, 201)
  } catch (error) {
    console.error('Create category error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
