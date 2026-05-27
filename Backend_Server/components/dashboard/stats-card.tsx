'use client'

import { TrendingUp, TrendingDown } from 'lucide-react'

interface StatsCardProps {
  title: string
  value: string | number
  icon: React.ReactNode
  iconBg: string
  trend?: number
  subtitle?: string
}

export function StatsCard({ title, value, icon, iconBg, trend, subtitle }: StatsCardProps) {
  return (
    <div className="glass-card p-6 hover:scale-[1.02] hover:border-emerald-500/30 transition-all duration-200 cursor-default group">
      <div className="flex items-start justify-between">
        <div className="flex-1 min-w-0">
          <p className="text-[#64748b] text-sm font-medium mb-1 truncate">{title}</p>
          <p className="text-2xl font-bold text-[#f1f5f9] truncate">{value}</p>
          {trend !== undefined && (
            <div className={`flex items-center gap-1 mt-2 text-xs font-medium ${trend >= 0 ? 'text-emerald-400' : 'text-red-400'}`}>
              {trend >= 0 ? <TrendingUp className="w-3 h-3" /> : <TrendingDown className="w-3 h-3" />}
              <span>{Math.abs(trend)}% vs last month</span>
            </div>
          )}
          {subtitle && !trend && (
            <p className="text-xs text-[#64748b] mt-2">{subtitle}</p>
          )}
        </div>
        <div className={`p-3 rounded-xl ${iconBg} group-hover:scale-110 transition-transform duration-200 flex-shrink-0 ml-4`}>
          {icon}
        </div>
      </div>
    </div>
  )
}
