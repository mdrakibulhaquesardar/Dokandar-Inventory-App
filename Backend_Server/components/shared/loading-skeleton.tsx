'use client'

export function TableSkeleton({ rows = 5, cols = 5 }: { rows?: number; cols?: number }) {
  const widths = ['w-1/6', 'w-2/6', 'w-1/6', 'w-1/6', 'w-1/6']
  return (
    <div className="animate-pulse">
      {Array.from({ length: rows }).map((_, i) => (
        <div key={i} className="flex gap-4 py-4 border-b border-[#334155]">
          {Array.from({ length: cols }).map((__, j) => (
            <div key={j} className={`h-4 bg-[#334155] rounded ${widths[j % widths.length]}`} />
          ))}
        </div>
      ))}
    </div>
  )
}

export function StatCardSkeleton() {
  return (
    <div className="glass-card p-6 animate-pulse">
      <div className="flex items-start justify-between">
        <div className="flex-1">
          <div className="h-3 bg-[#334155] rounded w-1/3 mb-4" />
          <div className="h-8 bg-[#334155] rounded w-2/3 mb-2" />
          <div className="h-3 bg-[#334155] rounded w-1/2" />
        </div>
        <div className="w-12 h-12 bg-[#334155] rounded-xl" />
      </div>
    </div>
  )
}

export function ChartSkeleton({ height = 300 }: { height?: number }) {
  return (
    <div className="glass-card p-6 animate-pulse">
      <div className="h-4 bg-[#334155] rounded w-1/4 mb-6" />
      <div style={{ height }} className="bg-[#334155] rounded-xl" />
    </div>
  )
}

export function CardSkeleton() {
  return (
    <div className="glass-card p-6 animate-pulse space-y-3">
      <div className="h-4 bg-[#334155] rounded w-3/4" />
      <div className="h-3 bg-[#334155] rounded w-1/2" />
      <div className="h-3 bg-[#334155] rounded w-2/3" />
    </div>
  )
}
