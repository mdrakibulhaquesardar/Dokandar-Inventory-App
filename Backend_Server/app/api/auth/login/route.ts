import { NextRequest } from 'next/server'
import { z } from 'zod'
import bcrypt from 'bcryptjs'
import { prisma } from '@/lib/prisma'
import { signAccessToken, signRefreshToken } from '@/lib/auth'
import { corsOptionsResponse } from '@/lib/cors'
import {
  successResponse,
  errorResponse,
  unauthorizedResponse,
  validationErrorResponse,
} from '@/lib/errors'

const loginSchema = z.object({
  email: z.string().email('Invalid email address'),
  password: z.string().min(1, 'Password is required'),
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const parsed = loginSchema.safeParse(body)

    if (!parsed.success) {
      const error = parsed.error as z.ZodError
      return validationErrorResponse(error.errors[0].message)
    }

    const { email, password } = parsed.data

    // Find user with store info
    const user = await prisma.user.findUnique({
      where: { email },
      include: {
        store: true,
      },
    })

    if (!user || !user.isActive) {
      return unauthorizedResponse('Invalid email or password')
    }

    const isPasswordValid = await bcrypt.compare(password, user.password)
    if (!isPasswordValid) {
      return unauthorizedResponse('Invalid email or password')
    }

    if (!user.storeId) {
      return errorResponse('Account has no associated store', 500)
    }

    // Generate tokens
    const accessToken = await signAccessToken({
      sub: user.id,
      storeId: user.storeId,
      role: user.role,
    })
    const refreshToken = await signRefreshToken({ sub: user.id })

    // Store refresh token
    const expiresAt = new Date()
    expiresAt.setDate(expiresAt.getDate() + 7)
    await prisma.refreshToken.create({
      data: { token: refreshToken, userId: user.id, expiresAt },
    })

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password: _pw, ...userWithoutPassword } = user

    return successResponse({
      accessToken,
      refreshToken,
      user: userWithoutPassword,
      store: user.store,
    })
  } catch (error) {
    console.error('Login error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
