import { Package } from 'lucide-react'

interface EmptyStateProps {
  title: string
  description: string
  icon?: React.ReactNode
  action?: React.ReactNode
}

export function EmptyState({ title, description, icon, action }: EmptyStateProps) {
  return (
    <div className="flex flex-col items-center justify-center py-16 text-center">
      <div className="p-5 bg-[#1e293b] border border-[#334155] rounded-2xl mb-5 text-[#64748b]">
        {icon || <Package className="w-10 h-10" />}
      </div>
      <h3 className="text-lg font-semibold text-[#f1f5f9] mb-2">{title}</h3>
      <p className="text-[#64748b] max-w-sm text-sm leading-relaxed">{description}</p>
      {action && <div className="mt-6">{action}</div>}
    </div>
  )
}
