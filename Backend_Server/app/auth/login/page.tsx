'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { Eye, EyeOff, Loader2, Store, CheckCircle2, TrendingUp, Package, Users } from 'lucide-react'
import { apiPost, saveToken, saveUser } from '@/lib/api-client'

export default function LoginPage() {
  const router = useRouter()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [showPwd, setShowPwd] = useState(false)
  const [remember, setRemember] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError('')
    setLoading(true)

    try {
      const res = await apiPost('/auth/login', { email, password })
      if (res.success && res.data) {
        const d = res.data as { token: string; refreshToken: string; user: unknown }
        saveToken(d.token, d.refreshToken)
        saveUser(d.user)
        router.push('/dashboard')
      } else {
        setError(res.error || 'Invalid credentials. Please try again.')
      }
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen animated-gradient flex">
      {/* Left Panel */}
      <div className="hidden lg:flex lg:w-1/2 flex-col justify-center px-16 relative overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-emerald-900/30 to-transparent pointer-events-none" />
        <div className="relative z-10">
          {/* Logo */}
          <div className="flex items-center gap-3 mb-12">
            <div className="w-12 h-12 rounded-xl gradient-accent flex items-center justify-center">
              <Store className="w-6 h-6 text-white" />
            </div>
            <div>
              <h1 className="text-2xl font-bold text-white">Dokandar</h1>
              <p className="text-xs text-emerald-400 font-medium">Admin Dashboard</p>
            </div>
          </div>

          <h2 className="text-4xl font-bold text-white mb-4 leading-tight">
            Manage Your Shop<br />
            <span className="text-emerald-400">Effortlessly</span>
          </h2>
          <p className="text-slate-400 text-lg mb-12 max-w-md">
            Complete shop management solution for Bangladeshi retailers. Track inventory, sales, customers, and grow your business.
          </p>

          {/* Feature List */}
          <div className="space-y-4">
            {[
              { icon: <TrendingUp className="w-5 h-5" />, text: 'Real-time sales analytics & revenue tracking' },
              { icon: <Package className="w-5 h-5" />, text: 'Smart inventory management with low-stock alerts' },
              { icon: <Users className="w-5 h-5" />, text: 'Customer & supplier relationship management' },
              { icon: <CheckCircle2 className="w-5 h-5" />, text: 'Automated due tracking for customers & employees' },
            ].map((f, i) => (
              <div key={i} className="flex items-center gap-3">
                <div className="p-2 rounded-lg bg-emerald-500/20 text-emerald-400">{f.icon}</div>
                <span className="text-slate-300 text-sm">{f.text}</span>
              </div>
            ))}
          </div>

          {/* Stats Row */}
          <div className="mt-12 flex gap-8">
            {[
              { label: 'Active Shops', value: '10K+' },
              { label: 'Transactions', value: '1M+' },
              { label: 'Uptime', value: '99.9%' },
            ].map((s, i) => (
              <div key={i}>
                <p className="text-2xl font-bold text-emerald-400">{s.value}</p>
                <p className="text-xs text-slate-500">{s.label}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Right Panel — Login Form */}
      <div className="w-full lg:w-1/2 flex items-center justify-center px-6 py-12">
        <div className="w-full max-w-md">
          {/* Mobile Logo */}
          <div className="flex lg:hidden items-center gap-3 mb-10 justify-center">
            <div className="w-10 h-10 rounded-xl gradient-accent flex items-center justify-center">
              <Store className="w-5 h-5 text-white" />
            </div>
            <span className="text-xl font-bold text-white">Dokandar</span>
          </div>

          <div className="glass-card p-8 animate-fade-in">
            <h3 className="text-2xl font-bold text-white mb-2">Welcome back</h3>
            <p className="text-slate-400 text-sm mb-8">Sign in to your admin dashboard</p>

            {error && (
              <div className="mb-6 p-4 rounded-xl bg-red-500/10 border border-red-500/20 text-red-400 text-sm flex items-start gap-2">
                <span className="mt-0.5">⚠️</span>
                <span>{error}</span>
              </div>
            )}

            <form onSubmit={handleSubmit} className="space-y-5">
              <div>
                <label className="block text-sm font-medium text-slate-300 mb-2">Email Address</label>
                <input
                  type="email"
                  className="input-dark"
                  placeholder="admin@yourshop.com"
                  value={email}
                  onChange={e => setEmail(e.target.value)}
                  required
                  autoComplete="email"
                />
              </div>

              <div>
                <div className="flex items-center justify-between mb-2">
                  <label className="text-sm font-medium text-slate-300">Password</label>
                  <Link href="/auth/forgot-password" className="text-xs text-emerald-400 hover:text-emerald-300 transition-colors">
                    Forgot password?
                  </Link>
                </div>
                <div className="relative">
                  <input
                    type={showPwd ? 'text' : 'password'}
                    className="input-dark pr-12"
                    placeholder="Enter your password"
                    value={password}
                    onChange={e => setPassword(e.target.value)}
                    required
                    autoComplete="current-password"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPwd(!showPwd)}
                    className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-200 transition-colors"
                  >
                    {showPwd ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                  </button>
                </div>
              </div>

              <div className="flex items-center gap-2">
                <input
                  type="checkbox"
                  id="remember"
                  checked={remember}
                  onChange={e => setRemember(e.target.checked)}
                  className="w-4 h-4 rounded border-slate-600 accent-emerald-500"
                />
                <label htmlFor="remember" className="text-sm text-slate-400 cursor-pointer select-none">
                  Remember me for 30 days
                </label>
              </div>

              <button type="submit" className="btn-primary" disabled={loading}>
                {loading ? (
                  <>
                    <Loader2 className="w-4 h-4 animate-spin" />
                    Signing in...
                  </>
                ) : (
                  'Sign In'
                )}
              </button>
            </form>

            <p className="mt-6 text-center text-sm text-slate-400">
              Don&apos;t have an account?{' '}
              <Link href="/auth/register" className="text-emerald-400 hover:text-emerald-300 font-medium transition-colors">
                Create one free
              </Link>
            </p>
          </div>

          <p className="mt-8 text-center text-xs text-slate-600">
            Protected by enterprise-grade security • SSL encrypted
          </p>
        </div>
      </div>
    </div>
  )
}
