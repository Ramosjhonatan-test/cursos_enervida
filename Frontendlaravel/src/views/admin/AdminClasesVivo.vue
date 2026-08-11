<template>
  <div class="space-y-12 animate-in fade-in duration-700 text-on-surface">
    <div class="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-8">
      <div>
        <h2 class="text-4xl md:text-6xl font-black text-on-surface font-lexend tracking-tighter">Clases <span class="text-accent-neon italic">En Vivo</span></h2>
        <p class="text-on-surface/60 mt-4 text-lg font-light">Gestiona las sesiones síncronas de Jitsi Meet.</p>
      </div>
      <button @click="openModal()" class="btn-premium btn-primary-neon !px-10 !py-5 gap-3 shadow-2xl flex items-center shrink-0">
        <span class="material-symbols-outlined font-black">add</span>
        Nueva Sesión
      </button>
    </div>

    <!-- Classes Grid -->
    <div v-if="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <div v-for="i in 6" :key="i" class="glass-card-premium h-64 rounded-[40px] loading-pulse"></div>
    </div>
    
    <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <div v-for="clase in clases" :key="clase.id" class="glass-card-premium p-10 rounded-[48px] flex flex-col group hover:bg-on-surface/[0.03] transition-all relative overflow-hidden bg-surface/40 dark:bg-slate-900/40 border border-white/5 shadow-xl">
        <div class="flex justify-between items-start mb-8">
          <div class="w-14 h-14 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon shrink-0">
            <span class="material-symbols-outlined text-2xl font-black">videocam</span>
          </div>
          <div class="flex gap-2">
            <button @click="openModal(clase)" class="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center text-on-surface/60 hover:text-accent-neon hover:bg-accent-neon/10 transition-all border border-white/5">
              <span class="material-symbols-outlined text-sm">edit</span>
            </button>
            <button @click="deleteClase(clase.id)" class="w-10 h-10 rounded-xl bg-white/5 flex items-center justify-center text-on-surface/60 hover:text-red-500 hover:bg-red-500/10 transition-all border border-white/5">
              <span class="material-symbols-outlined text-sm">delete</span>
            </button>
          </div>
        </div>

        <h3 class="text-xl font-black font-lexend mb-3 leading-tight group-hover:text-accent-neon transition-colors text-on-surface">{{ clase.titulo }}</h3>
        <p class="text-[10px] font-black text-on-surface/60 uppercase tracking-widest mb-6">{{ clase.curso?.titulo || 'Curso no asignado' }}</p>
        
        <div class="space-y-3 mb-10 bg-black/20 p-4 rounded-2xl border border-white/5">
          <div class="flex items-center gap-3 text-on-surface/80">
            <span class="material-symbols-outlined text-sm text-accent-neon">calendar_month</span>
            <span class="text-xs font-bold">{{ new Date(clase.fecha_inicio).toLocaleDateString() }}</span>
          </div>
          <div class="flex items-center gap-3 text-on-surface/80">
            <span class="material-symbols-outlined text-sm text-accent-neon">schedule</span>
            <span class="text-xs font-bold">{{ new Date(clase.fecha_inicio).toLocaleTimeString([], {hour:'2-digit', minute:'2-digit'}) }}</span>
          </div>
        </div>

        <div class="mt-auto pt-6 flex justify-between items-center border-t border-white/5">
          <span class="text-[9px] font-black text-on-surface/60 uppercase tracking-widest truncate max-w-[150px]" :title="clase.sala_jitsi">Sala: {{ clase.sala_jitsi }}</span>
          <a :href="'https://meet.jit.si/' + clase.sala_jitsi" target="_blank" class="px-3 py-1.5 bg-accent-neon/10 text-accent-neon text-[10px] font-black rounded-lg hover:bg-accent-neon hover:text-background transition-all uppercase tracking-wider flex items-center gap-1 shrink-0">
            <span>Abrir Sala</span>
            <span class="material-symbols-outlined text-[10px]">open_in_new</span>
          </a>
        </div>
      </div>
      
      <div v-if="!clases.length" class="col-span-full py-20 text-center glass-card-premium rounded-[48px] bg-surface/40 dark:bg-slate-900/40 border border-white/5">
        <span class="material-symbols-outlined text-4xl text-on-surface/40 mb-3 block">videocam_off</span>
        <p class="text-[10px] font-black text-on-surface/60 uppercase tracking-widest">No hay clases en vivo programadas</p>
      </div>
    </div>

    <!-- Modal Form con Teleport y Bloqueo de Scroll -->
    <teleport to="body">
      <transition name="fade">
        <div v-if="showModal" class="fixed inset-0 z-[300] flex items-center justify-center bg-black/80 backdrop-blur-md p-4 sm:p-6" @click="closeModal">
          <div class="glass-card-premium relative max-w-3xl w-full max-h-[88vh] bg-surface dark:bg-surface border border-white/10 p-6 sm:p-10 rounded-[48px] flex flex-col gap-6 shadow-[0_40px_80px_rgba(0,0,0,0.35)] overflow-hidden text-on-surface" @click.stop>
            
            <!-- Encabezado del Modal -->
            <div class="flex items-center justify-between border-b border-white/10 pb-6 shrink-0">
              <div class="flex items-center gap-3">
                <div class="flex h-12 w-12 items-center justify-center rounded-2xl bg-accent-neon/10 text-accent-neon shrink-0">
                  <span class="material-symbols-outlined text-2xl font-black">videocam</span>
                </div>
                <div>
                  <h3 class="text-2xl font-black tracking-tight font-lexend text-on-surface">
                    {{ isEditing ? 'Editar' : 'Nueva' }} <span class="text-accent-neon italic">Sesión</span>
                  </h3>
                  <p class="text-xs font-medium text-on-surface/60 mt-1">
                    Completa los datos de la clase en vivo para crear una sesión lista para tus estudiantes.
                  </p>
                </div>
              </div>

              <button type="button" @click="closeModal" class="p-2.5 rounded-2xl bg-white/5 text-on-surface/60 hover:text-on-surface hover:bg-white/10 transition-colors border border-white/5 shrink-0">
                <span class="material-symbols-outlined text-xl">close</span>
              </button>
            </div>

            <!-- Formulario con Scroll Interno -->
            <form @submit.prevent="saveClase" class="space-y-6 overflow-y-auto flex-1 p-1 custom-scrollbar">
              <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="space-y-2">
                  <label class="text-[10px] font-black text-on-surface/60 uppercase tracking-widest">Título de la Sesión</label>
                  <input v-model="form.titulo" type="text" required placeholder="Ej. Introducción al Desarrollo Web" class="w-full bg-black/30 border border-white/10 rounded-2xl px-5 py-3.5 text-sm font-bold text-on-surface placeholder:text-on-surface/30 focus:border-accent-neon/50 focus:bg-black/50 transition-all outline-none" />
                </div>
                <div class="space-y-2">
                  <label class="text-[10px] font-black text-on-surface/60 uppercase tracking-widest">Curso Asignado</label>
                  <select v-model="form.curso_id" required class="w-full bg-black/30 border border-white/10 rounded-2xl px-5 py-3.5 text-sm font-bold text-on-surface focus:border-accent-neon/50 focus:bg-black/50 transition-all outline-none appearance-none cursor-pointer">
                    <option disabled value="" class="bg-slate-900 text-on-surface">Selecciona un curso</option>
                    <option v-for="curso in cursos" :key="curso.id" :value="curso.id" class="bg-slate-900 text-on-surface">{{ curso.titulo }}</option>
                  </select>
                </div>
              </div>

              <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="space-y-2">
                  <label class="text-[10px] font-black text-on-surface/60 uppercase tracking-widest">Fecha y Hora de Inicio</label>
                  <input v-model="form.fecha_inicio" type="datetime-local" required class="w-full bg-black/30 border border-white/10 rounded-2xl px-5 py-3.5 text-sm font-bold text-on-surface focus:border-accent-neon/50 focus:bg-black/50 transition-all outline-none cursor-pointer" />
                </div>
                <div class="space-y-2">
                  <label class="text-[10px] font-black text-on-surface/60 uppercase tracking-widest">Nombre de Sala (Jitsi)</label>
                  <input v-model="form.sala_jitsi" type="text" required class="w-full bg-black/30 border border-white/10 rounded-2xl px-5 py-3.5 text-sm font-bold text-on-surface focus:border-accent-neon/50 focus:bg-black/50 transition-all outline-none font-mono" />
                </div>
              </div>

              <div class="space-y-2">
                <label class="text-[10px] font-black text-on-surface/60 uppercase tracking-widest">Descripción (Opcional)</label>
                <textarea v-model="form.descripcion" rows="3" placeholder="Detalles o requerimientos previos para la clase..." class="w-full bg-black/30 border border-white/10 rounded-2xl px-5 py-3.5 text-sm font-bold text-on-surface placeholder:text-on-surface/30 focus:border-accent-neon/50 focus:bg-black/50 transition-all outline-none resize-none"></textarea>
              </div>

              <!-- Pie de Página (Acciones del Modal) -->
              <div class="flex items-center justify-end gap-4 pt-4 border-t border-white/10 shrink-0">
                <button type="button" @click="closeModal" class="px-6 py-3 rounded-xl bg-white/5 border border-white/10 text-on-surface/80 hover:text-on-surface hover:border-white/20 text-xs font-bold transition-all">
                  Cancelar
                </button>
                <button type="submit" :disabled="saving" class="px-8 py-3 rounded-xl bg-accent-neon text-background text-xs font-black uppercase tracking-widest shadow-lg hover:shadow-accent-neon/20 hover:-translate-y-0.5 active:scale-95 transition-all disabled:opacity-50 flex items-center gap-2">
                  <span v-if="saving" class="material-symbols-outlined text-sm animate-spin">sync</span>
                  <span>{{ saving ? 'Guardando...' : 'Guardar Sesión' }}</span>
                </button>
              </div>
            </form>

          </div>
        </div>
      </transition>
    </teleport>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue'
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
  creado_por: authStore.user?.id || 1
})

// Control para bloquear el scroll del body cuando el modal está abierto
watch(showModal, (value) => {
  if (value) {
    document.body.style.overflow = 'hidden'
  } else {
    document.body.style.overflow = ''
  }
})

const closeModal = () => {
  showModal.value = false
}

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
      creado_por: authStore.user?.id || 1
    }
  }
  showModal.value = true
}

const saveClase = async () => {
  saving.value = true
  try {
    const payload = {
      curso_id: form.value.curso_id,
      titulo: form.value.titulo,
      descripcion: form.value.descripcion,
      sala_jitsi: form.value.sala_jitsi,
      creado_por: form.value.creado_por,
      fecha_inicio: new Date(form.value.fecha_inicio).toISOString(),
      fecha_fin: form.value.fecha_fin ? new Date(form.value.fecha_fin).toISOString() : null,
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
  backdrop-filter: blur(20px);
}

.fade-enter-active, .fade-leave-active { transition: opacity 0.3s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>