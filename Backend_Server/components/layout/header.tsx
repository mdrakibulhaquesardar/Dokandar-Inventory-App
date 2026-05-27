'use client'

import { usePathname } from 'next/navigation'
import { Bell, Menu, Search } from 'lucide-react'
import { getUser } from '@/lib/api-client'

const PAGE_TITLES: Record<string, string> = {
  '/dashboard': 'Dashboard Overview',
  '/dashboard/products': 'Products',
  '/dashboard/inventory': 'Inventory Management',
  '/dashboard/sales': 'Sales History',
  '/dashboard/customers': 'Customers',
  '/dashboard/suppliers': 'Suppliers',
  '/dashboard/employees': 'Employees',
  '/dashboard/expenses': 'Expenses',
  '/dashboard/analytics': 'Analytics',
  '/dashboard/notifications': 'Notifications',
  '/dashboard/settings': 'Settings',
}

interface HeaderProps {
  onMenuClick: () => void
  notifCount?: number
}

export function Header({ onMenuClick, notifCount = 0 }: HeaderProps) {
  const pathname = usePathname()
  const user = getUser<{ name: string; email: string }>()

  const title = Object.entries(PAGE_TITLES)
    .filter(([path]) => pathname.startsWith(path))
    .sort((a, b) => b[0].length - a[0].length)[0]?.[1] || 'Dashboard'

  return (
    <header className="h-16 bg-[#0d1627]/80 backdrop-blur-md border-b border-[#334155] flex items-center px-4 gap-4 sticky top-0 z-30">
      {/* Mobile menu button */}
      <button
        onClick={onMenuClick}
        className="lg:hidden p-2 rounded-lg text-slate-400 hover:text-white hover:bg-[#1e293b] transition-colors"
      >
        <Menu className="w-5 h-5" />
      </button>

      {/* Page title */}
      <div className="flex-1">
        <h1 className="text-base font-semibold text-white">{title}</h1>
      </div>

      {/* Search (decorative for now) */}
      <div className="hidden md:flex items-center gap-2 bg-[#1e293b] border border-[#334155] rounded-xl px-3 py-2 text-sm text-slate-500 w-56 hover:border-emerald-500/30 transition-colors cursor-pointer">
        <Search className="w-4 h-4" />
        <span>Quick search...</span>
        <span className="ml-auto text-xs bg-[#334155] px-1.5 py-0.5 rounded text-slate-500">⌘K</span>
      </div>

      {/* Notifications */}
      <button className="relative p-2 rounded-xl text-slate-400 hover:text-white hover:bg-[#1e293b] transition-colors">
        <Bell className="w-5 h-5" />
        {notifCount > 0 && (
          <span className="absolute top-1 right-1 w-4 h-4 bg-emerald-500 rounded-full text-xs text-white flex items-center justify-center font-bold">
            {notifCount > 9 ? '9+' : notifCount}
          </span>
        )}
      </button>

      {/* User Avatar */}
      <div className="flex items-center gap-2.5 pl-2 border-l border-[#334155]">
        <div className="w-8 h-8 rounded-full bg-emerald-500/20 border border-emerald-500/30 flex items-center justify-center">
          <span className="text-sm font-semibold text-emerald-400">
            {user?.name?.[0]?.toUpperCase() || 'A'}
          </span>
        </div>
        <div className="hidden sm:block">
          <p className="text-sm font-medium text-white leading-tight">{user?.name || 'Admin'}</p>
          <p className="text-xs text-slate-500 leading-tight">Administrator</p>
        </div>
      </div>
    </header>
  )
}
