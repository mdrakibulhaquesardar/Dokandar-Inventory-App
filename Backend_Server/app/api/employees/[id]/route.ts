import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse, validationErrorResponse } from '@/lib/errors'

const updateEmployeeSchema = z.object({
  name: z.string().min(1).optional(),
  role: z.string().optional(),
  phone: z.string().optional(),
  email: z.string().email().optional(),
  address: z.string().optional(),
  salary: z.number().min(0).optional(),
  paid: z.number().min(0).optional(),
  due: z.number().min(0).optional(),
})

export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const employee = await prisma.employee.findFirst({ where: { id, storeId } })
    if (!employee) return notFoundResponse('Employee')

    return successResponse({ employee })
  } catch (error) {
    console.error('Get employee error:', error)
    return errorResponse('Internal server error')
  }
}

export async function PUT(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const body = await request.json()
    const parsed = updateEmployeeSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const existing = await prisma.employee.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Employee')

    const employee = await prisma.employee.update({ where: { id }, data: parsed.data })

    return successResponse({ employee })
  } catch (error) {
    console.error('Update employee error:', error)
    return errorResponse('Internal server error')
  }
}

export async function DELETE(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const existing = await prisma.employee.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Employee')

    await prisma.employee.delete({ where: { id } })

    return successResponse({ message: 'Employee deleted successfully' })
  } catch (error) {
    console.error('Delete employee error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
