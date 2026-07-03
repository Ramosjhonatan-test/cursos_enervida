<template>
  <div class="space-y-10 animate-in fade-in slide-in-from-bottom-4 duration-700">
    <!-- Header -->
    <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 panel-hero p-8 rounded-[40px] shadow-2xl relative overflow-hidden group">
      <div class="absolute inset-0 bg-gradient-to-r from-accent-neon/5 to-transparent opacity-50 group-hover:opacity-100 transition-opacity"></div>
      <div class="relative z-10">
        <div class="flex items-center gap-3 mb-4">
          <div class="w-10 h-10 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon shadow-inner">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M19 8v6"/><path d="M16 11h6"/></svg>
          </div>
          <span class="text-[10px] font-black text-accent-neon uppercase tracking-[0.3em]">Gestión de Admisiones</span>
        </div>
        <h2 class="text-4xl md:text-5xl font-black text-on-surface font-lexend tracking-tighter">Solicitudes de <span class="text-accent-neon  text-gradient-neon">Inscripción</span></h2>
        <p class="text-on-surface-variant mt-3 text-sm font-medium opacity-80 max-w-xl">Revisa, aprueba o rechaza las solicitudes de estudiantes para acceder a los programas de formación técnica.</p>
      </div>
    </div>

    <!-- Stats Row -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
      <div class="glass-card-premium p-8 rounded-[32px] group/stat hover:-translate-y-1 transition-all shadow-xl">
        <div class="flex items-center gap-4 mb-6">
          <div class="w-12 h-12 rounded-2xl bg-orange-500/10 flex items-center justify-center text-orange-500 group-hover/stat:scale-110 transition-transform">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          </div>
          <span class="text-[10px] font-black text-on-surface-variant uppercase tracking-widest">Pendientes</span>
        </div>
        <p class="text-5xl font-black text-on-surface">{{ pendingCount }}</p>
      </div>
      <div class="glass-card-premium p-8 rounded-[32px] group/stat hover:-translate-y-1 transition-all shadow-xl">
        <div class="flex items-center gap-4 mb-6">
          <div class="w-12 h-12 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon group-hover/stat:scale-110 transition-transform">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
          </div>
          <span class="text-[10px] font-black text-on-surface-variant uppercase tracking-widest">Aprobadas</span>
        </div>
        <p class="text-5xl font-black text-on-surface">{{ approvedCount }}</p>
      </div>
      <div class="glass-card-premium p-8 rounded-[32px] group/stat hover:-translate-y-1 transition-all shadow-xl">
        <div class="flex items-center gap-4 mb-6">
          <div class="w-12 h-12 rounded-2xl bg-red-500/10 flex items-center justify-center text-red-500 group-hover/stat:scale-110 transition-transform">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
          </div>
          <span class="text-[10px] font-black text-on-surface-variant uppercase tracking-widest">Rechazadas</span>
        </div>
        <p class="text-5xl font-black text-on-surface">{{ rejectedCount }}</p>
      </div>
    </div>

    <!-- Filter Tabs -->
    <div class="flex gap-4 pb-4 overflow-x-auto custom-scrollbar">
      <button @click="currentFilter = 'PENDIENTE'" :class="['px-6 py-3 rounded-full text-xs font-black uppercase tracking-widest transition-all whitespace-nowrap', currentFilter === 'PENDIENTE' ? 'bg-orange-500/20 text-orange-500 shadow-lg' : 'text-on-surface/40 hover:bg-on-surface/5']">Pendientes</button>
      <button @click="currentFilter = 'ACTIVO'" :class="['px-6 py-3 rounded-full text-xs font-black uppercase tracking-widest transition-all whitespace-nowrap', currentFilter === 'ACTIVO' ? 'bg-accent-neon/20 text-accent-neon shadow-lg' : 'text-on-surface/40 hover:bg-on-surface/5']">Aprobadas</button>
      <button @click="currentFilter = 'INACTIVO'" :class="['px-6 py-3 rounded-full text-xs font-black uppercase tracking-widest transition-all whitespace-nowrap', currentFilter === 'INACTIVO' ? 'bg-red-500/20 text-red-500 shadow-lg' : 'text-on-surface/40 hover:bg-on-surface/5']">Rechazadas</button>
    </div>

    <!-- Table -->
    <div class="glass-card-premium rounded-[48px] overflow-hidden shadow-2xl relative min-h-[400px]">
      <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
         <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
         <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando datos...</p>
      </div>
      
      <div class="overflow-x-auto relative z-0">
        <table class="w-full text-left border-separate border-spacing-0 min-w-[860px]">
          <thead>
            <tr>
              <th class="p-6 md:p-8 text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em]">Estudiante & Curso</th>
              <th class="p-6 md:p-8 text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] hidden md:table-cell">Contacto</th>
              <th class="p-6 md:p-8 text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] hidden sm:table-cell">Fecha Solicitud</th>
              <th class="p-6 md:p-8 text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] text-right">Acciones</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="solicitud in filteredSolicitudes" :key="solicitud.id" class="group hover:bg-on-surface/[0.03] transition-colors">
              <td class="p-6 md:p-8">
                <div class="flex items-center gap-5">
                  <div class="w-12 h-12 rounded-2xl bg-on-surface/5 overflow-hidden shrink-0">
                    <img v-if="solicitud.usuario?.imagen_perfil" :src="solicitud.usuario.imagen_perfil" class="w-full h-full object-cover" />
                    <div v-else class="w-full h-full flex items-center justify-center text-on-surface/40 font-black">{{ solicitud.usuario?.nombres?.[0] || '?' }}</div>
                  </div>
                  <div class="flex flex-col gap-1.5">
                    <p class="text-sm font-black text-on-surface">{{ solicitud.usuario?.nombres }} {{ solicitud.usuario?.apellidos }}</p>
                    <div class="flex items-center gap-2">
                      <span class="px-2 py-0.5 rounded-md bg-on-surface/10 text-[9px] font-bold text-on-surface-variant uppercase tracking-widest line-clamp-1 max-w-[200px]" :title="solicitud.curso?.titulo">{{ solicitud.curso?.titulo }}</span>
                    </div>
                  </div>
                </div>
              </td>
              <td class="p-6 md:p-8 hidden md:table-cell">
                <div class="flex flex-col gap-2">
                  <span class="text-xs text-on-surface font-bold flex items-center gap-2 opacity-80">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-on-surface/40"><rect width="20" height="16" x="2" y="4" rx="2"/><path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"/></svg>
                    {{ solicitud.usuario?.correo }}
                  </span>
                  <span class="text-[11px] text-on-surface font-black tracking-wider flex items-center gap-2 opacity-80">
                    <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="text-on-surface/40"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
                    {{ solicitud.usuario?.telefono || 'No provisto' }}
                  </span>
                </div>
              </td>
              <td class="p-6 md:p-8 hidden sm:table-cell">
                <span class="text-xs font-bold text-on-surface/60">{{ new Date(solicitud.fecha_inscripcion).toLocaleDateString() }}</span>
              </td>
              <td class="p-6 md:p-8 text-right">
                <div v-if="solicitud.estado === 'PENDIENTE'" class="flex justify-end gap-3">
                  <button @click="updateStatus(solicitud.id, 'ACTIVO')" :disabled="processingId === solicitud.id" class="w-10 h-10 rounded-xl bg-emerald-500/10 flex items-center justify-center text-emerald-500 hover:bg-emerald-600 hover:text-white transition-all duration-300 shadow-lg" title="Aprobar Inscripción">
                    <span v-if="processingId !== solicitud.id" class="material-symbols-outlined text-xl">check</span>
                    <span v-else class="animate-spin material-symbols-outlined text-xl">refresh</span>
                  </button>
                  <button @click="updateStatus(solicitud.id, 'INACTIVO')" :disabled="processingId === solicitud.id" class="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center text-red-500 hover:bg-red-600 hover:text-white transition-all duration-300 shadow-lg" title="Rechazar Inscripción">
                    <span class="material-symbols-outlined text-xl">close</span>
                  </button>
                </div>
                <div v-else>
                  <span :class="['px-4 py-2 rounded-xl text-[10px] font-black uppercase tracking-widest', solicitud.estado === 'ACTIVO' ? 'bg-accent-neon/10 text-accent-neon' : 'bg-red-500/10 text-red-500']">
                    {{ solicitud.estado === 'ACTIVO' ? 'Aprobada' : 'Rechazada' }}
                  </span>
                </div>
              </td>
            </tr>
            <tr v-if="filteredSolicitudes.length === 0 && !loading">
              <td colspan="4" class="p-20 text-center">
                <div class="flex flex-col items-center justify-center gap-6">
                  <div class="w-24 h-24 rounded-full bg-on-surface/5 flex items-center justify-center text-on-surface/20">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="18" height="18" x="3" y="3" rx="2"/><path d="M8 12h8"/></svg>
                  </div>
                  <div class="space-y-2">
                    <h3 class="text-xl font-black text-on-surface tracking-tight">No hay solicitudes</h3>
                    <p class="text-xs text-on-surface-variant uppercase tracking-widest font-bold">No se encontraron registros en esta categoría.</p>
                  </div>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'
import { useSolicitudStore } from '@/stores/solicitudStore'

const notificationStore = useNotificationStore()
const solicitudStore = useSolicitudStore()

const solicitudes = ref([])
const loading = ref(true)
const processingId = ref(null)
const currentFilter = ref('PENDIENTE')

const pendingCount = computed(() => solicitudes.value.filter(s => s.estado === 'PENDIENTE').length)
const approvedCount = computed(() => solicitudes.value.filter(s => s.estado === 'ACTIVO').length)
const rejectedCount = computed(() => solicitudes.value.filter(s => s.estado === 'INACTIVO').length)

const filteredSolicitudes = computed(() => {
  return solicitudes.value.filter(s => s.estado === currentFilter.value)
})

const fetchSolicitudes = async () => {
  loading.value = true
  try {
    const res = await api.get('/inscripciones')
    solicitudes.value = res.data
    // Update global store count
    solicitudStore.setPendingCount(pendingCount.value)
  } catch (error) {
    console.error('Error fetching solicitudes:', error)
  } finally {
    loading.value = false
  }
}

const updateStatus = async (id, status) => {
  processingId.value = id
  try {
    await api.patch(`/inscripciones/${id}`, { estado: status })
    // Actualizar localmente
    const sol = solicitudes.value.find(s => s.id === id)
    if (sol) {
      sol.estado = status
      // Update global store count
      solicitudStore.setPendingCount(pendingCount.value)
    }
    notificationStore.addNotification({
      title: status === 'ACTIVO' ? 'Solicitud Aprobada' : 'Solicitud Rechazada',
      message: `La inscripción ha sido marcada como ${status.toLowerCase()}.`,
      type: status === 'ACTIVO' ? 'success' : 'warning'
    })
  } catch (error) {
    console.error('Error updating status:', error)
    notificationStore.addNotification({
      title: 'Error de Procesamiento',
      message: 'No se pudo actualizar el estado de la solicitud.',
      type: 'error'
    })
  } finally {
    processingId.value = null
  }
}

onMounted(() => {
  fetchSolicitudes()
})
</script>
