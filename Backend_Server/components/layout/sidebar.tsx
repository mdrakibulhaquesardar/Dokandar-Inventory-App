'use client'

import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import {
  LayoutDashboard, Package, BarChart3, ShoppingCart, Users, Truck,
  UserSquare2, Receipt, TrendingUp, Bell, Settings, Store, LogOut, X, ChevronRight
} from 'lucide-react'
import { clearTokens, getUser } from '@/lib/api-client'

const NAV_ITEMS = [
  { href: '/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
  { href: '/dashboard/products', icon: Package, label: 'Products' },
  { href: '/dashboard/inventory', icon: BarChart3, label: 'Inventory' },
  { href: '/dashboard/sales', icon: ShoppingCart, label: 'Sales' },
  { href: '/dashboard/customers', icon: Users, label: 'Customers' },
  { href: '/dashboard/suppliers', icon: Truck, label: 'Suppliers' },
  { href: '/dashboard/employees', icon: UserSquare2, label: 'Employees' },
  { href: '/dashboard/expenses', icon: Receipt, label: 'Expenses' },
  { href: '/dashboard/analytics', icon: TrendingUp, label: 'Analytics' },
  { href: '/dashboard/notifications', icon: Bell, label: 'Notifications' },
  { href: '/dashboard/settings', icon: Settings, label: 'Settings' },
]

interface SidebarProps {
  mobileOpen?: boolean
  onClose?: () => void
}

export function Sidebar({ mobileOpen, onClose }: SidebarProps) {
  const pathname = usePathname()
  const router = useRouter()
  const user = getUser<{ name: string; email: string }>()

  function handleLogout() {
    clearTokens()
    router.push('/auth/login')
  }

  function isActive(href: string) {
    if (href === '/dashboard') return pathname === '/dashboard'
    return pathname.startsWith(href)
  }

  return (
    <>
      {/* Mobile overlay */}
      {mobileOpen && (
        <div className="fixed inset-0 bg-black/60 z-40 lg:hidden" onClick={onClose} />
      )}

      {/* Sidebar */}
      <aside className={`
        fixed top-0 left-0 h-full w-64 z-50 flex flex-col
        bg-[#0d1627] border-r border-[#334155]
        transition-transform duration-300 ease-in-out
        ${mobileOpen ? 'translate-x-0' : '-translate-x-full lg:translate-x-0'}
      `}>
        {/* Brand */}
        <div className="flex items-center justify-between p-5 border-b border-[#334155]">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-lg gradient-accent flex items-center justify-center flex-shrink-0">
              <Store className="w-5 h-5 text-white" />
            </div>
            <div>
              <p className="text-sm font-bold text-white">Dokandar</p>
              <p className="text-xs text-emerald-400">Admin Panel</p>
            </div>
          </div>
          {onClose && (
            <button onClick={onClose} className="lg:hidden p-1 text-slate-400 hover:text-white transition-colors">
              <X className="w-5 h-5" />
            </button>
          )}
        </div>

        {/* Navigation */}
        <nav className="flex-1 overflow-y-auto py-4 px-3 space-y-1">
          {NAV_ITEMS.map(({ href, icon: Icon, label }) => (
            <Link
              key={href}
              href={href}
              onClick={onClose}
              className={`sidebar-item ${isActive(href) ? 'active' : ''}`}
            >
              <Icon className="w-4 h-4 flex-shrink-0" />
              <span className="flex-1">{label}</span>
              {isActive(href) && <ChevronRight className="w-3 h-3 opacity-60" />}
            </Link>
          ))}
        </nav>

        {/* User Footer */}
        <div className="p-4 border-t border-[#334155]">
          {user && (
            <div className="flex items-center gap-3 mb-3 px-2">
              <div className="w-8 h-8 rounded-full bg-emerald-500/20 border border-emerald-500/30 flex items-center justify-center flex-shrink-0">
                <span className="text-sm font-semibold text-emerald-400">
                  {user.name?.[0]?.toUpperCase() || 'A'}
                </span>
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-sm font-medium text-white truncate">{user.name || 'Admin'}</p>
                <p className="text-xs text-slate-500 truncate">{user.email || ''}</p>
              </div>
            </div>
          )}
          <button
            onClick={handleLogout}
            className="w-full flex items-center gap-3 px-3 py-2.5 rounded-lg text-slate-400 hover:text-red-400 hover:bg-red-500/10 transition-all text-sm font-medium group"
          >
            <LogOut className="w-4 h-4 group-hover:rotate-12 transition-transform" />
            Sign Out
          </button>
        </div>
      </aside>
    </>
  )
}
