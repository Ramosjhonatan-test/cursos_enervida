<template>
  <div class="space-y-10 animate-fade-in text-on-surface">
    <!-- Header & Hero -->
    <div class="panel-hero p-10 relative overflow-hidden group rounded-[40px] bg-on-surface/[0.03] !border-none shadow-2xl">
      <div class="absolute -right-20 -top-20 w-80 h-80 bg-accent-neon/10 rounded-full blur-[100px] group-hover:bg-accent-neon/20 transition-all duration-1000"></div>
      <div class="absolute -left-20 -bottom-20 w-64 h-64 bg-primary/5 rounded-full blur-[80px]"></div>

      <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-8 relative z-10">
        <div class="flex-1">
          <div class="flex items-center gap-4 mb-3">
            <div class="w-16 h-16 rounded-2xl bg-accent-neon/20 flex items-center justify-center text-accent-neon shadow-neon-sm animate-pulse-slow">
              <span class="material-symbols-outlined text-4xl">group</span>
            </div>
            <div>
              <h2 class="text-3xl md:text-5xl font-black text-on-surface font-lexend tracking-tighter leading-none">
                Gestión de <span class="text-accent-neon italic">Estudiantes</span>
              </h2>
              <p class="text-on-surface/50 text-xs font-bold uppercase tracking-[0.4em] mt-3 flex items-center gap-2">
                <span class="flex h-2 w-2 relative">
                  <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
                  <span class="relative inline-flex rounded-full h-2 w-2 bg-accent-neon"></span>
                </span>
                COMUNIDAD Y SEGUIMIENTO ACADÉMICO
              </p>
            </div>
          </div>
        </div>

        <div class="flex flex-wrap items-center gap-4">
          <div class="relative group">
            <span class="absolute left-5 top-1/2 -translate-y-1/2 material-symbols-outlined text-on-surface/30 group-focus-within:text-accent-neon transition-all scale-110">search</span>
            <input 
              v-model="searchQuery" 
              type="text" 
              placeholder="Buscar estudiante..." 
              class="input-cyber !pl-14 !py-4 !text-sm w-full md:w-80 transition-all !bg-on-surface/[0.04] !border-none"
            />
          </div>
          <router-link to="/admin/estudiantes/nuevo" class="btn-premium btn-primary-neon !py-4 px-8 group/btn relative overflow-hidden">
             <div class="absolute inset-0 bg-accent-neon/5 translate-y-full group-hover/btn:translate-y-0 transition-transform"></div>
             <span class="material-symbols-outlined text-lg relative">person_add</span>
             <span class="relative">Nuevo Estudiante</span>
          </router-link>
        </div>
        <div class="flex flex-wrap items-center gap-4">
          <button @click="fetchEstudiantes" class="btn-premium btn-primary-cyan !py-4 px-8 group/btn relative overflow-hidden !border-none shadow-xl hover:shadow-accent-neon/20 transition-all duration-500">
             <span class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-180 duration-500 relative" :class="{ 'animate-spin': loading }">refresh</span>
             <span class="relative font-bold">Actualizar</span>
          </button>
        </div>
      </div>
    </div>

    <!-- Stats Row -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
      <div class="glass-card rounded-[2.5rem] p-8 flex items-center gap-6 group hover:-translate-y-1 transition-all duration-500 !border-none shadow-2xl">
        <div class="w-16 h-16 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon group-hover:shadow-neon-sm transition-all">
          <span class="material-symbols-outlined text-3xl">groups</span>
        </div>
        <div>
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest mb-1">Total Estudiantes</p>
          <p class="text-4xl font-black text-on-surface font-lexend tracking-tight">{{ estudiantes.length }}</p>
        </div>
      </div>
      <div class="glass-card rounded-[2.5rem] p-8 flex items-center gap-6 group hover:-translate-y-1 transition-all duration-500 !border-none shadow-2xl">
        <div class="w-16 h-16 rounded-2xl bg-accent-solar/10 flex items-center justify-center text-accent-solar group-hover:shadow-solar-sm transition-all">
          <span class="material-symbols-outlined text-3xl">how_to_reg</span>
        </div>
        <div>
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest mb-1">Alumnos Activos</p>
          <p class="text-4xl font-black text-on-surface font-lexend tracking-tight">{{ estudiantes.filter(e => e.estado === 'ACTIVO').length }}</p>
        </div>
      </div>
      <div class="glass-card rounded-[2.5rem] p-8 flex items-center gap-6 group hover:-translate-y-1 transition-all duration-500 !border-none shadow-2xl">
        <div class="w-16 h-16 rounded-2xl bg-blue-500/10 flex items-center justify-center text-blue-500 group-hover:shadow-blue-500/20 transition-all">
          <span class="material-symbols-outlined text-3xl">verified</span>
        </div>
        <div>
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest mb-1">Verificados</p>
          <p class="text-4xl font-black text-on-surface font-lexend tracking-tight">{{ estudiantes.filter(e => e.correo_verificado).length }}</p>
        </div>
      </div>
      <div class="glass-card rounded-[2.5rem] p-8 flex items-center gap-6 group hover:-translate-y-1 transition-all duration-500 !border-none shadow-2xl">
        <div class="w-16 h-16 rounded-2xl bg-red-500/10 flex items-center justify-center text-red-500 group-hover:shadow-red-500/20 transition-all">
          <span class="material-symbols-outlined text-3xl">block</span>
        </div>
        <div>
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest mb-1">Suspendidos</p>
          <p class="text-4xl font-black text-on-surface font-lexend tracking-tight">{{ estudiantes.filter(e => e.estado !== 'ACTIVO').length }}</p>
        </div>
      </div>
    </div>

    <!-- Students Table -->
    <div class="glass-card-premium rounded-[40px] overflow-hidden shadow-2xl relative min-h-[400px] !border-none">
      <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
        <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando estudiantes...</p>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full min-w-[1000px] text-left border-separate border-spacing-0">
          <thead>
            <tr class="bg-on-surface/[0.03]">
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Estudiante</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">CI / Identidad</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Contacto</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Estado</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest text-right">Acciones Directas</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="estudiante in filteredEstudiantes" :key="estudiante.id" class="group hover:bg-accent-neon/[0.02] transition-all duration-500 relative">
              <td class="p-6">
                <div class="flex items-center gap-4 group/user">
                  <div class="relative shrink-0">
                    <router-link :to="{ name: 'admin-estudiante-detalle', params: { id: estudiante.id } }" class="relative block">
                      <div class="grid h-10 w-10 shrink-0 place-items-center rounded-xl bg-gradient-to-br from-accent-neon to-accent-solar p-[2px]">
                        <img :src="estudiante.imagen_perfil || 'https://i.pravatar.cc/150?u=' + estudiante.id" class="w-full h-full object-cover group-hover/user:scale-110 transition-transform duration-700" />
                        <div class="absolute inset-0 bg-accent-neon/20 opacity-0 group-hover/user:opacity-100 flex items-center justify-center transition-all duration-500 backdrop-blur-[2px]">
                          <span class="material-symbols-outlined text-white text-xl">visibility</span>
                        </div>
                      </div>
                    </router-link>
                  </div>
                  <div class="flex flex-col">
                    <router-link :to="{ name: 'admin-estudiante-detalle', params: { id: estudiante.id } }" class="text-base font-black text-on-surface hover:text-accent-neon transition-all duration-300 tracking-tight leading-tight">
                      {{ estudiante.nombres }} {{ estudiante.apellidos }}
                    </router-link>
                    <span class="text-[10px] text-on-surface/40 font-bold uppercase tracking-tighter mt-1">Registrado: {{ new Date(estudiante.fecha_creacion).toLocaleDateString() }}</span>
                  </div>
                </div>
              </td>
              <td class="p-6">
                <span class="text-xs font-black text-on-surface/60 tracking-wider">{{ estudiante.ci || 'PENDIENTE' }}</span>
              </td>
              <td class="p-6">
                <div class="flex flex-col gap-1">
                  <span class="text-xs text-on-surface/80 font-bold flex items-center gap-2">
                    {{ estudiante.correo }}
                    <span v-if="estudiante.correo_verificado" class="material-symbols-outlined text-[14px] text-blue-500" title="Verificado">verified</span>
                  </span>
                  <span class="text-[9px] text-on-surface/40 font-black tracking-widest uppercase">{{ estudiante.telefono || 'Sin Teléfono' }}</span>
                </div>
              </td>
              <td class="p-6">
                <div class="flex items-center gap-2">
                  <div :class="['w-2 h-2 rounded-full shadow-lg', estudiante.estado === 'ACTIVO' ? 'bg-green-500 shadow-green-500/50' : 'bg-red-500 shadow-red-500/50']"></div>
                  <span class="text-[10px] font-black uppercase tracking-widest text-on-surface/60">
                    {{ estudiante.estado }}
                  </span>
                </div>
              </td>
              <td class="p-6 text-right">
                <div class="flex justify-end gap-3">
                  <router-link :to="{ name: 'admin-estudiante-detalle', params: { id: estudiante.id } }" class="w-11 h-11 rounded-xl bg-cyan-500/10 flex items-center justify-center text-cyan-500 hover:bg-cyan-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-sm hover:shadow-cyan-500/20" title="Ver Detalle">
                    <span class="material-symbols-outlined text-xl">visibility</span>
                  </router-link>
                  <router-link :to="'/admin/estudiantes/editar/' + estudiante.id" class="w-11 h-11 rounded-xl bg-blue-500/10 flex items-center justify-center text-blue-500 hover:bg-blue-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-sm hover:shadow-blue-500/20" title="Editar">
                    <span class="material-symbols-outlined text-xl">edit</span>
                  </router-link>
                  <button @click="toggleStatus(estudiante)" class="w-11 h-11 rounded-xl bg-emerald-500/10 flex items-center justify-center text-emerald-500 hover:bg-emerald-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-sm hover:shadow-emerald-500/20" title="Alternar Estado">
                    <span class="material-symbols-outlined text-xl">{{ estudiante.estado === 'ACTIVO' ? 'block' : 'check_circle' }}</span>
                  </button>
                  <button @click="deleteEstudiante(estudiante.id)" class="w-11 h-11 rounded-xl bg-red-500/10 flex items-center justify-center text-red-500 hover:bg-red-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-sm hover:shadow-red-500/20" title="Eliminar">
                    <span class="material-symbols-outlined text-xl">delete</span>
                  </button>
                </div>
              </td>
            </tr>
            <tr v-if="filteredEstudiantes.length === 0">
              <td colspan="5" class="p-20 text-center">
                <div class="flex flex-col items-center gap-4 text-on-surface/20">
                  <span class="material-symbols-outlined text-6xl">group_off</span>
                  <p class="text-sm font-black uppercase tracking-widest">No se encontraron estudiantes</p>
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
import { ref, onMounted, computed } from 'vue'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'

const estudiantes = ref([])
const loading = ref(true)
const searchQuery = ref('')
const notificationStore = useNotificationStore()
const modalStore = useModalStore()

const fetchEstudiantes = async () => {
  loading.value = true
  try {
    const res = await api.get('/usuarios/rol/estudiante')
    estudiantes.value = res.data
  } catch (error) {
    console.error('Error fetching students:', error)
  } finally {
    loading.value = false
  }
}

const filteredEstudiantes = computed(() => {
  if (!searchQuery.value) return estudiantes.value
  const q = searchQuery.value.toLowerCase()
  return estudiantes.value.filter(e => 
    e.nombres?.toLowerCase().includes(q) ||
    e.apellidos?.toLowerCase().includes(q) ||
    e.correo?.toLowerCase().includes(q) ||
    e.ci?.includes(q)
  )
})

const toggleStatus = async (estudiante) => {
  try {
    const newStatus = estudiante.estado === 'ACTIVO' ? 'INACTIVO' : 'ACTIVO'
    await api.patch(`/usuarios/${estudiante.id}`, { estado: newStatus })
    estudiante.estado = newStatus
    notificationStore.addNotification({
      title: 'Estado Actualizado',
      message: `El estudiante ahora está ${newStatus.toLowerCase()}.`,
      type: 'success'
    })
  } catch (error) {
    console.error('Error updating status:', error)
    notificationStore.addNotification({
      title: 'Error de Actualización',
      message: 'No se pudo cambiar el estado del estudiante.',
      type: 'error'
    })
  }
}

const deleteEstudiante = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Estudiante?',
    message: 'Esta acción eliminará permanentemente la cuenta. No se puede deshacer.',
    confirmText: 'Sí, Eliminar',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/usuarios/${id}`)
        estudiantes.value = estudiantes.value.filter(e => e.id !== id)
        notificationStore.addNotification({
          title: 'Estudiante Eliminado',
          message: 'El registro ha sido removido exitosamente.',
          type: 'success'
        })
      } catch (error) {
        console.error('Error deleting student:', error)
        notificationStore.addNotification({
          title: 'Error al Eliminar',
          message: 'No se pudo completar la operación.',
          type: 'error'
        })
      }
    }
  })
}

onMounted(() => {
  fetchEstudiantes()
})
</script>
