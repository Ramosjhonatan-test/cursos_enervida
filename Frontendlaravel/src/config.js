export const API_BASE_URL = (import.meta.env.VITE_API_URL || 'http://localhost:3000').replace(/\/$/, '')

export const getFileUrl = (path) => {
  if (!path) return ''
  const cleanPath = String(path).trim().replaceAll('\\', '/')
  if (cleanPath.startsWith('http')) return cleanPath
  const normalizedPath = cleanPath.startsWith('/') ? cleanPath : `/${cleanPath}`
  return `${API_BASE_URL}${normalizedPath}`
}
