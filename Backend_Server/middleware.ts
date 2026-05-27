import { NextRequest, NextResponse } from 'next/server'
import { verifyAccessToken } from './lib/auth'

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl

  // Skip auth routes
  if (pathname.startsWith('/api/auth') || pathname.startsWith('/_next')) {
    return NextResponse.next()
  }

  // Handle CORS preflight
  if (request.method === 'OPTIONS') {
    const response = new NextResponse(null, { status: 204 })
    response.headers.set('Access-Control-Allow-Origin', '*')
    response.headers.set('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS')
    response.headers.set('Access-Control-Allow-Headers', 'Content-Type, Authorization')
    return response
  }

  // Protect all /api/* routes
  if (pathname.startsWith('/api/')) {
    const authHeader = request.headers.get('authorization')

    if (!authHeader?.startsWith('Bearer ')) {
      return NextResponse.json(
        { success: false, error: 'Unauthorized: Missing or invalid Authorization header' },
        {
          status: 401,
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          },
        }
      )
    }

    try {
      const token = authHeader.substring(7)
      const payload = await verifyAccessToken(token)

      const requestHeaders = new Headers(request.headers)
      requestHeaders.set('x-user-id', payload.sub ?? '')
      requestHeaders.set('x-store-id', payload.storeId ?? '')
      requestHeaders.set('x-user-role', payload.role ?? '')

      return NextResponse.next({ request: { headers: requestHeaders } })
    } catch {
      return NextResponse.json(
        { success: false, error: 'Unauthorized: Invalid or expired token' },
        {
          status: 401,
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          },
        }
      )
    }
  }

  return NextResponse.next()
}

export const config = {
  matcher: ['/api/:path*'],
}
