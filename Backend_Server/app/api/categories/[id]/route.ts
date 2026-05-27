import { NextRequest } from 'next/server'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse } from '@/lib/errors'

export async function GET(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const category = await prisma.category.findFirst({ where: { id, storeId } })
    if (!category) return notFoundResponse('Category')

    return successResponse({ category })
  } catch (error) {
    console.error('Get category error:', error)
    return errorResponse('Internal server error')
  }
}

export async function DELETE(request: NextRequest, { params }: { params: Promise<{ id: string }> }) {
  try {
    const storeId = request.headers.get('x-store-id')
    if (!storeId) return errorResponse('Store ID missing', 401)
    const { id } = await params

    const existing = await prisma.category.findFirst({ where: { id, storeId } })
    if (!existing) return notFoundResponse('Category')

    await prisma.category.delete({ where: { id } })

    return successResponse({ message: 'Category deleted successfully' })
  } catch (error) {
    console.error('Delete category error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
