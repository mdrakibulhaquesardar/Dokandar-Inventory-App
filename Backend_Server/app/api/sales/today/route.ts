import { NextRequest } from 'next/server'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse } from '@/lib/errors'

export async function GET(request: NextRequest) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)

    const now = new Date()
    const startOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate())
    const endOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 1)

    const sales = await prisma.sale.findMany({
      where: {
        storeId,
        saleDate: { gte: startOfDay, lt: endOfDay },
      },
      orderBy: { saleDate: 'desc' },
      include: {
        customer: { select: { id: true, name: true, phone: true } },
        items: true,
      },
    })

    const totalRevenue = sales.reduce((sum, s) => sum + s.paidAmount, 0)
    const totalSales = sales.length

    return successResponse({
      sales,
      summary: {
        totalSales,
        totalRevenue,
        date: startOfDay.toISOString().split('T')[0],
      },
    })
  } catch (error) {
    console.error('Get today sales error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
