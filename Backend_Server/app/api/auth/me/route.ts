import { NextRequest } from 'next/server'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, notFoundResponse } from '@/lib/errors'

export async function GET(request: NextRequest) {
  try {
    const userId = request.headers.get('x-user-id')
    if (!userId) {
      return errorResponse('User ID not found in request context', 401)
    }

    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: { store: true },
    })

    if (!user) {
      return notFoundResponse('User')
    }

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password: _pw, ...userWithoutPassword } = user

    return successResponse({ user: userWithoutPassword, store: user.store })
  } catch (error) {
    console.error('Get me error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
