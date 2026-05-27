'use client'

import { useEffect, useState, useCallback } from 'react'
import { Plus, Search, Pencil, Trash2, X, Loader2, Package, ChevronDown } from 'lucide-react'
import { apiGet, apiPost, apiPut, apiDelete } from '@/lib/api-client'
import { formatCurrency, formatDate } from '@/lib/utils'
import { TableSkeleton } from '@/components/shared/loading-skeleton'
import { EmptyState } from '@/components/shared/empty-state'
import { ConfirmDialog } from '@/components/shared/confirm-dialog'

interface Category { id: string; name: string }
interface Product {
  id: string; sku: string; name: string; stockQty: number; stockThreshold: number
  unitPrice: number; buyingPrice: number; status: string
  category: { id: string; name: string } | null
  createdAt: string
}

const INIT_FORM = {
  name: '', sku: '', categoryId: '', description: '',
  unitPrice: '', buyingPrice: '', stockQty: '', stockThreshold: '10',
  unit: 'pcs', status: 'ACTIVE'
}

export default function ProductsPage() {
  const [products, setProducts] = useState<Product[]>([])
  const [categories, setCategories] = useState<Category[]>([])
  const [loading, setLoading] = useState(true)
  const [search, setSearch] = useState('')
  const [categoryFilter, setCategoryFilter] = useState('')
  const [modalOpen, setModalOpen] = useState(false)
  const [editProduct, setEditProduct] = useState<Product | null>(null)
  const [form, setForm] = useState({ ...INIT_FORM })
  const [saving, setSaving] = useState(false)
  const [deleteId, setDeleteId] = useState<string | null>(null)
  const [deleting, setDeleting] = useState(false)
  const [formError, setFormError] = useState('')

  const loadData = useCallback(async () => {
    setLoading(true)
    const [pRes, cRes] = await Promise.all([
      apiGet('/products?limit=100'),
      apiGet('/categories'),
    ])
    if (pRes.success) {
      const d = pRes.data as { products?: Product[] } | Product[]
      setProducts(Array.isArray(d) ? d : d?.products || [])
    }
    if (cRes.success) {
      const d = cRes.data as { categories?: Category[] } | Category[]
      setCategories(Array.isArray(d) ? d : d?.categories || [])
    }
    setLoading(false)
  }, [])

  useEffect(() => { loadData() }, [loadData])

  function openAdd() {
    setEditProduct(null)
    setForm({ ...INIT_FORM })
    setFormError('')
    setModalOpen(true)
  }

  function openEdit(p: Product) {
    setEditProduct(p)
    setForm({
      name: p.name, sku: p.sku, categoryId: p.category?.id || '',
      description: '', unitPrice: String(p.unitPrice), buyingPrice: String(p.buyingPrice),
      stockQty: String(p.stockQty), stockThreshold: String(p.stockThreshold),
      unit: 'pcs', status: p.status
    })
    setFormError('')
    setModalOpen(true)
  }

  async function handleSave(e: React.FormEvent) {
    e.preventDefault()
    setFormError('')
    if (!form.name.trim()) { setFormError('Product name is required.'); return }
    setSaving(true)
    const payload = {
      ...form,
      unitPrice: parseFloat(form.unitPrice) || 0,
      buyingPrice: parseFloat(form.buyingPrice) || 0,
      stockQty: parseInt(form.stockQty) || 0,
      stockThreshold: parseInt(form.stockThreshold) || 10,
    }
    const res = editProduct
      ? await apiPut(`/products/${editProduct.id}`, payload)
      : await apiPost('/products', payload)
    if (res.success) {
      setModalOpen(false)
      loadData()
    } else {
      setFormError(res.error || 'Failed to save product.')
    }
    setSaving(false)
  }

  async function handleDelete() {
    if (!deleteId) return
    setDeleting(true)
    const res = await apiDelete(`/products/${deleteId}`)
    if (res.success) {
      setDeleteId(null)
      loadData()
    }
    setDeleting(false)
  }

  const filtered = products.filter(p => {
    const q = search.toLowerCase()
    const matchSearch = !q || p.name.toLowerCase().includes(q) || p.sku.toLowerCase().includes(q)
    const matchCat = !categoryFilter || p.category?.id === categoryFilter
    return matchSearch && matchCat
  })

  const profitPct = (p: Product) => {
    if (!p.buyingPrice) return null
    return (((p.unitPrice - p.buyingPrice) / p.buyingPrice) * 100).toFixed(1)
  }

  const stockColor = (p: Product) => {
    if (p.stockQty === 0) return 'text-red-400 font-bold'
    if (p.stockQty < p.stockThreshold) return 'text-amber-400 font-semibold'
    return 'text-emerald-400'
  }

  return (
    <div className="space-y-5">
      {/* Top Bar */}
      <div className="flex flex-col sm:flex-row gap-3">
        <div className="relative flex-1">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
          <input
            className="input-dark pl-9 h-10"
            placeholder="Search by name or SKU..."
            value={search}
            onChange={e => setSearch(e.target.value)}
          />
        </div>
        <div className="relative">
          <select
            className="input-dark h-10 appearance-none pr-8 cursor-pointer"
            value={categoryFilter}
            onChange={e => setCategoryFilter(e.target.value)}
          >
            <option value="">All Categories</option>
            {categories.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
          </select>
          <ChevronDown className="absolute right-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400 pointer-events-none" />
        </div>
        <button onClick={openAdd} className="btn-primary h-10 w-auto px-4">
          <Plus className="w-4 h-4" /> Add Product
        </button>
      </div>

      {/* Table */}
      <div className="glass-card overflow-hidden">
        <div className="flex items-center justify-between px-5 py-4 border-b border-[#334155]">
          <h3 className="text-sm font-semibold text-white">
            Products <span className="text-slate-500 font-normal ml-1">({filtered.length})</span>
          </h3>
        </div>
        <div className="overflow-x-auto">
          {loading ? (
            <div className="p-5"><TableSkeleton rows={6} cols={7} /></div>
          ) : filtered.length === 0 ? (
            <EmptyState
              title="No products found"
              description={search ? 'Try adjusting your search query.' : 'Add your first product to get started.'}
              icon={<Package className="w-10 h-10" />}
              action={!search ? (
                <button onClick={openAdd} className="btn-primary w-auto px-6">
                  <Plus className="w-4 h-4" /> Add First Product
                </button>
              ) : undefined}
            />
          ) : (
            <table className="table-dark w-full">
              <thead>
                <tr>
                  <th>SKU</th>
                  <th>Product Name</th>
                  <th>Category</th>
                  <th>Stock</th>
                  <th>Sell Price</th>
                  <th>Buy Price</th>
                  <th>Profit</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {filtered.map(p => (
                  <tr key={p.id}>
                    <td className="font-mono text-xs text-slate-400">{p.sku}</td>
                    <td className="font-medium text-white">{p.name}</td>
                    <td>
                      {p.category ? (
                        <span className="badge badge-info">{p.category.name}</span>
                      ) : (
                        <span className="text-slate-500 text-xs">—</span>
                      )}
                    </td>
                    <td className={stockColor(p)}>
                      {p.stockQty}
                      {p.stockQty < p.stockThreshold && p.stockQty > 0 && (
                        <span className="ml-1 text-xs opacity-70">low</span>
                      )}
                      {p.stockQty === 0 && <span className="ml-1 text-xs">out!</span>}
                    </td>
                    <td>{formatCurrency(p.unitPrice)}</td>
                    <td className="text-slate-400">{formatCurrency(p.buyingPrice)}</td>
                    <td>
                      {profitPct(p) !== null ? (
                        <span className={`text-sm font-medium ${Number(profitPct(p)) > 0 ? 'text-emerald-400' : 'text-red-400'}`}>
                          {profitPct(p)}%
                        </span>
                      ) : '—'}
                    </td>
                    <td>
                      <span className={`badge ${p.status === 'ACTIVE' ? 'badge-success' : 'badge-gray'}`}>
                        {p.status}
                      </span>
                    </td>
                    <td>
                      <div className="flex items-center gap-2">
                        <button
                          onClick={() => openEdit(p)}
                          className="p-1.5 rounded-lg text-slate-400 hover:text-white hover:bg-[#334155] transition-colors"
                        >
                          <Pencil className="w-4 h-4" />
                        </button>
                        <button
                          onClick={() => setDeleteId(p.id)}
                          className="p-1.5 rounded-lg text-slate-400 hover:text-red-400 hover:bg-red-500/10 transition-colors"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          )}
        </div>
      </div>

      {/* Add/Edit Modal */}
      {modalOpen && (
        <div className="modal-overlay">
          <div className="glass-card w-full max-w-2xl max-h-[90vh] overflow-y-auto animate-fade-in">
            <div className="flex items-center justify-between p-5 border-b border-[#334155]">
              <h3 className="text-lg font-semibold text-white">
                {editProduct ? 'Edit Product' : 'Add New Product'}
              </h3>
              <button onClick={() => setModalOpen(false)} className="p-1.5 text-slate-400 hover:text-white rounded-lg transition-colors">
                <X className="w-5 h-5" />
              </button>
            </div>
            <form onSubmit={handleSave} className="p-5 space-y-4">
              {formError && (
                <div className="p-3 rounded-xl bg-red-500/10 border border-red-500/20 text-red-400 text-sm">
                  {formError}
                </div>
              )}
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="md:col-span-2">
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Product Name *</label>
                  <input className="input-dark" placeholder="e.g. Samsung 65W Charger"
                    value={form.name} onChange={e => setForm(f => ({ ...f, name: e.target.value }))} required />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">SKU</label>
                  <input className="input-dark" placeholder="e.g. ELEC-001"
                    value={form.sku} onChange={e => setForm(f => ({ ...f, sku: e.target.value }))} />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Category</label>
                  <select className="input-dark appearance-none cursor-pointer"
                    value={form.categoryId} onChange={e => setForm(f => ({ ...f, categoryId: e.target.value }))}>
                    <option value="">Select category</option>
                    {categories.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Selling Price (৳) *</label>
                  <input type="number" className="input-dark" placeholder="0.00" min="0" step="0.01"
                    value={form.unitPrice} onChange={e => setForm(f => ({ ...f, unitPrice: e.target.value }))} required />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Buying Price (৳)</label>
                  <input type="number" className="input-dark" placeholder="0.00" min="0" step="0.01"
                    value={form.buyingPrice} onChange={e => setForm(f => ({ ...f, buyingPrice: e.target.value }))} />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Stock Quantity</label>
                  <input type="number" className="input-dark" placeholder="0" min="0"
                    value={form.stockQty} onChange={e => setForm(f => ({ ...f, stockQty: e.target.value }))} />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Low Stock Threshold</label>
                  <input type="number" className="input-dark" placeholder="10" min="0"
                    value={form.stockThreshold} onChange={e => setForm(f => ({ ...f, stockThreshold: e.target.value }))} />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Unit</label>
                  <select className="input-dark appearance-none cursor-pointer"
                    value={form.unit} onChange={e => setForm(f => ({ ...f, unit: e.target.value }))}>
                    {['pcs', 'kg', 'g', 'liter', 'ml', 'box', 'pack', 'dozen'].map(u => (
                      <option key={u} value={u}>{u}</option>
                    ))}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Status</label>
                  <select className="input-dark appearance-none cursor-pointer"
                    value={form.status} onChange={e => setForm(f => ({ ...f, status: e.target.value }))}>
                    <option value="ACTIVE">Active</option>
                    <option value="INACTIVE">Inactive</option>
                  </select>
                </div>
                <div className="md:col-span-2">
                  <label className="block text-sm font-medium text-slate-300 mb-1.5">Description</label>
                  <textarea className="input-dark resize-none" rows={3} placeholder="Optional product description..."
                    value={form.description} onChange={e => setForm(f => ({ ...f, description: e.target.value }))} />
                </div>
              </div>
              <div className="flex gap-3 pt-2">
                <button type="button" onClick={() => setModalOpen(false)} className="btn-secondary flex-1">Cancel</button>
                <button type="submit" className="btn-primary flex-1" disabled={saving}>
                  {saving ? <><Loader2 className="w-4 h-4 animate-spin" /> Saving...</> : editProduct ? 'Update Product' : 'Add Product'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Delete Confirm */}
      <ConfirmDialog
        open={!!deleteId}
        onClose={() => setDeleteId(null)}
        onConfirm={handleDelete}
        title="Delete Product"
        description="Are you sure you want to delete this product? This action cannot be undone and will affect related sales records."
        loading={deleting}
      />
    </div>
  )
}
