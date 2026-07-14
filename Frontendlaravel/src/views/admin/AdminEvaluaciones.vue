<template>
  <div class="space-y-10 animate-fade-in text-on-surface">
    <!-- Header -->
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-6">
      <div>
        <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">Gestión de <span class="text-accent-neon italic">Evaluaciones</span></h2>
        <p class="text-on-surface/40 mt-1 text-xs font-bold uppercase tracking-widest">Crea y administra los exámenes de tus cursos</p>
      </div>
      <button @click="toggleForm()" class="btn-premium btn-primary-neon !py-4 gap-2">
        <span class="material-symbols-outlined text-sm">{{ showForm ? 'close' : 'add_circle' }}</span>
        {{ showForm ? 'Cancelar' : 'Nueva Evaluación' }}
      </button>
    </div>

    <!-- Inline Form Panel -->
    <transition name="slide-fade">
      <div v-if="showForm" class="glass-card p-6 sm:p-8 rounded-[32px]">
        <div class="flex items-center gap-3 mb-6">
          <div class="w-10 h-10 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
            <span class="material-symbols-outlined text-sm">{{ isEditing ? 'edit' : 'quiz' }}</span>
          </div>
          <div>
            <h3 class="text-lg font-black text-on-surface font-lexend tracking-tighter">
              {{ isEditing ? 'Editar' : 'Nueva' }} <span class="text-accent-neon italic">Evaluación</span>
            </h3>
            <p class="text-[10px] font-bold text-on-surface/40 uppercase tracking-widest">Configura los parámetros del examen</p>
          </div>
        </div>

        <form @submit.prevent="saveEvaluacion" class="space-y-6">
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Título de la Evaluación</label>
              <input v-model="form.titulo" type="text" required class="input-cyber w-full" placeholder="Ej. Examen Final de Instalaciones" />
            </div>

            <div class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Curso Asociado</label>
              <select v-model="form.curso_id" required class="input-cyber w-full appearance-none cursor-pointer !text-on-surface">
                <option value="" disabled class="bg-surface-container text-on-surface/50">Selecciona un curso</option>
                <option v-for="curso in cursos" :key="curso.id" :value="curso.id" class="bg-surface-container text-on-surface">{{ curso.titulo }}</option>
              </select>
            </div>
          </div>

          <div class="grid grid-cols-1 sm:grid-cols-3 gap-6">
            <div class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Min. Aprobación (%)</label>
              <input v-model="form.nota_aprobacion" type="number" required min="1" max="100" class="input-cyber w-full" />
            </div>
            <div class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Intentos Permitidos</label>
              <input v-model="form.intentos_permitidos" type="number" required min="1" class="input-cyber w-full" />
            </div>
            <div class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Tiempo Límite (min)</label>
              <input v-model="form.tiempo_limite" type="number" required min="1" class="input-cyber w-full" placeholder="Ej. 60" />
            </div>
          </div>

          <div class="space-y-2">
            <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Descripción (Opcional)</label>
            <input v-model="form.descripcion" type="text" class="input-cyber w-full" placeholder="Breve descripción del examen..." />
          </div>

          <div class="flex justify-end gap-3 pt-2">
            <button type="button" @click="showForm = false" class="btn-premium glass-card justify-center !py-3.5 !px-6">Cancelar</button>
            <button type="submit" :disabled="saving" class="btn-premium btn-primary-neon justify-center !py-3.5 !px-8">
              <span v-if="saving" class="animate-spin rounded-full h-4 w-4 border-t-2 border-primary"></span>
              <span v-else>{{ isEditing ? 'Actualizar' : 'Crear Evaluación' }}</span>
            </button>
          </div>
        </form>
      </div>
    </transition>

    <!-- Evaluations List -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
      <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
        <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando evaluaciones...</p>
      </div>
      <div v-for="evaluacion in evaluaciones" :key="evaluacion.id" class="glass-card p-8 rounded-[40px] group transition-all flex flex-col">
        <div class="flex justify-between items-start mb-6">
          <div class="w-14 h-14 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon group-hover:scale-110 transition-transform">
            <span class="material-symbols-outlined text-3xl">quiz</span>
          </div>
          <div class="flex gap-2">
            <button @click="editEvaluacion(evaluacion)" class="w-10 h-10 rounded-xl bg-blue-500/10 flex items-center justify-center text-blue-500 hover:bg-blue-600 hover:text-white transition-all duration-300" title="Editar">
              <span class="material-symbols-outlined text-xl">edit</span>
            </button>
            <button @click="deleteEvaluacion(evaluacion.id)" class="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center text-red-500 hover:bg-red-600 hover:text-white transition-all duration-300" title="Eliminar">
              <span class="material-symbols-outlined text-xl">delete</span>
            </button>
          </div>
        </div>

        <h3 class="text-xl font-black mb-2 line-clamp-1 group-hover:text-accent-neon transition-colors">{{ evaluacion.titulo }}</h3>
        <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest mb-6">Curso: {{ evaluacion.curso?.titulo || 'Sin curso' }}</p>
        
        <div class="mt-auto space-y-4 pt-6">
          <div class="flex justify-between text-[10px] font-black uppercase tracking-tighter">
            <span class="text-on-surface/40">Preguntas</span>
            <span class="text-on-surface">{{ evaluacion.preguntas_count ?? evaluacion._count?.preguntas ?? 0 }} ítems</span>
          </div>
          <div class="flex justify-between text-[10px] font-black uppercase tracking-tighter">
            <span class="text-on-surface/40">Min. Aprobación</span>
            <span class="text-accent-neon">{{ evaluacion.porcentaje_aprobacion }}%</span>
          </div>
          <div class="flex justify-between text-[10px] font-black uppercase tracking-tighter">
            <span class="text-on-surface/40">Intentos</span>
            <span class="text-on-surface">{{ evaluacion.intentos_permitidos }}</span>
          </div>
          <div class="flex justify-between text-[10px] font-black uppercase tracking-tighter">
            <span class="text-on-surface/40">Tiempo Límite</span>
            <span class="text-on-surface">{{ evaluacion.tiempo_limite || 0 }} min</span>
          </div>
        </div>

        <button @click="manageQuestions(evaluacion)" class="btn-premium btn-secondary-glass !w-full mt-8 !py-3 !text-[10px] gap-2">
           <span class="material-symbols-outlined text-sm">format_list_bulleted</span>
           Gestionar Preguntas
        </button>
      </div>

      <div v-if="evaluaciones.length === 0 && !loading" class="col-span-full py-20 text-center">
         <div class="flex flex-col items-center gap-4 text-on-surface/20">
            <span class="material-symbols-outlined text-6xl">rule</span>
            <p class="text-sm font-black uppercase tracking-widest">No hay evaluaciones registradas</p>
         </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'

const notificationStore = useNotificationStore()
const modalStore = useModalStore()

const router = useRouter()

const evaluaciones = ref([])
const cursos = ref([])
const loading = ref(true)
const saving = ref(false)
const showForm = ref(false)
const isEditing = ref(false)
const form = ref({
  titulo: '',
  descripcion: '',
  curso_id: '',
  nota_aprobacion: 70,
  intentos_permitidos: 2,
  tiempo_limite: 60
})

const fetchEvaluaciones = async () => {
  loading.value = true
  try {
    const res = await api.get('/evaluaciones')
    evaluaciones.value = res.data
  } catch (error) {
    console.error('Error fetching evaluations:', error)
  } finally {
    loading.value = false
  }
}

const fetchCourses = async () => {
  try {
    const res = await api.get('/cursos')
    cursos.value = res.data
  } catch (error) {
    console.error('Error fetching courses:', error)
  }
}

const toggleForm = () => {
  if (showForm.value) {
    showForm.value = false
  } else {
    isEditing.value = false
    form.value = { titulo: '', descripcion: '', curso_id: cursos.value[0]?.id || '', nota_aprobacion: 70, intentos_permitidos: 2, tiempo_limite: 60 }
    showForm.value = true
  }
}

const saveEvaluacion = async () => {
  saving.value = true
  try {
    if (isEditing.value) {
      await api.patch(`/evaluaciones/${form.value.id}`, form.value)
    } else {
      await api.post('/evaluaciones', form.value)
    }
    showForm.value = false
    await fetchEvaluaciones()
    notificationStore.addNotification({
      title: isEditing.value ? 'Evaluación Actualizada' : 'Evaluación Creada',
      message: 'Los parámetros del examen se han guardado.',
      type: 'success'
    })
  } catch (error) {
    console.error('Error saving evaluation:', error)
    notificationStore.addNotification({
      title: 'Error de Guardado',
      message: 'No se pudo registrar la evaluación.',
      type: 'error'
    })
  } finally {
    saving.value = false
  }
}

const editEvaluacion = (evaluacion) => {
  isEditing.value = true
  form.value = { 
    ...evaluacion,
    nota_aprobacion: evaluacion.nota_aprobacion || 70,
    intentos_permitidos: evaluacion.intentos_permitidos || 2,
    tiempo_limite: evaluacion.tiempo_limite || 60
  }
  showForm.value = true
}

const deleteEvaluacion = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Evaluación?',
    message: 'Esta acción borrará el examen y todos los registros de intentos de los estudiantes.',
    confirmText: 'Sí, Eliminar Examen',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/evaluaciones/${id}`)
        evaluaciones.value = evaluaciones.value.filter(e => e.id !== id)
        notificationStore.addNotification({
          title: 'Examen Eliminado',
          message: 'La evaluación ha sido removida del sistema.',
          type: 'success'
        })
      } catch (error) {
        console.error('Error deleting evaluation:', error)
        notificationStore.addNotification({
          title: 'Error al Borrar',
          message: 'No se pudo eliminar el examen.',
          type: 'error'
        })
      }
    }
  })
}

const manageQuestions = (evaluacion) => {
  router.push({ name: 'admin-preguntas', params: { id: evaluacion.id } })
}

onMounted(() => {
  fetchEvaluaciones()
  fetchCourses()
})
</script>

<style scoped>
.slide-fade-enter-active { transition: all 0.35s cubic-bezier(0.23, 1, 0.32, 1); }
.slide-fade-leave-active { transition: all 0.2s ease-in; }
.slide-fade-enter-from { transform: translateY(-12px); opacity: 0; }
.slide-fade-leave-to { transform: translateY(-8px); opacity: 0; }
</style>
