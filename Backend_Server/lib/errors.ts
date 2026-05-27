import { NextResponse } from 'next/server'
import { addCorsHeaders } from './cors'

export function successResponse(data: unknown, status = 200): NextResponse {
  return addCorsHeaders(
    NextResponse.json({ success: true, data }, { status })
  )
}

export function errorResponse(message: string, status = 500): NextResponse {
  return addCorsHeaders(
    NextResponse.json({ success: false, error: message }, { status })
  )
}

export function notFoundResponse(resource = 'Resource'): NextResponse {
  return errorResponse(`${resource} not found`, 404)
}

export function unauthorizedResponse(message = 'Unauthorized'): NextResponse {
  return errorResponse(message, 401)
}

export function forbiddenResponse(message = 'Forbidden'): NextResponse {
  return errorResponse(message, 403)
}

export function validationErrorResponse(message: string): NextResponse {
  return errorResponse(message, 400)
}

export function conflictResponse(message: string): NextResponse {
  return errorResponse(message, 409)
}
