const BASE_URL = typeof window !== 'undefined' ? '' : (process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3000')

function getToken(): string | null {
  if (typeof window === 'undefined') return null
  return localStorage.getItem('dokandar_token')
}

function getHeaders(): HeadersInit {
  const headers: HeadersInit = { 'Content-Type': 'application/json' }
  const token = getToken()
  if (token) (headers as Record<string, string>)['Authorization'] = `Bearer ${token}`
  return headers
}

export async function apiGet<T = unknown>(path: string): Promise<{ success: boolean; data: T; error?: string }> {
  try {
    const res = await fetch(`${BASE_URL}/api${path}`, { headers: getHeaders() })
    return res.json()
  } catch {
    return { success: false, data: null as T, error: 'Network error' }
  }
}

export async function apiPost<T = unknown>(path: string, body: unknown): Promise<{ success: boolean; data: T; error?: string }> {
  try {
    const res = await fetch(`${BASE_URL}/api${path}`, {
      method: 'POST',
      headers: getHeaders(),
      body: JSON.stringify(body)
    })
    return res.json()
  } catch {
    return { success: false, data: null as T, error: 'Network error' }
  }
}

export async function apiPut<T = unknown>(path: string, body: unknown): Promise<{ success: boolean; data: T; error?: string }> {
  try {
    const res = await fetch(`${BASE_URL}/api${path}`, {
      method: 'PUT',
      headers: getHeaders(),
      body: JSON.stringify(body)
    })
    return res.json()
  } catch {
    return { success: false, data: null as T, error: 'Network error' }
  }
}

export async function apiDelete<T = unknown>(path: string): Promise<{ success: boolean; data: T; error?: string }> {
  try {
    const res = await fetch(`${BASE_URL}/api${path}`, {
      method: 'DELETE',
      headers: getHeaders()
    })
    return res.json()
  } catch {
    return { success: false, data: null as T, error: 'Network error' }
  }
}

export function saveToken(token: string, refreshToken: string) {
  localStorage.setItem('dokandar_token', token)
  localStorage.setItem('dokandar_refresh_token', refreshToken)
}

export function clearTokens() {
  localStorage.removeItem('dokandar_token')
  localStorage.removeItem('dokandar_refresh_token')
  localStorage.removeItem('dokandar_user')
}

export function saveUser(user: unknown) {
  localStorage.setItem('dokandar_user', JSON.stringify(user))
}

export function getUser<T = unknown>(): T | null {
  if (typeof window === 'undefined') return null
  const u = localStorage.getItem('dokandar_user')
  return u ? JSON.parse(u) : null
}
