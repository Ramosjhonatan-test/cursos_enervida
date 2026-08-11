import { defineStore } from 'pinia'
import { ref } from 'vue'
import api from '@/services/api'
import { useAuthStore } from '@/stores/auth'

export const useSolicitudStore = defineStore('solicitud', () => {
  const pendingCount = ref(0)
  const loading = ref(false)

  const fetchPendingCount = async () => {
    const authStore = useAuthStore()
    if (!authStore.canAccess('INSCRIPCIONES') && !authStore.canAccess('SOLICITUDES')) {
      pendingCount.value = 0
      return
    }

    loading.value = true
    try {
      const res = await api.get('/inscripciones')
      pendingCount.value = res.data.filter(s => s.estado === 'PENDIENTE').length
    } catch (error) {
      console.error('Error fetching pending count:', error)
    } finally {
      loading.value = false
    }
  }

  const setPendingCount = (count) => {
    pendingCount.value = count
  }

  const decrementPendingCount = () => {
    if (pendingCount.value > 0) {
      pendingCount.value--
    }
  }

  return {
    pendingCount,
    loading,
    fetchPendingCount,
    setPendingCount,
    decrementPendingCount
  }
})
