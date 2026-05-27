import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse, validationErrorResponse } from '@/lib/errors'

const updateSaleSchema = z.object({
  paidAmount: z.number().min(0).optional(),
  notes: z.string().optional(),
  isCompleted: z.boolean().optional(),
})

export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const sale = await prisma.sale.findFirst({
      where: { id, storeId },
      include: {
        customer: true,
        items: {
          include: { product: { select: { id: true, name: true, sku: true } } },
        },
      },
    })

    if (!sale) return notFoundResponse('Sale')
    return successResponse({ sale })
  } catch (error) {
    console.error('Get sale error:', error)
    return errorResponse('Internal server error')
  }
}

export async function PUT(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const body = await request.json()
    const parsed = updateSaleSchema.safeParse(body)
    if (!parsed.success) return validationErrorResponse(parsed.error.errors[0].message)

    const existing = await prisma.sale.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Sale')

    const { paidAmount, notes, isCompleted } = parsed.data

    const updatedSale = await prisma.$transaction(async (tx) => {
      if (paidAmount !== undefined) {
        const additionalPayment = paidAmount - existing.paidAmount
        const newDue = existing.dueAmount - additionalPayment

        const sale = await tx.sale.update({
          where: { id },
          data: {
            paidAmount,
            dueAmount: Math.max(0, newDue),
            notes,
            isCompleted,
          },
        })

        // Update customer totals
        if (additionalPayment !== 0) {
          await tx.customer.update({
            where: { id: existing.customerId },
            data: {
              totalPaid: { increment: additionalPayment },
              totalDue: { decrement: additionalPayment },
            },
          })
        }

        return sale
      }

      return tx.sale.update({
        where: { id },
        data: { notes, isCompleted },
      })
    })

    return successResponse({ sale: updatedSale })
  } catch (error) {
    console.error('Update sale error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
