import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, validationErrorResponse } from '@/lib/errors'

const createEmployeeSchema = z.object({
  employeeCode: z.string().min(1, 'Employee code is required'),
  name: z.string().min(1, 'Employee name is required'),
  role: z.string().optional(),
  phone: z.string().optional(),
  email: z.string().email().optional(),
  address: z.string().optional(),
  salary: z.number().min(0).default(0),
  joinedAt: z.string().datetime().optional(),
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
        { employeeCode: { contains: q, mode: 'insensitive' } },
        { role: { contains: q, mode: 'insensitive' } },
      ]
    }

    const [employees, total] = await Promise.all([
      prisma.employee.findMany({ where, skip, take: limit, orderBy: { name: 'asc' } }),
      prisma.employee.count({ where }),
    ])

    return successResponse({
      employees,
      pagination: { page, limit, total, pages: Math.ceil(total / limit) },
    })
  } catch (error) {
    console.error('Get employees error:', error)
    return errorResponse('Internal server error')
  }
}

export async function POST(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const body = await request.json()
    const parsed = createEmployeeSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const { employeeCode } = parsed.data

    const existing = await prisma.employee.findUnique({
      where: { employeeCode_storeId: { employeeCode, storeId } },
    })
    if (existing) return errorResponse('Employee code already exists in this store', 409)

    const employee = await prisma.employee.create({
      data: {
        ...parsed.data,
        storeId,
        joinedAt: parsed.data.joinedAt ? new Date(parsed.data.joinedAt) : new Date(),
      },
    })

    return successResponse({ employee }, 201)
  } catch (error) {
    console.error('Create employee error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
