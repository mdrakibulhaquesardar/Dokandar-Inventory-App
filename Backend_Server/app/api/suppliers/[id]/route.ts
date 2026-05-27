import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse, validationErrorResponse } from '@/lib/errors'

const updateSupplierSchema = z.object({
  name: z.string().min(1).optional(),
  company: z.string().optional(),
  phone: z.string().optional(),
  email: z.string().email().optional(),
  address: z.string().optional(),
  totalPurchase: z.number().min(0).optional(),
  totalPaid: z.number().min(0).optional(),
  totalDue: z.number().min(0).optional(),
})

export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const supplier = await prisma.supplier.findFirst({ where: { id, storeId } })
    if (!supplier) return notFoundResponse('Supplier')

    return successResponse({ supplier })
  } catch (error) {
    console.error('Get supplier error:', error)
    return errorResponse('Internal server error')
  }
}

export async function PUT(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const body = await request.json()
    const parsed = updateSupplierSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const existing = await prisma.supplier.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Supplier')

    const supplier = await prisma.supplier.update({ where: { id }, data: parsed.data })

    return successResponse({ supplier })
  } catch (error) {
    console.error('Update supplier error:', error)
    return errorResponse('Internal server error')
  }
}

export async function DELETE(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const existing = await prisma.supplier.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Supplier')

    await prisma.supplier.delete({ where: { id } })

    return successResponse({ message: 'Supplier deleted successfully' })
  } catch (error) {
    console.error('Delete supplier error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
