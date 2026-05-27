import { NextRequest } from 'next/server'
import { z } from 'zod'
import { prisma } from '@/lib/prisma'
import { signAccessToken, verifyRefreshToken } from '@/lib/auth'
import { corsOptionsResponse } from '@/lib/cors'
import { successResponse, errorResponse, unauthorizedResponse, validationErrorResponse } from '@/lib/errors'

const refreshSchema = z.object({
  refreshToken: z.string().min(1, 'Refresh token is required'),
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const parsed = refreshSchema.safeParse(body)

    if (!parsed.success) {
      const error = parsed.error as z.ZodError
      return validationErrorResponse(error.errors[0].message)
    }

    const { refreshToken } = parsed.data

    // Verify the refresh token signature and expiry
    let payload: { sub: string }
    try {
      payload = await verifyRefreshToken(refreshToken) as { sub: string }
    } catch {
      return unauthorizedResponse('Invalid or expired refresh token')
    }

    // Check token exists in DB
    const storedToken = await prisma.refreshToken.findUnique({
      where: { token: refreshToken },
      include: { user: true },
    })

    if (!storedToken || storedToken.expiresAt < new Date()) {
      return unauthorizedResponse('Refresh token is invalid or has expired')
    }

    if (storedToken.userId !== payload.sub) {
      return unauthorizedResponse('Token mismatch')
    }

    const user = storedToken.user

    if (!user.isActive || !user.storeId) {
      return unauthorizedResponse('Account is inactive')
    }

    // Generate new access token
    const accessToken = await signAccessToken({
      sub: user.id,
      storeId: user.storeId,
      role: user.role,
    })

    return successResponse({ accessToken })
  } catch (error) {
    console.error('Refresh error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
