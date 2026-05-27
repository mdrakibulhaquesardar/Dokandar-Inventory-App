'use client'

import { AlertTriangle, Loader2 } from 'lucide-react'

interface ConfirmDialogProps {
  open: boolean
  onClose: () => void
  onConfirm: () => void
  title: string
  description: string
  loading?: boolean
  confirmLabel?: string
}

export function ConfirmDialog({
  open, onClose, onConfirm, title, description, loading, confirmLabel = 'Delete'
}: ConfirmDialogProps) {
  if (!open) return null

  return (
    <div className="modal-overlay" onClick={onClose}>
      <div
        className="glass-card p-6 w-full max-w-md animate-fade-in"
        onClick={e => e.stopPropagation()}
      >
        <div className="flex items-center gap-4 mb-4">
          <div className="p-3 rounded-xl bg-red-500/10 border border-red-500/20">
            <AlertTriangle className="w-6 h-6 text-red-400" />
          </div>
          <div>
            <h3 className="text-lg font-semibold text-white">{title}</h3>
          </div>
        </div>
        <p className="text-slate-400 text-sm mb-6">{description}</p>
        <div className="flex gap-3 justify-end">
          <button onClick={onClose} className="btn-secondary" disabled={loading}>
            Cancel
          </button>
          <button
            onClick={onConfirm}
            disabled={loading}
            className="btn-danger flex items-center gap-2 px-5 py-2"
          >
            {loading ? <Loader2 className="w-4 h-4 animate-spin" /> : null}
            {confirmLabel}
          </button>
        </div>
      </div>
    </div>
  )
}
