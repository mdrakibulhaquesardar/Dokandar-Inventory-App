import { z } from 'zod'

export function parseBody<T>(schema: z.ZodSchema<T>, data: unknown): { data: T; error: null } | { data: null; error: string } {
  const result = schema.safeParse(data)
  if (!result.success) {
    const error = result.error as z.ZodError;
    return { data: null, error: error.errors[0]?.message ?? 'Validation failed' }
  }
  return { data: result.data, error: null }
}

// Common reusable schemas
export const paginationSchema = z.object({
  page: z.coerce.number().int().min(1).default(1),
  limit: z.coerce.number().int().min(1).max(100).default(20),
})

export const idParamSchema = z.object({
  id: z.string().min(1),
})
