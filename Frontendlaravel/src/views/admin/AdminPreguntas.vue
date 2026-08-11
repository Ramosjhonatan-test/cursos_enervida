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
      <button @click="togglePreguntaForm()" :disabled="evaluacion?.preguntas?.length && allocatedPoints >= 100 && !isEditing" class="btn-premium btn-primary-neon !py-4 gap-2 disabled:cursor-not-allowed" :title="evaluacion?.preguntas?.length && allocatedPoints >= 100 && !isEditing ? 'Ya están asignados 100 puntos' : ''">
        <span class="material-symbols-outlined text-sm">{{ showModal ? 'close' : 'add_circle' }}</span>
        {{ showModal ? 'Cancelar' : 'Nueva Pregunta' }}
      </button>
    </div>
    <div class="glass-card p-4 rounded-3xl flex flex-col sm:flex-row items-center justify-between gap-3">
      <div>
        <p class="text-[10px] font-black uppercase tracking-widest text-on-surface/40">Asignación de puntos</p>
        <p class="text-2xl font-black" :class="allocatedPoints > 100 ? 'text-red-500' : allocatedPoints === 100 ? 'text-green-500' : 'text-on-surface'">{{ allocatedPoints }} / 100</p>
      </div>
      <div class="text-right">
        <p class="text-[10px] font-black uppercase tracking-widest text-on-surface/40">Estado</p>
        <p class="text-sm font-black" :class="allocatedPoints > 100 ? 'text-red-500' : allocatedPoints === 100 ? 'text-green-500' : 'text-on-surface'">
          <template v-if="allocatedPoints > 100">Excedido en {{ allocatedPoints - 100 }} puntos</template>
          <template v-else-if="allocatedPoints === 100">100% completo</template>
          <template v-else>Faltan {{ 100 - allocatedPoints }} puntos</template>
        </p>
      </div>
    </div>

    <!-- Inline Pregunta Form Panel -->
    <transition name="slide-fade">
      <div v-if="showModal" ref="formSection" class="glass-card p-6 sm:p-8 rounded-[32px]">
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
            <textarea v-model="form.pregunta" required rows="3" class="input-cyber w-full" placeholder="Ej. ¿Cual es la pregunta....?"></textarea>
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
              <p class="text-[10px] font-black uppercase tracking-widest mt-2" :class="newTotalPoints > 100 ? 'text-red-500' : 'text-on-surface/70'">
                Total actual: {{ allocatedPoints }} / 100.
                <template v-if="newTotalPoints > 100">Al guardar llegará a {{ newTotalPoints }}.</template>
                <template v-else-if="allocatedPoints === 100">Ya tienen 100 puntos asignados.</template>
                <template v-else>Faltan {{ 100 - allocatedPoints }} puntos para completar.</template>
              </p>
            </div>
          </div>

          <div class="flex justify-end gap-3 pt-2">
            <button type="button" @click="showModal = false" class="btn-premium glass-card justify-center !py-3.5 !px-6">Cancelar</button>
            <button type="submit" :disabled="saving || !canSubmitPregunta" class="btn-premium btn-primary-neon justify-center !py-3.5 !px-8 gap-2 disabled:cursor-not-allowed">
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

    <div v-else class="space-y-8" ref="questionsSection">
      <div v-for="(pregunta, index) in evaluacion.preguntas" :key="pregunta.id" :id="`pregunta-${pregunta.id}`" class="glass-card rounded-[32px] overflow-hidden group">
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
             <template v-if="pregunta.tipo_pregunta !== 'TRUE_FALSE'">
               <button @click="toggleAddRespuesta(pregunta.id)" class="btn-premium btn-secondary-glass !py-2 !px-4 !text-[10px] gap-2">
                 <span class="material-symbols-outlined text-xs">{{ activeRespuestaId === pregunta.id ? 'close' : 'add' }}</span>
                 {{ activeRespuestaId === pregunta.id ? 'Cancelar' : 'Agregar Opción' }}
               </button>
             </template>
             <template v-else>
               <span class="text-[10px] font-bold uppercase tracking-widest text-accent-neon">Seleccione cual sera la respuesta correcta</span>
             </template>
          </div>

          <!-- Inline Respuesta Form -->
          <transition name="slide-fade">
            <form v-if="activeRespuestaId === pregunta.id && pregunta.tipo_pregunta !== 'TRUE_FALSE'" @submit.prevent="saveRespuesta" class="mb-6 p-6 rounded-2xl bg-on-surface/[0.02] space-y-4">
              <div class="space-y-2">
                <label class="text-[10px] font-black uppercase tracking-widest text-on-surface/40 ml-1">Texto de la respuesta</label>
                <input v-model="respForm.respuesta" required class="input-cyber w-full !py-3" placeholder="Ej. Energia" />
              </div>
              <div class="flex items-center justify-between pt-2">
                <label class="flex items-center gap-3 cursor-pointer group">
                  <div class="relative flex items-center justify-center">
                    <input type="checkbox" v-model="respForm.es_correcta" class="sr-only" />
                    <div class="w-10 h-6 rounded-full transition-colors relative" :class="{'bg-accent-neon': respForm.es_correcta, 'bg-gray-200 dark:bg-white/10': !respForm.es_correcta}">
                      <div class="absolute w-4 h-4 bg-white rounded-full top-1 transition-transform shadow-md border border-gray-200/50 dark:border-transparent" :class="respForm.es_correcta ? 'left-5' : 'left-1'"></div>
                    </div>
                  </div>
                  <span class="text-[10px] font-black uppercase tracking-widest text-on-surface/60 group-hover:text-accent-neon transition-colors">¿Es la respuesta correcta?</span>
                </label>
                <button type="submit" :disabled="savingResp" class="btn-premium btn-primary-solar !py-4 gap-2">
                  Guardar Opción
                </button>
              </div>
            </form>
          </transition>
          
          <!-- ESTADO: Sin opciones registradas -->
<div v-if="pregunta.respuestas?.length === 0" class="py-6 text-center bg-gray-200/60 dark:bg-white/5 rounded-2xl">
  <p class="text-[10px] font-black uppercase tracking-widest text-gray-400 dark:text-white/30">Sin opciones registradas</p>
</div>

<!-- ESTADO: Lista de opciones (Recuadro idéntico y fijo para todas las respuestas) -->
<div v-else class="grid grid-cols-1 md:grid-cols-2 gap-3">
  <div v-for="resp in pregunta.respuestas" :key="resp.id"
       class="p-4 rounded-2xl flex items-center justify-between transition-colors duration-150 group/item bg-gray-200/60 dark:bg-white/5 hover:bg-gray-200 dark:hover:bg-white/10">
    
    <!-- Lado Izquierdo: Icono + Texto -->
    <div class="flex items-center gap-3 pr-2 min-w-0">
      <!-- Icono de estado: cambia solo de color si es correcta -->
      <span class="material-symbols-outlined text-lg shrink-0 transition-colors duration-150"
            :class="resp.es_correcta ? 'text-accent-neon' : 'text-gray-400 dark:text-white/30 group-hover/item:text-gray-600 dark:group-hover/item:text-white/60'">
        {{ resp.es_correcta ? 'check_circle' : 'radio_button_unchecked' }}
      </span>
      
      <!-- Texto de la respuesta: cambia negrita/color si es correcta -->
      <span class="text-sm font-medium truncate"
            :class="resp.es_correcta ? 'font-semibold text-gray-900 dark:text-white' : 'text-gray-700 dark:text-white/80'">
        {{ resp.respuesta }}
      </span>
    </div>

    <!-- Lado Derecho: Botones de Acción (Verified & Delete) -->
    <div class="flex items-center gap-1 opacity-0 group-hover/item:opacity-100 transition-opacity duration-150 shrink-0">
      <!-- Botón: Marcar/Quitar Correcta -->
      <button @click="toggleCorrect(resp)" 
              class="p-1.5 rounded-lg transition-colors"
              :class="resp.es_correcta ? 'text-accent-neon bg-accent-neon/20 hover:bg-accent-neon/30' : 'text-gray-400 dark:text-white/40 hover:text-accent-neon hover:bg-accent-neon/10'"
              :title="resp.es_correcta ? 'Quitar correcta' : 'Marcar como correcta'">
        <span class="material-symbols-outlined text-base">verified</span>
      </button>
      
      <!-- Botón: Eliminar Respuesta -->
      <button v-if="pregunta.tipo_pregunta !== 'TRUE_FALSE'" @click="deleteRespuesta(resp.id)" 
              class="p-1.5 rounded-lg text-gray-400 dark:text-white/40 hover:text-red-500 hover:bg-red-500/10 transition-colors"
              title="Eliminar respuesta">
        <span class="material-symbols-outlined text-base">delete</span>
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
import { ref, computed, onMounted, nextTick } from 'vue'
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
const formSection = ref(null)
const questionsSection = ref(null)
const lastSavedPreguntaId = ref(null)

const allocatedPoints = computed(() => {
  if (!evaluacion.value?.preguntas?.length) return 0
  return evaluacion.value.preguntas.reduce((total, pregunta) => total + Number(pregunta.puntos || 0), 0)
})

const newTotalPoints = computed(() => {
  const current = allocatedPoints.value
  const puntos = Number(form.value.puntos || 0)
  if (isEditing.value && form.value.id) {
    const existing = evaluacion.value?.preguntas?.find((p) => p.id === form.value.id)
    const oldPoints = Number(existing?.puntos || 0)
    return current - oldPoints + puntos
  }
  return current + puntos
})

const canSubmitPregunta = computed(() => newTotalPoints.value <= 100)

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

const scrollToForm = async () => {
  await nextTick()
  formSection.value?.scrollIntoView({ behavior: 'smooth', block: 'start' })
}

const scrollToQuestions = async (preguntaId = null) => {
  await nextTick()
  if (preguntaId) {
    const preguntaElement = document.getElementById(`pregunta-${preguntaId}`)
    if (preguntaElement) {
      preguntaElement.scrollIntoView({ behavior: 'smooth', block: 'start' })
      return
    }
  }
  questionsSection.value?.scrollIntoView({ behavior: 'smooth', block: 'start' })
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
    scrollToForm()
  }
}

const editPregunta = (pregunta) => {
  isEditing.value = true
  form.value = { ...pregunta }
  showModal.value = true
  scrollToForm()
}

const savePregunta = async () => {
  saving.value = true
  try {
    if (!canSubmitPregunta.value) {
      notificationStore.addNotification({
        title: 'Puntos Excedidos',
        message: 'No puedes asignar más de 100 puntos en el examen.',
        type: 'error'
      })
      return
    }
    if (isEditing.value) {
      await api.patch(`/preguntas/${form.value.id}`, form.value)
      lastSavedPreguntaId.value = form.value.id
    } else {
      const res = await api.post('/preguntas', form.value)
      lastSavedPreguntaId.value = res.data.id
    }
    showModal.value = false
    await fetchEvaluacion()
    await scrollToQuestions(lastSavedPreguntaId.value)
    lastSavedPreguntaId.value = null
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
