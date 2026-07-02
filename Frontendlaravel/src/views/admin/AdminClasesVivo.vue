<template>
  <div class="space-y-12 animate-in fade-in duration-700">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8">
      <div>
        <h2 class="text-4xl md:text-6xl font-black text-on-surface font-lexend tracking-tighter">Clases <span class="text-accent-neon italic">En Vivo</span></h2>
        <p class="text-on-surface/40 mt-4 text-lg font-light">Gestiona las sesiones síncronas de Jitsi Meet.</p>
      </div>
      <button @click="openModal()" class="btn-premium btn-primary-neon !px-10 !py-5 gap-3 shadow-2xl">
        <span class="material-symbols-outlined font-black ">add</span>
        Nueva Sesión
      </button>
    </div>

    <!-- Classes Grid -->
    <div v-if="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <div v-for="i in 6" :key="i" class="glass-card-premium h-64 rounded-[40px] loading-pulse"></div>
    </div>
    
    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <div v-for="clase in clases" :key="clase.id" class="glass-card-premium p-10 rounded-[48px] flex flex-col group hover:bg-on-surface/[0.03] transition-all">
        <div class="flex justify-between items-start mb-8">
          <div class="w-14 h-14 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
            <span class="material-symbols-outlined text-2xl font-black">videocam</span>
          </div>
          <div class="flex gap-2">
            <button @click="openModal(clase)" class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:text-accent-neon hover:bg-accent-neon/10 transition-all">
              <span class="material-symbols-outlined text-sm">edit</span>
            </button>
            <button @click="deleteClase(clase.id)" class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:text-red-500 hover:bg-red-500/10 transition-all">
              <span class="material-symbols-outlined text-sm">delete</span>
            </button>
          </div>
        </div>

        <h3 class="text-xl font-black font-lexend mb-3 leading-tight group-hover:text-accent-neon transition-colors">{{ clase.titulo }}</h3>
        <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest mb-6">{{ clase.curso?.titulo || 'Curso no asignado' }}</p>
        
        <div class="space-y-3 mb-10">
          <div class="flex items-center gap-3 text-on-surface/60">
            <span class="material-symbols-outlined text-sm">calendar_month</span>
            <span class="text-xs font-bold">{{ new Date(clase.fecha_inicio).toLocaleDateString() }}</span>
          </div>
          <div class="flex items-center gap-3 text-on-surface/60">
            <span class="material-symbols-outlined text-sm">schedule</span>
            <span class="text-xs font-bold">{{ new Date(clase.fecha_inicio).toLocaleTimeString([], {hour:'2-digit', minute:'2-digit'}) }}</span>
          </div>
        </div>

        <div class="mt-auto pt-6 flex justify-between items-center">
          <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Sala: {{ clase.sala_jitsi }}</span>
          <a :href="'https://meet.jit.si/' + clase.sala_jitsi" target="_blank" class="text-accent-neon text-[10px] font-black uppercase tracking-widest hover:underline">Abrir Sala</a>
        </div>
      </div>
    </div>

    <!-- Modal Form -->
    <transition name="fade-slide">
      <div v-if="showModal" class="fixed inset-0 z-[300] flex items-center justify-center p-4">
        <div class="absolute inset-0 bg-background/80 backdrop-blur-xl" @click="showModal = false"></div>
        <div class="relative w-full max-w-2xl bg-surface-variant/90 rounded-[60px] p-10 md:p-16 shadow-2xl">
          <h2 class="text-3xl font-black font-lexend tracking-tighter mb-12">{{ isEditing ? 'Editar' : 'Nueva' }} <span class="text-accent-neon italic text-gradient-neon">Sesión</span></h2>
          
          <form @submit.prevent="saveClase" class="space-y-6">
            <div class="space-y-2">
              <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest px-4">Título de la Sesión</label>
              <input v-model="form.titulo" type="text" required class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon/50 focus:bg-accent-neon/5 transition-all outline-none" />
            </div>

            <div class="space-y-2">
              <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest px-4">Curso Asignado</label>
              <select v-model="form.curso_id" required class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon/50 focus:bg-accent-neon/5 transition-all outline-none appearance-none">
                <option v-for="curso in cursos" :key="curso.id" :value="curso.id">{{ curso.titulo }}</option>
              </select>
            </div>

            <div class="grid grid-cols-2 gap-6">
              <div class="space-y-2">
                <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest px-4">Fecha y Hora de Inicio</label>
                <input v-model="form.fecha_inicio" type="datetime-local" required class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon/50 focus:bg-accent-neon/5 transition-all outline-none" />
              </div>
              <div class="space-y-2">
                <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest px-4">Nombre de Sala (Jitsi)</label>
                <input v-model="form.sala_jitsi" type="text" required class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon/50 focus:bg-accent-neon/5 transition-all outline-none" />
              </div>
            </div>

            <div class="space-y-2">
              <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest px-4">Descripción (Opcional)</label>
              <textarea v-model="form.descripcion" rows="3" class="w-full bg-on-surface/5 rounded-2xl px-6 py-4 text-sm font-bold focus:border-accent-neon/50 focus:bg-accent-neon/5 transition-all outline-none resize-none"></textarea>
            </div>

            <div class="flex gap-4 pt-8">
              <button type="button" @click="showModal = false" class="btn-premium btn-secondary-glass !flex-1 !py-5">Cancelar</button>
              <button type="submit" :disabled="saving" class="btn-premium btn-primary-neon !flex-1 !py-5">{{ saving ? 'Guardando...' : 'Guardar Sesión' }}</button>
            </div>
          </form>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '@/services/api'
import { useAuthStore } from '@/stores/auth'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'

const authStore = useAuthStore()
const notificationStore = useNotificationStore()
const modalStore = useModalStore()

const clases = ref([])
const cursos = ref([])
const loading = ref(true)
const showModal = ref(false)
const isEditing = ref(false)
const saving = ref(false)

const form = ref({
  id: null,
  curso_id: null,
  titulo: '',
  descripcion: '',
  sala_jitsi: '',
  fecha_inicio: '',
  creado_por: authStore.user.id
})

const fetchClases = async () => {
  loading.value = true
  try {
    const res = await api.get('/clases-en-vivo')
    clases.value = res.data
  } catch (error) {
    console.error('Error fetching clases:', error)
  } finally {
    loading.value = false
  }
}

const fetchCursos = async () => {
  try {
    const res = await api.get('/cursos')
    cursos.value = res.data
  } catch (error) {
    console.error('Error fetching cursos:', error)
  }
}

const openModal = (clase = null) => {
  if (clase) {
    isEditing.value = true
    form.value = { 
      ...clase,
      fecha_inicio: new Date(clase.fecha_inicio).toISOString().slice(0, 16)
    }
  } else {
    isEditing.value = false
    form.value = {
      id: null,
      curso_id: cursos.value[0]?.id || null,
      titulo: '',
      descripcion: '',
      sala_jitsi: 'Enervida-Aula-' + Math.floor(Math.random() * 1000),
      fecha_inicio: new Date().toISOString().slice(0, 16),
      creado_por: authStore.user.id
    }
  }
  showModal.value = true
}

const saveClase = async () => {
  saving.value = true
  try {
    const payload = {
      ...form.value,
      fecha_inicio: new Date(form.value.fecha_inicio).toISOString()
    }
    
    if (isEditing.value) {
      await api.patch(`/clases-en-vivo/${form.value.id}`, payload)
      notificationStore.addNotification({
        title: 'Sesión Actualizada',
        message: 'Los cambios se han guardado correctamente.',
        type: 'success'
      })
    } else {
      await api.post('/clases-en-vivo', payload)
      notificationStore.addNotification({
        title: 'Sesión Programada',
        message: 'La nueva clase en vivo ha sido registrada.',
        type: 'success'
      })
    }
    showModal.value = false
    fetchClases()
  } catch (error) {
    console.error('Error saving clase:', error)
    notificationStore.addNotification({
      title: 'Error de Servidor',
      message: 'No se pudo guardar la sesión de clase.',
      type: 'error'
    })
  } finally {
    saving.value = false
  }
}

const deleteClase = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Sesión?',
    message: 'Esta acción removerá la clase en vivo del calendario.',
    confirmText: 'Sí, Eliminar',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/clases-en-vivo/${id}`)
        notificationStore.addNotification({
          title: 'Sesión Eliminada',
          message: 'La clase ha sido removida del catálogo.',
          type: 'success'
        })
        fetchClases()
      } catch (error) {
        console.error('Error deleting clase:', error)
        notificationStore.addNotification({
          title: 'Error al Borrar',
          message: 'No se pudo completar la operación.',
          type: 'error'
        })
      }
    }
  })
}

onMounted(() => {
  fetchClases()
  fetchCursos()
})
</script>

<style scoped>
.glass-card-premium {
  background: rgba(15, 23, 42, 0.6);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.05);
}

.fade-slide-enter-active, .fade-slide-leave-active { transition: all 0.3s ease; }
.fade-slide-enter-from, .fade-slide-leave-to { transform: translateY(-10px); opacity: 0; }
</style>
