import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, validationErrorResponse } from '@/lib/errors'

const logoutSchema = z.object({
  refreshToken: z.string().min(1, 'Refresh token is required'),
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const parsed = logoutSchema.safeParse(body)

    if (!parsed.success) {
      const error = parsed.error as z.ZodError
      return validationErrorResponse(error.errors[0].message)
    }

    const { refreshToken } = parsed.data

    // Delete the refresh token from DB (invalidate it)
    await prisma.refreshToken.deleteMany({
      where: { token: refreshToken },
    })

    return successResponse({ message: 'Logged out successfully' })
  } catch (error) {
    console.error('Logout error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
