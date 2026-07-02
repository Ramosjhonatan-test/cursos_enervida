<template>
  <div class="space-y-8 animate-fade-in text-on-surface pb-20">
    <!-- Header -->
    <div class="flex flex-col md:flex-row md:items-center justify-between gap-6">
      <div class="flex items-center gap-4">
        <router-link to="/admin/evaluaciones" class="w-10 h-10 rounded-xl bg-blue-500/10 flex items-center justify-center text-blue-500 hover:bg-blue-600 hover:text-white transition-all duration-300" title="Volver">
          <span class="material-symbols-outlined text-xl">arrow_back</span>
        </router-link>
        <div>
          <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">
            Preguntas: <span class="text-accent-neon italic">{{ evaluacion?.titulo }}</span>
          </h2>
          <p class="text-on-surface/40 mt-1 text-[10px] font-black uppercase tracking-widest">
            {{ evaluacion?.preguntas?.length || 0 }} preguntas configuradas
          </p>
        </div>
      </div>
      <button @click="togglePreguntaForm()" class="btn-premium btn-primary-neon !py-4 gap-2">
        <span class="material-symbols-outlined text-sm">{{ showModal ? 'close' : 'add_circle' }}</span>
        {{ showModal ? 'Cancelar' : 'Nueva Pregunta' }}
      </button>
    </div>

    <!-- Inline Pregunta Form Panel -->
    <transition name="slide-fade">
      <div v-if="showModal" class="glass-card p-6 sm:p-8 rounded-[32px]">
        <div class="flex items-center gap-3 mb-6">
          <div class="w-10 h-10 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
            <span class="material-symbols-outlined text-sm">{{ isEditing ? 'edit' : 'help_outline' }}</span>
          </div>
          <div>
            <h3 class="text-lg font-black text-on-surface font-lexend tracking-tighter">
              {{ isEditing ? 'Editar' : 'Nueva' }} <span class="text-accent-neon italic">Pregunta</span>
            </h3>
            <p class="text-[10px] font-bold text-on-surface/40 uppercase tracking-widest">Configura el enunciado y tipo</p>
          </div>
        </div>

        <form @submit.prevent="savePregunta" class="space-y-6">
          <div class="space-y-2">
            <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Enunciado de la pregunta</label>
            <textarea v-model="form.pregunta" required rows="3" class="input-cyber w-full" placeholder="Ej. ¿Cuál es la capital de...?"></textarea>
          </div>
          
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
            <div class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Tipo de Pregunta</label>
              <select v-model="form.tipo_pregunta" class="input-cyber w-full appearance-none cursor-pointer !text-on-surface">
                <option value="MULTIPLE_CHOICE" class="bg-surface-container text-on-surface">Opción Múltiple</option>
                <option value="TRUE_FALSE" class="bg-surface-container text-on-surface">Falso / Verdadero</option>
              </select>
            </div>
            <div class="space-y-2">
              <label class="text-[11px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Puntos</label>
              <input v-model="form.puntos" type="number" required min="1" class="input-cyber w-full" />
            </div>
          </div>

          <div class="flex justify-end gap-3 pt-2">
            <button type="button" @click="showModal = false" class="btn-premium glass-card justify-center !py-3.5 !px-6">Cancelar</button>
            <button type="submit" :disabled="saving" class="btn-premium btn-primary-neon justify-center !py-3.5 !px-8 gap-2">
              <span v-if="saving" class="animate-spin material-symbols-outlined text-sm">refresh</span>
              {{ isEditing ? 'Actualizar Pregunta' : 'Crear Pregunta' }}
            </button>
          </div>
        </form>
      </div>
    </transition>

    <!-- Questions List -->
    <div v-if="loading" class="flex flex-col items-center py-20 gap-4">
      <div class="animate-spin rounded-full h-12 w-12 border-t-2 border-accent-neon"></div>
      <p class="text-[10px] font-black uppercase tracking-widest text-accent-neon">Cargando preguntas...</p>
    </div>

    <div v-else-if="evaluacion?.preguntas?.length === 0" class="glass-card p-20 rounded-[40px] text-center">
      <span class="material-symbols-outlined text-6xl text-on-surface/10 mb-4 block">quiz</span>
      <h3 class="text-xl font-black text-on-surface/40">No hay preguntas aún</h3>
      <p class="text-xs font-bold text-on-surface/20 uppercase tracking-widest mt-2">Comienza agregando la primera pregunta del examen</p>
    </div>

    <div v-else class="space-y-8">
      <div v-for="(pregunta, index) in evaluacion.preguntas" :key="pregunta.id" class="glass-card rounded-[32px] overflow-hidden group">
        <div class="p-6 sm:p-8 bg-on-surface/5 flex justify-between items-start">
          <div class="flex gap-4">
            <div class="w-10 h-10 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon font-black shrink-0">
              {{ index + 1 }}
            </div>
            <div>
              <h3 class="text-lg font-bold leading-tight">{{ pregunta.pregunta }}</h3>
              <div class="flex gap-3 mt-2">
                <span class="text-[9px] font-black uppercase tracking-widest px-2 py-1 bg-on-surface/5 rounded text-on-surface/40">
                  {{ pregunta.tipo_pregunta }}
                </span>
                <span class="text-[9px] font-black uppercase tracking-widest px-2 py-1 bg-accent-neon/10 rounded text-accent-neon">
                  {{ pregunta.puntos }} Puntos
                </span>
              </div>
            </div>
          </div>
          <div class="flex gap-2">
            <button @click="editPregunta(pregunta)" class="w-10 h-10 rounded-xl bg-blue-500/10 flex items-center justify-center text-blue-500 hover:bg-blue-600 hover:text-white transition-all duration-300" title="Editar">
              <span class="material-symbols-outlined text-xl">edit</span>
            </button>
            <button @click="deletePregunta(pregunta.id)" class="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center text-red-500 hover:bg-red-600 hover:text-white transition-all duration-300" title="Eliminar">
              <span class="material-symbols-outlined text-xl">delete</span>
            </button>
          </div>
        </div>

        <!-- Answers Section -->
        <div class="p-6 sm:p-8 space-y-4">
          <div class="flex items-center justify-between mb-4">
             <h4 class="text-[10px] font-black uppercase tracking-widest text-on-surface/40">Opciones de respuesta</h4>
             <button @click="toggleAddRespuesta(pregunta.id)" class="btn-premium btn-secondary-glass !py-2 !px-4 !text-[10px] gap-2">
               <span class="material-symbols-outlined text-xs">{{ activeRespuestaId === pregunta.id ? 'close' : 'add' }}</span>
               {{ activeRespuestaId === pregunta.id ? 'Cancelar' : 'Agregar Opción' }}
             </button>
          </div>

          <!-- Inline Respuesta Form -->
          <transition name="slide-fade">
            <form v-if="activeRespuestaId === pregunta.id" @submit.prevent="saveRespuesta" class="mb-6 p-6 rounded-2xl bg-on-surface/[0.02] space-y-4">
              <div class="space-y-2">
                <label class="text-[10px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Texto de la respuesta</label>
                <input v-model="respForm.respuesta" required class="input-cyber w-full !py-3" placeholder="Ej. París" />
              </div>
              <div class="flex items-center justify-between pt-2">
                <label class="flex items-center gap-3 cursor-pointer group">
                  <div class="relative">
                    <input type="checkbox" v-model="respForm.es_correcta" class="sr-only" />
                    <div :class="['w-10 h-6 rounded-full transition-colors', respForm.es_correcta ? 'bg-accent-neon' : 'bg-on-surface/10']"></div>
                    <div :class="['absolute top-1 left-1 w-4 h-4 rounded-full bg-white transition-transform', respForm.es_correcta ? 'translate-x-4' : '']"></div>
                  </div>
                  <span class="text-[10px] font-black uppercase tracking-widest text-on-surface/60 group-hover:text-accent-neon transition-colors">¿Es la respuesta correcta?</span>
                </label>
                <button type="submit" :disabled="savingResp" class="btn-premium btn-accent-neon !py-2 !px-6 text-[10px]">
                  Guardar Opción
                </button>
              </div>
            </form>
          </transition>
          
          <div v-if="pregunta.respuestas?.length === 0" class="py-6 text-center bg-on-surface/[0.02] rounded-2xl">
            <p class="text-[10px] font-black uppercase tracking-widest text-on-surface/20">Sin opciones registradas</p>
          </div>

          <div v-else class="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div v-for="resp in pregunta.respuestas" :key="resp.id" 
                 :class="['p-4 rounded-2xl flex items-center justify-between transition-all group/item', 
                          resp.es_correcta ? 'bg-accent-neon/5' : 'bg-on-surface/5 hover:bg-on-surface/[0.08]']">
              <div class="flex items-center gap-3">
                <span :class="['material-symbols-outlined text-sm', resp.es_correcta ? 'text-accent-neon' : 'text-on-surface/20']">
                  {{ resp.es_correcta ? 'check_circle' : 'radio_button_unchecked' }}
                </span>
                <span :class="['text-sm font-medium', resp.es_correcta ? 'text-on-surface' : 'text-on-surface/60']">{{ resp.respuesta }}</span>
              </div>
              <div class="flex gap-1 opacity-0 group-hover/item:opacity-100 transition-opacity">
                <button @click="toggleCorrect(resp)" class="p-1.5 hover:text-accent-neon transition-colors" :title="resp.es_correcta ? 'Quitar correcta' : 'Marcar como correcta'">
                  <span class="material-symbols-outlined text-xs">verified</span>
                </button>
                <button @click="deleteRespuesta(resp.id)" class="p-1.5 hover:text-red-500 transition-colors">
                  <span class="material-symbols-outlined text-xs">delete</span>
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'

const notificationStore = useNotificationStore()
const modalStore = useModalStore()

const route = useRoute()
const evaluacion = ref(null)
const loading = ref(true)
const saving = ref(false)
const savingResp = ref(false)

const showModal = ref(false)
const isEditing = ref(false)
const form = ref({
  id: null,
  pregunta: '',
  tipo_pregunta: 'MULTIPLE_CHOICE',
  puntos: 10,
  evaluacion_id: null
})

const activeRespuestaId = ref(null)
const respForm = ref({
  pregunta_id: null,
  respuesta: '',
  es_correcta: false
})

const fetchEvaluacion = async () => {
  loading.value = true
  try {
    const res = await api.get(`/evaluaciones/${route.params.id}`)
    evaluacion.value = res.data
  } catch (error) {
    console.error('Error fetching evaluation:', error)
  } finally {
    loading.value = false
  }
}

const togglePreguntaForm = () => {
  if (showModal.value) {
    showModal.value = false
  } else {
    isEditing.value = false
    form.value = {
      id: null,
      pregunta: '',
      tipo_pregunta: 'MULTIPLE_CHOICE',
      puntos: 10,
      evaluacion_id: parseInt(route.params.id)
    }
    showModal.value = true
  }
}

const editPregunta = (pregunta) => {
  isEditing.value = true
  form.value = { ...pregunta }
  showModal.value = true
}

const savePregunta = async () => {
  saving.value = true
  try {
    if (isEditing.value) {
      await api.patch(`/preguntas/${form.value.id}`, form.value)
    } else {
      await api.post('/preguntas', form.value)
    }
    showModal.value = false
    await fetchEvaluacion()
    notificationStore.addNotification({
      title: isEditing.value ? 'Pregunta Actualizada' : 'Pregunta Creada',
      message: 'Los cambios se han guardado exitosamente.',
      type: 'success'
    })
  } catch (error) {
    console.error('Error saving question:', error)
    notificationStore.addNotification({
      title: 'Error de Configuración',
      message: 'No se pudo guardar la pregunta.',
      type: 'error'
    })
  } finally {
    saving.value = false
  }
}

const deletePregunta = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Pregunta?',
    message: 'Esta acción borrará la pregunta y todas sus opciones de respuesta.',
    confirmText: 'Sí, Eliminar',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/preguntas/${id}`)
        notificationStore.addNotification({
          title: 'Pregunta Removida',
          message: 'El examen ha sido actualizado.',
          type: 'success'
        })
        await fetchEvaluacion()
      } catch (error) {
        console.error('Error deleting question:', error)
        notificationStore.addNotification({
          title: 'Error de Borrado',
          message: 'No se pudo eliminar la pregunta.',
          type: 'error'
        })
      }
    }
  })
}

const toggleAddRespuesta = (preguntaId) => {
  if (activeRespuestaId.value === preguntaId) {
    activeRespuestaId.value = null
  } else {
    activeRespuestaId.value = preguntaId
    respForm.value = {
      pregunta_id: preguntaId,
      respuesta: '',
      es_correcta: false
    }
  }
}

const saveRespuesta = async () => {
  savingResp.value = true
  try {
    await api.post('/respuestas', respForm.value)
    activeRespuestaId.value = null
    await fetchEvaluacion()
    notificationStore.addNotification({
      title: 'Opción Guardada',
      message: 'La respuesta se añadió correctamente.',
      type: 'success'
    })
  } catch (error) {
    console.error('Error saving answer:', error)
    notificationStore.addNotification({
      title: 'Error al Añadir',
      message: 'No se pudo registrar la opción.',
      type: 'error'
    })
  } finally {
    savingResp.value = false
  }
}

const deleteRespuesta = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Opción?',
    message: 'Se removerá esta alternativa de la pregunta.',
    confirmText: 'Borrar',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/respuestas/${id}`)
        notificationStore.addNotification({
          title: 'Opción Eliminada',
          message: 'La respuesta ha sido borrada.',
          type: 'success'
        })
        await fetchEvaluacion()
      } catch (error) {
        console.error('Error deleting answer:', error)
        notificationStore.addNotification({
          title: 'Error de Eliminación',
          message: 'No se pudo borrar la opción.',
          type: 'error'
        })
      }
    }
  })
}

const toggleCorrect = async (resp) => {
  try {
    await api.patch(`/respuestas/${resp.id}`, { es_correcta: !resp.es_correcta })
    await fetchEvaluacion()
  } catch (error) {
    console.error('Error toggling answer correctness:', error)
  }
}

onMounted(() => {
  fetchEvaluacion()
})
</script>

<style scoped>
.slide-fade-enter-active { transition: all 0.35s cubic-bezier(0.23, 1, 0.32, 1); }
.slide-fade-leave-active { transition: all 0.2s ease-in; }
.slide-fade-enter-from { transform: translateY(-12px); opacity: 0; }
.slide-fade-leave-to { transform: translateY(-8px); opacity: 0; }
</style>
