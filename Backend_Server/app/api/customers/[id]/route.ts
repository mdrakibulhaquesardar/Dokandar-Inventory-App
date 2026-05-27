import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse, validationErrorResponse } from '@/lib/errors'

const updateCustomerSchema = z.object({
  name: z.string().min(1).optional(),
  phone: z.string().optional(),
  email: z.string().email().optional(),
  address: z.string().optional(),
})

export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const customer = await prisma.customer.findFirst({
      where: { id, storeId },
      include: {
        sales: { orderBy: { saleDate: 'desc' }, take: 10 },
      },
    })

    if (!customer) return notFoundResponse('Customer')
    return successResponse({ customer })
  } catch (error) {
    console.error('Get customer error:', error)
    return errorResponse('Internal server error')
  }
}

export async function PUT(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const body = await request.json()
    const parsed = updateCustomerSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const existing = await prisma.customer.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Customer')

    const customer = await prisma.customer.update({
      where: { id },
      data: parsed.data,
    })

    return successResponse({ customer })
  } catch (error) {
    console.error('Update customer error:', error)
    return errorResponse('Internal server error')
  }
}

export async function DELETE(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const existing = await prisma.customer.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Customer')

    await prisma.customer.delete({ where: { id } })

    return successResponse({ message: 'Customer deleted successfully' })
  } catch (error) {
    console.error('Delete customer error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
