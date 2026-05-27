import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse, validationErrorResponse } from '@/lib/errors'

const updateExpenseSchema = z.object({
  title: z.string().min(1).optional(),
  amount: z.number().positive().optional(),
  category: z.string().min(1).optional(),
  note: z.string().optional(),
  date: z.string().datetime().optional(),
})

export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const expense = await prisma.expense.findFirst({ where: { id, storeId } })
    if (!expense) return notFoundResponse('Expense')

    return successResponse({ expense })
  } catch (error) {
    console.error('Get expense error:', error)
    return errorResponse('Internal server error')
  }
}

export async function PUT(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const body = await request.json()
    const parsed = updateExpenseSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const existing = await prisma.expense.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Expense')

    const expense = await prisma.expense.update({
      where: { id },
      data: {
        ...parsed.data,
        ...(parsed.data.date ? { date: new Date(parsed.data.date) } : {}),
      },
    })

    return successResponse({ expense })
  } catch (error) {
    console.error('Update expense error:', error)
    return errorResponse('Internal server error')
  }
}

export async function DELETE(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const existing = await prisma.expense.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Expense')

    await prisma.expense.delete({ where: { id } })

    return successResponse({ message: 'Expense deleted successfully' })
  } catch (error) {
    console.error('Delete expense error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
