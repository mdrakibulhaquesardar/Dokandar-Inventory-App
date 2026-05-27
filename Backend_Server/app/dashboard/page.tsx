'use client'

import { useEffect, useState } from 'react'
import {
  DollarSign, ShoppingCart, Package, AlertTriangle,
  Users, CreditCard, ArrowRight, TrendingUp
} from 'lucide-react'
import {
  LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, BarChart, Bar, Legend
} from 'recharts'
import { StatsCard } from '@/components/dashboard/stats-card'
import { StatCardSkeleton, ChartSkeleton, TableSkeleton } from '@/components/shared/loading-skeleton'
import { EmptyState } from '@/components/shared/empty-state'
import { apiGet } from '@/lib/api-client'
import { formatCurrency, formatDate, formatRelativeTime } from '@/lib/utils'
import Link from 'next/link'

interface DashboardStats {
  totalRevenue: number
  todaySalesCount: number
  todaySalesAmount: number
  totalProducts: number
  lowStockCount: number
  totalCustomers: number
  totalDue: number
  revenueGrowth: number
}

interface RevenuePoint { date: string; revenue: number; sales: number }
interface RecentSale {
  id: string
  invoiceNo: string
  customerName: string
  totalAmount: number
  paidAmount: number
  dueAmount: number
  createdAt: string
  status: string
}
interface LowStockItem {
  id: string
  name: string
  sku: string
  stockQty: number
  stockThreshold: number
  category: { name: string } | null
}

const REVENUE_COLORS = { revenue: '#10b981', sales: '#3b82f6' }

const CustomTooltip = ({ active, payload, label }: { active?: boolean; payload?: { color: string; name: string; value: number }[]; label?: string }) => {
  if (active && payload && payload.length) {
    return (
      <div className="glass-card p-3 text-sm border border-[#334155]">
        <p className="text-slate-400 mb-2">{label}</p>
        {payload.map(p => (
          <p key={p.name} style={{ color: p.color }}>
            {p.name}: {p.name === 'revenue' ? formatCurrency(p.value) : p.value}
          </p>
        ))}
      </div>
    )
  }
  return null
}

export default function DashboardPage() {
  const [stats, setStats] = useState<DashboardStats | null>(null)
  const [revenue, setRevenue] = useState<RevenuePoint[]>([])
  const [recentSales, setRecentSales] = useState<RecentSale[]>([])
  const [lowStock, setLowStock] = useState<LowStockItem[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function load() {
      try {
        const [statsRes, revenueRes, salesRes, stockRes] = await Promise.all([
          apiGet('/dashboard/stats'),
          apiGet('/dashboard/revenue'),
          apiGet('/dashboard/recent-sales'),
          apiGet('/products?lowStock=true&limit=5'),
        ])
        if (statsRes.success) setStats(statsRes.data as DashboardStats)
        if (revenueRes.success) setRevenue((revenueRes.data as RevenuePoint[]) || [])
        if (salesRes.success) setRecentSales((salesRes.data as RecentSale[]) || [])
        if (stockRes.success) {
          const d = stockRes.data as { products?: LowStockItem[] } | LowStockItem[]
          setLowStock(Array.isArray(d) ? d : (d?.products || []))
        }
      } catch (e) {
        console.error(e)
      } finally {
        setLoading(false)
      }
    }
    load()
  }, [])

  return (
    <div className="space-y-6">
      {/* Stats Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
        {loading ? (
          Array.from({ length: 6 }).map((_, i) => <StatCardSkeleton key={i} />)
        ) : stats ? (
          <>
            <StatsCard
              title="Total Revenue"
              value={formatCurrency(stats.totalRevenue)}
              icon={<DollarSign className="w-5 h-5 text-emerald-400" />}
              iconBg="bg-emerald-500/20"
              trend={stats.revenueGrowth}
            />
            <StatsCard
              title="Today's Sales"
              value={formatCurrency(stats.todaySalesAmount)}
              icon={<ShoppingCart className="w-5 h-5 text-blue-400" />}
              iconBg="bg-blue-500/20"
              subtitle={`${stats.todaySalesCount} transaction${stats.todaySalesCount !== 1 ? 's' : ''} today`}
            />
            <StatsCard
              title="Total Products"
              value={stats.totalProducts.toLocaleString()}
              icon={<Package className="w-5 h-5 text-purple-400" />}
              iconBg="bg-purple-500/20"
            />
            <StatsCard
              title="Low Stock Alerts"
              value={stats.lowStockCount}
              icon={<AlertTriangle className="w-5 h-5 text-red-400" />}
              iconBg="bg-red-500/20"
              subtitle={stats.lowStockCount > 0 ? 'Items need restocking' : 'All stock levels healthy'}
            />
            <StatsCard
              title="Total Customers"
              value={stats.totalCustomers.toLocaleString()}
              icon={<Users className="w-5 h-5 text-teal-400" />}
              iconBg="bg-teal-500/20"
            />
            <StatsCard
              title="Outstanding Due"
              value={formatCurrency(stats.totalDue)}
              icon={<CreditCard className="w-5 h-5 text-orange-400" />}
              iconBg="bg-orange-500/20"
              subtitle={stats.totalDue > 0 ? 'Pending collections' : 'All dues cleared'}
            />
          </>
        ) : (
          <div className="col-span-3 glass-card p-8 text-center text-slate-400">
            Failed to load statistics. Please refresh the page.
          </div>
        )}
      </div>

      {/* Charts Row */}
      <div className="grid grid-cols-1 xl:grid-cols-2 gap-4">
        {/* Revenue Trend */}
        <div className="glass-card p-6">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h3 className="text-base font-semibold text-white">Revenue Trend</h3>
              <p className="text-xs text-slate-500 mt-0.5">Last 30 days</p>
            </div>
            <div className="flex items-center gap-4 text-xs text-slate-400">
              <span className="flex items-center gap-1.5">
                <span className="w-3 h-3 rounded-full bg-emerald-500" />Revenue
              </span>
              <span className="flex items-center gap-1.5">
                <span className="w-3 h-3 rounded-full bg-blue-500" />Sales
              </span>
            </div>
          </div>
          {loading ? (
            <ChartSkeleton height={250} />
          ) : revenue.length > 0 ? (
            <ResponsiveContainer width="100%" height={250}>
              <LineChart data={revenue}>
                <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
                <XAxis dataKey="date" stroke="#64748b" tick={{ fontSize: 11 }} tickLine={false} axisLine={false} />
                <YAxis stroke="#64748b" tick={{ fontSize: 11 }} tickLine={false} axisLine={false}
                  tickFormatter={v => `৳${(v / 1000).toFixed(0)}k`} />
                <Tooltip content={<CustomTooltip />} />
                <Line type="monotone" dataKey="revenue" stroke={REVENUE_COLORS.revenue} strokeWidth={2.5}
                  dot={false} activeDot={{ r: 4, fill: REVENUE_COLORS.revenue }} />
                <Line type="monotone" dataKey="sales" stroke={REVENUE_COLORS.sales} strokeWidth={2}
                  dot={false} activeDot={{ r: 4, fill: REVENUE_COLORS.sales }} strokeDasharray="5 5" />
              </LineChart>
            </ResponsiveContainer>
          ) : (
            <div className="h-64 flex items-center justify-center text-slate-500 text-sm">
              No revenue data available
            </div>
          )}
        </div>

        {/* Sales Bar Chart */}
        <div className="glass-card p-6">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h3 className="text-base font-semibold text-white">Sales by Day</h3>
              <p className="text-xs text-slate-500 mt-0.5">Last 7 days</p>
            </div>
          </div>
          {loading ? (
            <ChartSkeleton height={250} />
          ) : revenue.length > 0 ? (
            <ResponsiveContainer width="100%" height={250}>
              <BarChart data={revenue.slice(-7)}>
                <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
                <XAxis dataKey="date" stroke="#64748b" tick={{ fontSize: 11 }} tickLine={false} axisLine={false} />
                <YAxis stroke="#64748b" tick={{ fontSize: 11 }} tickLine={false} axisLine={false}
                  tickFormatter={v => `৳${(v / 1000).toFixed(0)}k`} />
                <Tooltip content={<CustomTooltip />} />
                <Legend wrapperStyle={{ fontSize: 12, color: '#94a3b8' }} />
                <Bar dataKey="revenue" fill="#10b981" radius={[4, 4, 0, 0]} opacity={0.85} />
              </BarChart>
            </ResponsiveContainer>
          ) : (
            <div className="h-64 flex items-center justify-center text-slate-500 text-sm">
              No sales data available
            </div>
          )}
        </div>
      </div>

      {/* Bottom Row */}
      <div className="grid grid-cols-1 xl:grid-cols-3 gap-4">
        {/* Recent Sales */}
        <div className="xl:col-span-2 glass-card p-6">
          <div className="flex items-center justify-between mb-5">
            <div>
              <h3 className="text-base font-semibold text-white">Recent Sales</h3>
              <p className="text-xs text-slate-500 mt-0.5">Latest 10 transactions</p>
            </div>
            <Link href="/dashboard/sales" className="flex items-center gap-1.5 text-xs text-emerald-400 hover:text-emerald-300 font-medium transition-colors">
              View all <ArrowRight className="w-3 h-3" />
            </Link>
          </div>
          {loading ? (
            <TableSkeleton rows={5} cols={4} />
          ) : recentSales.length > 0 ? (
            <div className="overflow-x-auto">
              <table className="table-dark w-full">
                <thead>
                  <tr>
                    <th>Invoice</th>
                    <th>Customer</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Date</th>
                  </tr>
                </thead>
                <tbody>
                  {recentSales.map(sale => (
                    <tr key={sale.id}>
                      <td className="font-mono text-sm text-emerald-400">#{sale.invoiceNo}</td>
                      <td>{sale.customerName || 'Walk-in Customer'}</td>
                      <td className="font-medium">{formatCurrency(sale.totalAmount)}</td>
                      <td>
                        <span className={`badge ${sale.dueAmount > 0 ? 'badge-warning' : 'badge-success'}`}>
                          {sale.dueAmount > 0 ? 'Partial' : 'Completed'}
                        </span>
                      </td>
                      <td className="text-slate-400 text-sm">{formatRelativeTime(sale.createdAt)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          ) : (
            <EmptyState
              title="No sales yet"
              description="Your recent sales will appear here once you start recording transactions."
              icon={<ShoppingCart className="w-10 h-10" />}
            />
          )}
        </div>

        {/* Low Stock Alerts */}
        <div className="glass-card p-6">
          <div className="flex items-center justify-between mb-5">
            <div>
              <h3 className="text-base font-semibold text-white">Low Stock</h3>
              <p className="text-xs text-slate-500 mt-0.5">Items needing restock</p>
            </div>
            <Link href="/dashboard/inventory" className="flex items-center gap-1.5 text-xs text-emerald-400 hover:text-emerald-300 font-medium transition-colors">
              View all <ArrowRight className="w-3 h-3" />
            </Link>
          </div>
          {loading ? (
            <div className="space-y-3">
              {Array.from({ length: 5 }).map((_, i) => (
                <div key={i} className="h-14 bg-[#334155] rounded-xl animate-pulse" />
              ))}
            </div>
          ) : lowStock.length > 0 ? (
            <div className="space-y-3">
              {lowStock.map(item => {
                const pct = Math.min(100, (item.stockQty / (item.stockThreshold || 10)) * 100)
                const color = item.stockQty === 0 ? 'bg-red-500' : item.stockQty < 5 ? 'bg-red-400' : 'bg-amber-400'
                return (
                  <div key={item.id} className="p-3 rounded-xl bg-[#0f172a] border border-[#334155]">
                    <div className="flex items-center justify-between mb-2">
                      <p className="text-sm font-medium text-white truncate">{item.name}</p>
                      <span className={`text-xs font-bold ml-2 ${item.stockQty === 0 ? 'text-red-400' : 'text-amber-400'}`}>
                        {item.stockQty} left
                      </span>
                    </div>
                    <div className="progress-bar">
                      <div className={`progress-fill ${color}`} style={{ width: `${pct}%` }} />
                    </div>
                    <p className="text-xs text-slate-500 mt-1">{item.category?.name || 'Uncategorized'} • {item.sku}</p>
                  </div>
                )
              })}
            </div>
          ) : (
            <EmptyState
              title="Stock levels healthy"
              description="All your products are well-stocked."
              icon={<TrendingUp className="w-10 h-10" />}
            />
          )}
        </div>
      </div>
    </div>
  )
}
