'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { Eye, EyeOff, Loader2, Store, ChevronDown } from 'lucide-react'
import { apiPost, saveToken, saveUser } from '@/lib/api-client'

const BUSINESS_TYPES = ['Retail', 'Wholesale', 'Restaurant', 'Service', 'Other']

export default function RegisterPage() {
  const router = useRouter()
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [showPwd, setShowPwd] = useState(false)
  const [showConfirm, setShowConfirm] = useState(false)

  const [form, setForm] = useState({
    name: '', email: '', phone: '', password: '', confirmPassword: '',
    storeName: '', storeAddress: '', storePhone: '', businessType: 'Retail',
  })

  const update = (field: string, val: string) => setForm(f => ({ ...f, [field]: val }))

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    setError('')

    if (form.password !== form.confirmPassword) {
      setError('Passwords do not match.')
      return
    }
    if (form.password.length < 8) {
      setError('Password must be at least 8 characters.')
      return
    }

    setLoading(true)
    try {
      const res = await apiPost('/auth/register', {
        name: form.name,
        email: form.email,
        phone: form.phone,
        password: form.password,
        storeName: form.storeName,
        storeAddress: form.storeAddress,
        storePhone: form.storePhone,
        businessType: form.businessType,
      })
      if (res.success && res.data) {
        const d = res.data as { token: string; refreshToken: string; user: unknown }
        saveToken(d.token, d.refreshToken)
        saveUser(d.user)
        router.push('/dashboard')
      } else {
        setError(res.error || 'Registration failed. Please try again.')
      }
    } catch {
      setError('Something went wrong. Please try again.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen animated-gradient flex items-center justify-center px-4 py-12">
      <div className="w-full max-w-2xl">
        {/* Header */}
        <div className="text-center mb-8">
          <div className="flex items-center justify-center gap-3 mb-4">
            <div className="w-12 h-12 rounded-xl gradient-accent flex items-center justify-center">
              <Store className="w-6 h-6 text-white" />
            </div>
            <span className="text-2xl font-bold text-white">Dokandar</span>
          </div>
          <h2 className="text-3xl font-bold text-white mb-2">Create your account</h2>
          <p className="text-slate-400">Set up your shop management dashboard in minutes</p>
        </div>

        <div className="glass-card p-8 animate-fade-in">
          {error && (
            <div className="mb-6 p-4 rounded-xl bg-red-500/10 border border-red-500/20 text-red-400 text-sm">
              ⚠️ {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-6">
            {/* Personal Info */}
            <div>
              <h3 className="text-sm font-semibold text-emerald-400 uppercase tracking-wider mb-4 flex items-center gap-2">
                <span className="w-6 h-6 rounded-full bg-emerald-500/20 flex items-center justify-center text-xs">1</span>
                Personal Information
              </h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Full Name *</label>
                  <input
                    type="text" className="input-dark" placeholder="Ahmed Rahman"
                    value={form.name} onChange={e => update('name', e.target.value)} required
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Email Address *</label>
                  <input
                    type="email" className="input-dark" placeholder="ahmed@example.com"
                    value={form.email} onChange={e => update('email', e.target.value)} required
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Phone Number *</label>
                  <input
                    type="tel" className="input-dark" placeholder="+880 1XXX-XXXXXX"
                    value={form.phone} onChange={e => update('phone', e.target.value)} required
                  />
                </div>
                <div />
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Password *</label>
                  <div className="relative">
                    <input
                      type={showPwd ? 'text' : 'password'} className="input-dark pr-12"
                      placeholder="Min. 8 characters"
                      value={form.password} onChange={e => update('password', e.target.value)} required
                    />
                    <button type="button" onClick={() => setShowPwd(!showPwd)}
                      className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-200">
                      {showPwd ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                    </button>
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Confirm Password *</label>
                  <div className="relative">
                    <input
                      type={showConfirm ? 'text' : 'password'} className="input-dark pr-12"
                      placeholder="Re-enter password"
                      value={form.confirmPassword} onChange={e => update('confirmPassword', e.target.value)} required
                    />
                    <button type="button" onClick={() => setShowConfirm(!showConfirm)}
                      className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-200">
                      {showConfirm ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                    </button>
                  </div>
                </div>
              </div>
            </div>

            <div className="border-t border-slate-700" />

            {/* Store Info */}
            <div>
              <h3 className="text-sm font-semibold text-emerald-400 uppercase tracking-wider mb-4 flex items-center gap-2">
                <span className="w-6 h-6 rounded-full bg-emerald-500/20 flex items-center justify-center text-xs">2</span>
                Store Information
              </h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Store Name *</label>
                  <input
                    type="text" className="input-dark" placeholder="Rahman Electronics"
                    value={form.storeName} onChange={e => update('storeName', e.target.value)} required
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Business Type *</label>
                  <div className="relative">
                    <select
                      className="input-dark appearance-none cursor-pointer pr-10"
                      value={form.businessType}
                      onChange={e => update('businessType', e.target.value)}
                    >
                      {BUSINESS_TYPES.map(t => <option key={t} value={t}>{t}</option>)}
                    </select>
                    <ChevronDown className="absolute right-4 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Store Phone</label>
                  <input
                    type="tel" className="input-dark" placeholder="+880 1XXX-XXXXXX"
                    value={form.storePhone} onChange={e => update('storePhone', e.target.value)}
                  />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-2">Store Address</label>
                  <input
                    type="text" className="input-dark" placeholder="Dhaka, Bangladesh"
                    value={form.storeAddress} onChange={e => update('storeAddress', e.target.value)}
                  />
                </div>
              </div>
            </div>

            <button type="submit" className="btn-primary" disabled={loading}>
              {loading ? (
                <><Loader2 className="w-4 h-4 animate-spin" /> Creating account...</>
              ) : (
                'Create Account & Start Managing'
              )}
            </button>

            <p className="text-center text-sm text-slate-400">
              Already have an account?{' '}
              <Link href="/auth/login" className="text-emerald-400 hover:text-emerald-300 font-medium transition-colors">
                Sign in
              </Link>
            </p>

            <p className="text-center text-xs text-slate-600">
              By creating an account, you agree to our Terms of Service and Privacy Policy.
            </p>
          </form>
        </div>
      </div>
    </div>
  )
}
