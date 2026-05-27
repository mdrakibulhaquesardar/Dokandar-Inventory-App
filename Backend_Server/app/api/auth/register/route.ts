import { NextRequest } from 'next/server'
import { z } from 'zod'
import bcrypt from 'bcryptjs'
import { prisma } from '@/lib/prisma'
import { signAccessToken, signRefreshToken } from '@/lib/auth'
import { corsOptionsResponse } from '@/lib/cors'
import {
  successResponse,
  errorResponse,
  conflictResponse,
  validationErrorResponse,
} from '@/lib/errors'

const registerSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Invalid email address'),
  phone: z.string().optional(),
  password: z.string().min(6, 'Password must be at least 6 characters'),
  storeName: z.string().min(2, 'Store name must be at least 2 characters'),
  storeAddress: z.string().min(5, 'Store address must be at least 5 characters'),
  storePhone: z.string().min(5, 'Store phone is required'),
  storeEmail: z.string().email('Invalid store email').optional(),
  businessType: z.string().min(1, 'Business type is required'),
})

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const parsed = registerSchema.safeParse(body)

    if (!parsed.success) {
      const error = parsed.error as z.ZodError
      return validationErrorResponse(error.errors[0].message)
    }

    const { name, email, phone, password, storeName, storeAddress, storePhone, storeEmail, businessType } = parsed.data

    // Check email uniqueness
    const existing = await prisma.user.findUnique({ where: { email } })
    if (existing) {
      return conflictResponse('Email is already registered')
    }

    const hashedPassword = await bcrypt.hash(password, 12)

    // Create user and store atomically
    const { user, store } = await prisma.$transaction(async (tx) => {
      const user = await tx.user.create({
        data: {
          name,
          email,
          phone,
          password: hashedPassword,
          role: 'OWNER',
        },
      })

      const store = await tx.store.create({
        data: {
          name: storeName,
          address: storeAddress,
          phone: storePhone,
          email: storeEmail ?? email,
          businessType,
          ownerId: user.id,
        },
      })

      const updatedUser = await tx.user.update({
        where: { id: user.id },
        data: { storeId: store.id },
      })

      return { user: updatedUser, store }
    })

    // Generate tokens
    const accessToken = await signAccessToken({ sub: user.id, storeId: store.id, role: 'OWNER' })
    const refreshToken = await signRefreshToken({ sub: user.id })

    // Store refresh token in DB
    const expiresAt = new Date()
    expiresAt.setDate(expiresAt.getDate() + 7)
    await prisma.refreshToken.create({
      data: { token: refreshToken, userId: user.id, expiresAt },
    })

    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    const { password: _pw, ...userWithoutPassword } = user

    return successResponse(
      {
        accessToken,
        refreshToken,
        user: { ...userWithoutPassword, storeId: store.id },
        store,
      },
      201
    )
  } catch (error) {
    console.error('Register error:', error)
    return errorResponse('Internal server error')
  }
}

export async function OPTIONS() {
  return corsOptionsResponse()
}
