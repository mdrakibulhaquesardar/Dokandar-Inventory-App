import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse, validationErrorResponse } from '@/lib/errors'

const updateStoreSchema = z.object({
  name: z.string().min(1).optional(),
  address: z.string().min(1).optional(),
  phone: z.string().optional(),
  email: z.string().email().optional(),
  businessType: z.string().optional(),
  website: z.string().url().optional(),
  description: z.string().optional(),
  logo: z.string().optional(),
  settings: z.string().optional(),
  isActive: z.boolean().optional(),
})

export async function GET(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const store = await prisma.store.findUnique({
      where: { id: storeId },
      include: { owner: { select: { id: true, name: true, email: true, role: true } } },
    })

    if (!store) return notFoundResponse('Store')

    return successResponse({ store })
  } catch (error) {
    console.error('Get store error:', error)
    return errorResponse('Internal server error')
  }
}

export async function PUT(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const body = await request.json()
    const parsed = updateStoreSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const store = await prisma.store.update({
      where: { id: storeId },
      data: parsed.data,
    })

    return successResponse({ store })
  } catch (error) {
    console.error('Update store error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
