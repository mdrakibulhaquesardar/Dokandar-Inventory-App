import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, validationErrorResponse } from '@/lib/errors'

const createExpenseSchema = z.object({
  title: z.string().min(1, 'Title is required'),
  amount: z.number().positive('Amount must be positive'),
  category: z.string().min(1, 'Category is required'),
  note: z.string().optional(),
  date: z.string().datetime('Invalid date format'),
})

export async function GET(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const { searchParams } = new URL(request.url)
    const page = parseInt(searchParams.get('page') ?? '1')
    const limit = parseInt(searchParams.get('limit') ?? '20')
    const category = searchParams.get('category')
    const from = searchParams.get('from')
    const to = searchParams.get('to')
    const skip = (page - 1) * limit

    const where: Record<string, unknown> = { storeId }
    if (category) where.category = category
    if (from || to) {
      where.date = {
        ...(from ? { gte: new Date(from) } : {}),
        ...(to ? { lte: new Date(to) } : {}),
      }
    }

    const [expenses, total] = await Promise.all([
      prisma.expense.findMany({ where, skip, take: limit, orderBy: { date: 'desc' } }),
      prisma.expense.count({ where }),
    ])

    const totalAmount = expenses.reduce((sum, e) => sum + e.amount, 0)

    return successResponse({
      expenses,
      totalAmount,
      pagination: { page, limit, total, pages: Math.ceil(total / limit) },
    })
  } catch (error) {
    console.error('Get expenses error:', error)
    return errorResponse('Internal server error')
  }
}

export async function POST(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const body = await request.json()
    const parsed = createExpenseSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const expense = await prisma.expense.create({
      data: {
        ...parsed.data,
        date: new Date(parsed.data.date),
        storeId,
      },
    })

    return successResponse({ expense }, 201)
  } catch (error) {
    console.error('Create expense error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
