<template>
  <div class="min-h-screen bg-gray-50 dark:bg-background text-gray-900 dark:text-white font-lexend relative overflow-hidden flex flex-col justify-between transition-colors duration-300">
    <!-- Fondo con orbes neón flotantes -->
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -top-40 -left-40 h-[600px] w-[600px] rounded-full bg-accent-neon/5 blur-[150px] animate-pulse" style="animation-duration: 10s;"></div>
      <div class="absolute -bottom-40 -right-40 h-[600px] w-[600px] rounded-full bg-accent-solar/5 blur-[150px] animate-pulse" style="animation-duration: 7s;"></div>
    </div>

    <!-- Header Sticky Compacto Fix Modo Oscuro -->
    <header class="sticky top-0 z-40 bg-gray-100 dark:bg-[#0f172a] px-4 py-3.5 border-b border-gray-300/40 dark:border-white/10 md:px-8 shrink-0 transition-colors duration-300">
      <div class="mx-auto flex max-w-7xl flex-col gap-3 md:flex-row md:items-center md:justify-between relative z-10">
        <div class="flex min-w-0 items-center gap-3.5">
          <div class="flex h-10 w-10 items-center justify-center rounded-xl bg-accent-neon/10 text-accent-neon border border-accent-neon/20 shrink-0">
            <span class="material-symbols-outlined font-black text-xl">assignment</span>
          </div>
          <div class="min-w-0">
            <h1 class="truncate text-base font-black tracking-tight text-gray-900 dark:text-white md:text-lg">
              {{ evaluacion?.titulo || 'Evaluación' }}
            </h1>
            <div class="flex items-center gap-2">
              <p class="text-[9px] font-black uppercase tracking-[0.25em] text-accent-neon">
                Examen de certificación
              </p>
              <!-- Indicator de sincronización/guardado -->
              <span v-if="!finished && !bloqueado" class="text-[9px] text-emerald-500 font-bold flex items-center gap-1">
                <span class="h-1.5 w-1.5 rounded-full bg-emerald-500 animate-ping"></span>
                Guardado
              </span>
            </div>
          </div>
        </div>

        <div class="flex items-center justify-between gap-3 md:justify-end">
          <!-- Temporizador -->
          <div 
            v-if="!finished && !bloqueado" 
            :class="[
              'flex items-center gap-2.5 rounded-xl bg-gray-200/60 dark:bg-white/10 border border-gray-300/40 dark:border-white/10 px-3.5 py-2 transition-all duration-300',
              timeLeft < 120 ? 'bg-red-500/10 border-red-500/30 shadow-[0_0_15px_rgba(239,68,68,0.2)] animate-pulse' : ''
            ]"
          >
            <span class="material-symbols-outlined animate-pulse text-accent-neon text-lg" :class="{'text-red-500': timeLeft < 120}">timer</span>
            <span :class="['text-sm font-black tabular-nums md:text-base', timeLeft < 120 ? 'text-red-500' : 'text-gray-800 dark:text-white']">
              {{ formatTime(timeLeft) }}
            </span>
          </div>

          <!-- Intentos restantes -->
          <div v-if="!finished && !bloqueado && maxIntentos > 0" class="hidden items-center gap-2 rounded-xl bg-gray-200/60 dark:bg-white/10 border border-gray-300/40 dark:border-white/10 px-3.5 py-2 sm:flex">
            <span class="material-symbols-outlined text-accent-solar text-sm">replay</span>
            <span class="text-xs font-bold text-gray-700 dark:text-white/80">{{ intentosRestantes }} intento(s)</span>
          </div>

          <!-- Botón de Cerrar -->
          <button 
            v-if="!finished && !bloqueado" 
            @click="confirmExit" 
            class="flex h-9 w-9 items-center justify-center rounded-xl bg-gray-200/60 dark:bg-white/10 border border-gray-300/40 dark:border-white/10 text-gray-700 dark:text-white/70 hover:text-gray-900 dark:hover:text-white hover:bg-gray-300/60 dark:hover:bg-white/20 transition-all cursor-pointer"
          >
            <span class="material-symbols-outlined text-lg">close</span>
          </button>
        </div>
      </div>
    </header>

    <!-- Contenido Principal -->
    <main class="mx-auto flex w-full max-w-7xl flex-1 flex-col justify-center px-4 py-6 md:px-8 relative z-10">
      
      <!-- Estado de carga -->
      <div v-if="loading" class="flex flex-col items-center gap-6 py-20">
        <div class="h-14 w-14 animate-spin rounded-full border-2 border-accent-neon/20 border-t-accent-neon shadow-[0_0_20px_var(--accent-neon)]"></div>
        <p class="text-[10px] font-black uppercase tracking-[0.4em] text-accent-neon">Preparando examen...</p>
      </div>

      <!-- Bloqueado: sin intentos disponibles -->
      <div v-else-if="bloqueado" class="mx-auto w-full max-w-2xl animate-in fade-in">
        <div class="glass-card-premium relative overflow-hidden rounded-3xl bg-white dark:bg-surface border border-red-500/20 p-8 text-center shadow-2xl md:p-12">
          <div class="mx-auto mb-6 flex h-20 w-20 items-center justify-center rounded-2xl bg-red-500/10 border border-red-500/20 text-red-500">
            <span class="material-symbols-outlined text-4xl font-black">block</span>
          </div>
          <h2 class="text-3xl font-black tracking-tight text-gray-900 dark:text-white">
            Sin <span class="text-red-500">intentos</span>
          </h2>
          <p class="mb-4 mt-3 text-xs font-bold uppercase tracking-[0.25em] text-gray-500 dark:text-white/50">
            Has agotado tus {{ maxIntentos }} intento(s) para esta evaluación.
          </p>
          <p class="mb-8 text-sm text-gray-600 dark:text-white/60">
            Contacta a tu administrador si necesitas intentos adicionales.
          </p>
          <button @click="exitExam" class="px-6 py-3 rounded-xl bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 text-gray-700 dark:text-white/80 hover:bg-gray-200 dark:hover:bg-white/10 text-xs font-bold flex items-center justify-center gap-2 mx-auto transition-all cursor-pointer">
            <span class="material-symbols-outlined text-base">arrow_back</span>
            Volver al curso
          </button>
        </div>
      </div>

      <!-- Vista del Examen -->
      <transition name="fade-slide" mode="out-in">
        <div v-if="!loading && !finished && !bloqueado" :key="currentQuestionIdx" class="w-full">
          <div class="grid grid-cols-1 lg:grid-cols-12 gap-6 items-start">
            
            <!-- Columna Izquierda: Pregunta + Opciones (8/12) -->
            <div class="lg:col-span-8 flex flex-col gap-4">
              
              <!-- Barra superior con progreso y acciones auxiliares -->
              <div class="flex flex-col gap-2">
                <div class="flex items-center justify-between">
                  <p class="text-[10px] font-black uppercase tracking-[0.2em] text-gray-500 dark:text-white/50">
                    Pregunta {{ currentQuestionIdx + 1 }} de {{ evaluacion?.preguntas?.length }}
                  </p>
                  
                  <div class="flex items-center gap-2">
                    <!-- Botón para Marcar para Revisión -->
                    <button 
                      @click="toggleBookmark(currentQuestion?.id)"
                      :class="[
                        'flex items-center gap-1 px-2.5 py-0.5 rounded-lg text-[10px] font-bold transition-all cursor-pointer border',
                        flaggedQuestions.includes(currentQuestion?.id)
                          ? 'bg-amber-500/20 text-amber-500 border-amber-500/40'
                          : 'bg-gray-100 dark:bg-white/5 text-gray-500 dark:text-white/60 border-gray-200 dark:border-white/10 hover:text-amber-500'
                      ]"
                    >
                      <span class="material-symbols-outlined text-xs">
                        {{ flaggedQuestions.includes(currentQuestion?.id) ? 'bookmark' : 'bookmark_border' }}
                      </span>
                      {{ flaggedQuestions.includes(currentQuestion?.id) ? 'Marcada' : 'Revisar después' }}
                    </button>

                    <span class="rounded-lg bg-accent-neon/10 border border-accent-neon/20 px-2.5 py-0.5 text-[10px] font-black uppercase tracking-widest text-accent-neon">
                      {{ currentQuestion?.puntos }} puntos
                    </span>
                  </div>
                </div>
                <div class="h-1.5 w-full bg-gray-200 dark:bg-white/5 rounded-full overflow-hidden border border-gray-200/50 dark:border-white/5">
                  <div class="h-full bg-accent-neon transition-all duration-500" :style="{ width: ((currentQuestionIdx + 1) / evaluacion?.preguntas?.length) * 100 + '%' }"></div>
                </div>
              </div>

              <!-- Tarjeta de la Pregunta (Con select-none para prevención de copia) -->
              <div class="glass-card-premium relative overflow-hidden rounded-2xl sm:rounded-3xl bg-white dark:bg-surface border border-gray-200 dark:border-white/10 p-6 md:p-8 shadow-2xl flex flex-col justify-between gap-6 transition-all select-none">
                
                <div>
                  <h2 class="mb-6 text-lg font-black leading-snug text-gray-900 dark:text-white md:text-xl">
                    {{ currentQuestion?.pregunta }}
                  </h2>

                  <!-- Opciones de Respuesta -->
                  <div class="grid grid-cols-1 gap-3">
                    <button
                      v-for="(resp, respIdx) in currentQuestion?.respuestas"
                      :key="resp.id"
                      @click="selectAnswer(resp.id)"
                      :class="[
                        'flex w-full items-center gap-3.5 rounded-xl p-3.5 text-left border transition-all duration-200 cursor-pointer',
                        answers[currentQuestion.id] === resp.id 
                          ? 'bg-accent-neon/10 border-accent-neon text-gray-900 dark:text-white shadow-lg shadow-accent-neon/5' 
                          : 'bg-gray-100 dark:bg-white/5 border-gray-200 dark:border-white/10 hover:border-gray-300 dark:hover:border-white/20 text-gray-700 dark:text-white/80'
                      ]"
                    >
                      <!-- Indicador A, B, C... -->
                      <div
                        :class="[
                          'flex h-8 w-8 shrink-0 items-center justify-center rounded-lg text-xs font-black transition-all duration-200',
                          answers[currentQuestion.id] === resp.id 
                            ? 'bg-accent-neon text-gray-950 shadow-md shadow-accent-neon/20' 
                            : 'bg-gray-200 dark:bg-white/10 text-gray-600 dark:text-white/60 border border-gray-300/50 dark:border-white/5'
                        ]"
                      >
                        {{ ['A', 'B', 'C', 'D', 'E', 'F'][respIdx] || '•' }}
                      </div>

                      <span class="text-xs font-bold leading-relaxed md:text-sm flex-1">
                        {{ resp.respuesta }}
                      </span>
                      
                      <!-- Icono Check -->
                      <div 
                        v-if="answers[currentQuestion.id] === resp.id"
                        class="flex h-5 w-5 items-center justify-center rounded-full bg-accent-neon/20 border border-accent-neon/40 text-accent-neon shrink-0 animate-in zoom-in duration-200"
                      >
                        <span class="material-symbols-outlined text-[12px] font-black">check</span>
                      </div>
                    </button>
                  </div>
                </div>

                <!-- Pie del Card (Navegación Inline + Desmarcar opción) -->
                <div class="flex items-center justify-between pt-4 border-t border-gray-200 dark:border-white/10 mt-2">
                  <button 
                    @click="prevQuestion" 
                    :disabled="currentQuestionIdx === 0" 
                    class="px-4 py-2.5 rounded-xl bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 text-gray-700 dark:text-white/80 hover:bg-gray-200 dark:hover:bg-white/10 text-xs font-bold flex items-center justify-center gap-2 transition-all disabled:opacity-20 cursor-pointer"
                  >
                    <span class="material-symbols-outlined text-base">arrow_back</span>
                    Anterior
                  </button>
                  <button
                    v-if="currentQuestionIdx < (evaluacion?.preguntas?.length - 1)"
                    @click="nextQuestion"
                    class="px-6 py-2.5 rounded-xl bg-accent-neon text-gray-950 font-black text-xs uppercase tracking-widest shadow-lg hover:shadow-accent-neon/30 hover:-translate-y-0.5 active:scale-95 transition-all flex items-center justify-center gap-2 cursor-pointer"
                  >
                    Siguiente
                    <span class="material-symbols-outlined text-base font-bold">arrow_forward</span>
                  </button>

                  <button
                    v-else
                    @click="confirmFinish"
                    :disabled="submitting"
                    class="px-6 py-2.5 rounded-xl bg-accent-neon text-gray-950 font-black text-xs uppercase tracking-widest shadow-lg hover:shadow-accent-neon/30 hover:-translate-y-0.5 active:scale-95 transition-all flex items-center justify-center gap-2 cursor-pointer disabled:opacity-30 disabled:hover:translate-y-0"
                  >
                    {{ submitting ? 'Enviando...' : 'Finalizar Examen' }}
                    <span class="material-symbols-outlined text-base font-bold">send</span>
                  </button>
                </div>

              </div>
            </div>

            <!-- Columna Derecha: Panel Lateral (4/12) -->
            <div class="lg:col-span-4 space-y-4">
              <div class="glass-card-premium p-5 rounded-2xl sm:rounded-3xl bg-white dark:bg-surface border border-gray-200 dark:border-white/10 transition-all">
                <div class="flex items-center justify-between mb-4 pb-3 border-b border-gray-200 dark:border-white/10">
                  <h3 class="text-xs font-black uppercase tracking-wider text-gray-400 dark:text-white/50">Navegación</h3>
                  <span class="text-[10px] font-black uppercase tracking-wider text-accent-neon">
                    {{ Object.keys(answers).length }}/{{ evaluacion?.preguntas?.length }} Resueltas
                  </span>
                </div>
                
                <!-- Cuadrícula de números -->
                <div class="grid grid-cols-5 gap-2">
                  <button 
                    v-for="(q, idx) in evaluacion?.preguntas" 
                    :key="q.id"
                    @click="currentQuestionIdx = idx"
                    :class="[
                      'h-9 w-9 rounded-xl flex items-center justify-center text-xs font-black transition-all relative border cursor-pointer',
                      currentQuestionIdx === idx 
                        ? 'bg-accent-neon/20 border-accent-neon text-accent-neon shadow-md shadow-accent-neon/10' 
                        : (answers[q.id] !== undefined 
                            ? 'bg-emerald-500/10 border-emerald-500/40 text-emerald-600 dark:text-emerald-400 font-bold' 
                            : 'bg-gray-100 dark:bg-white/5 border-gray-200 dark:border-white/10 text-gray-400 dark:text-white/40 hover:bg-gray-200 dark:hover:bg-white/10 hover:text-gray-700 dark:hover:text-white')
                    ]"
                  >
                    {{ idx + 1 }}

                    <!-- Indicador visual de Marcada para Revisar -->
                    <span 
                      v-if="flaggedQuestions.includes(q.id)" 
                      class="absolute -top-1 -right-1 h-3.5 w-3.5 rounded-full bg-amber-500 flex items-center justify-center text-[8px] text-black font-bold shadow"
                    >
                      ★
                    </span>
                  </button>
                </div>

                <!-- Leyenda del panel -->
                <div class="mt-5 pt-4 border-t border-gray-200 dark:border-white/10 flex items-center justify-between text-[10px] font-bold uppercase tracking-wider text-gray-400 dark:text-white/40">
                  <div class="flex items-center gap-1.5">
                    <span class="h-2 w-2 rounded-full bg-emerald-500"></span>
                    <span>Resuelta</span>
                  </div>
                  <div class="flex items-center gap-1.5">
                    <span class="h-2 w-2 rounded-full bg-amber-500"></span>
                    <span>Revisar</span>
                  </div>
                  <div class="flex items-center gap-1.5">
                    <span class="h-2 w-2 rounded-full bg-gray-200 dark:bg-white/10 border border-gray-300 dark:border-white/20"></span>
                    <span>Pendiente</span>
                  </div>
                </div>
              </div>
            </div>

          </div>
        </div>

        <!-- Pantalla de Resultados -->
        <div v-else-if="finished" class="mx-auto w-full max-w-md animate-in fade-in px-2">
          <div class="glass-card-premium relative overflow-hidden rounded-2xl sm:rounded-3xl bg-white dark:bg-surface border border-gray-200 dark:border-white/10 p-6 text-center shadow-2xl transition-all">
            <!-- Glow posterior -->
            <div :class="['pointer-events-none absolute -top-20 left-1/2 -translate-x-1/2 h-44 w-44 rounded-full blur-[70px] opacity-20', passed ? 'bg-accent-neon' : 'bg-red-500']"></div>

            <!-- Ring indicador del puntaje -->
            <div class="relative z-10 mx-auto mb-4 h-24 w-24">
              <svg viewBox="0 0 120 120" class="h-full w-full -rotate-90">
                <circle cx="60" cy="60" r="52" fill="none" stroke="currentColor" stroke-width="8" class="text-gray-100 dark:text-white/5" />
                <circle cx="60" cy="60" r="52" fill="none" stroke-width="8" stroke-linecap="round"
                  :stroke="passed ? 'var(--accent-neon, #10b981)' : '#ef4444'"
                  :stroke-dasharray="2 * Math.PI * 52"
                  :stroke-dashoffset="2 * Math.PI * 52 * (1 - Math.round(score) / 100)"
                  style="transition: stroke-dashoffset 1.2s cubic-bezier(0.4, 0, 0.2, 1);"
                  :filter="passed ? 'drop-shadow(0 0 6px rgba(16,185,129,0.4))' : 'drop-shadow(0 0 6px rgba(239,68,68,0.4))'"
                />
              </svg>
              <div class="absolute inset-0 flex flex-col items-center justify-center">
                <span :class="['text-2xl font-black tabular-nums', passed ? 'text-accent-neon' : 'text-red-500']">
                  {{ Math.round(score) }}%
                </span>
              </div>
            </div>

            <h2 class="text-xl font-black tracking-tight text-gray-900 dark:text-white md:text-2xl">
              {{ passed ? '¡Examen' : 'Intento' }} <span :class="passed ? 'text-accent-neon' : 'text-red-500'">{{ passed ? 'Aprobado!' : 'No Aprobado' }}</span>
            </h2>
            <p class="mt-1.5 mb-5 text-xs font-medium text-gray-500 dark:text-white/60">
              {{ passed ? 'Has demostrado los conocimientos requeridos' : 'No alcanzaste la nota mínima necesaria' }}
            </p>

            <div class="mb-5 flex items-center justify-center gap-3 flex-wrap">
              <div class="flex items-center gap-2 rounded-xl bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 px-3 py-1.5">
                <span class="material-symbols-outlined text-sm text-accent-solar">verified</span>
                <span class="text-xs font-bold text-gray-600 dark:text-white/70">Mínimo: {{ Math.round(evaluacion.nota_aprobacion) }}%</span>
              </div>
              <div class="flex items-center gap-2 rounded-xl bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 px-3 py-1.5">
                <span class="material-symbols-outlined text-sm text-accent-neon">replay</span>
                <span class="text-xs font-bold text-gray-600 dark:text-white/70">{{ intentosUsados }}/{{ maxIntentos }} intentos</span>
              </div>
            </div>

            <div class="relative z-10 flex flex-col gap-2.5">
              <button 
                v-if="passed" 
                @click="viewCertificate" 
                :disabled="loadingCert" 
                class="w-full py-2.5 rounded-xl bg-accent-neon text-gray-950 text-xs font-black uppercase tracking-widest shadow-lg hover:shadow-accent-neon/20 hover:-translate-y-0.5 active:scale-95 transition-all flex items-center justify-center gap-2 cursor-pointer"
              >
                <span class="material-symbols-outlined text-base">{{ loadingCert ? 'hourglass_empty' : 'workspace_premium' }}</span>
                {{ loadingCert ? 'Generando...' : 'Ver Certificado' }}
              </button>

              <button 
                v-if="!passed && intentosRestantes > 0" 
                @click="retryExam" 
                class="w-full py-2.5 rounded-xl bg-accent-neon text-gray-950 text-xs font-black uppercase tracking-widest shadow-lg hover:shadow-accent-neon/20 hover:-translate-y-0.5 active:scale-95 transition-all flex items-center justify-center gap-2 cursor-pointer"
              >
                <span class="material-symbols-outlined text-base">refresh</span>
                Reintentar Examen ({{ intentosRestantes }})
              </button>

              <button 
                @click="exitExam" 
                class="w-full py-2.5 rounded-xl bg-gray-100 dark:bg-white/5 border border-gray-200 dark:border-white/10 text-gray-700 dark:text-white/80 hover:bg-gray-200 dark:hover:bg-white/10 text-xs font-bold flex items-center justify-center gap-2 transition-all cursor-pointer"
              >
                <span class="material-symbols-outlined text-base">arrow_back</span>
                Volver al curso
              </button>
            </div>

          </div>
        </div>
      </transition>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted, computed, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '@/services/api'
import { useAuthStore } from '@/stores/auth'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'
import confetti from 'canvas-confetti'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()
const notificationStore = useNotificationStore()
const modalStore = useModalStore()

const loading = ref(true)
const submitting = ref(false)
const loadingCert = ref(false)
const finished = ref(false)
const bloqueado = ref(false)
const evaluacion = ref(null)
const currentQuestionIdx = ref(0)
const answers = ref({})
const flaggedQuestions = ref([])
const score = ref(0)
const timeLeft = ref(0)
const timer = ref(null)
const startTime = ref(null)
const certificateId = ref(null)
const maxIntentos = ref(1)
const intentosUsados = ref(0)

const intentosRestantes = computed(() => Math.max(0, maxIntentos.value - intentosUsados.value))

const fetchExam = async () => {
  loading.value = true
  try {
    const res = await api.get(`/evaluaciones/${route.params.id}`)
    evaluacion.value = res.data
    maxIntentos.value = evaluacion.value.intentos_permitidos || 1

    try {
      const intentosRes = await api.get('/intentos-evaluacion')
      const misIntentos = intentosRes.data.filter(
        (i) => Number(i.evaluacion_id) === Number(evaluacion.value.id) && Number(i.usuario_id) === Number(authStore.user?.id)
      )
      intentosUsados.value = misIntentos.length

      const yaAprobo = misIntentos.some((i) => i.aprobado === true)
      if (yaAprobo) {
        bloqueado.value = true
        return
      }

      if (intentosUsados.value >= maxIntentos.value) {
        bloqueado.value = true
        return
      }
    } catch (e) {
      console.warn('No se pudieron verificar intentos previos:', e)
    }

    timeLeft.value = (evaluacion.value.tiempo_limite || 30) * 60
    startTime.value = new Date()
    startTimer()
  } catch (error) {
    if (error?.response?.status === 403) {
      notificationStore.addNotification({
        title: 'Acceso denegado',
        message: 'No tienes una inscripción activa para esta evaluación.',
        type: 'error'
      })
      router.replace('/student/my-courses')
      return
    }
    notificationStore.addNotification({
      title: 'Error de Acceso',
      message: 'No pudimos cargar la evaluación en este momento.',
      type: 'error'
    })
    router.back()
  } finally {
    loading.value = false
  }
}

const currentQuestion = computed(() => evaluacion.value?.preguntas[currentQuestionIdx.value])

const selectAnswer = (respId) => {
  answers.value[currentQuestion.value.id] = respId
}

const clearAnswer = (questionId) => {
  if (questionId && answers.value[questionId] !== undefined) {
    delete answers.value[questionId]
  }
}

const toggleBookmark = (questionId) => {
  if (!questionId) return
  const index = flaggedQuestions.value.indexOf(questionId)
  if (index > -1) {
    flaggedQuestions.value.splice(index, 1)
  } else {
    flaggedQuestions.value.push(questionId)
  }
}

const nextQuestion = () => {
  if (currentQuestionIdx.value < evaluacion.value.preguntas.length - 1) {
    currentQuestionIdx.value++
  }
}

const prevQuestion = () => {
  if (currentQuestionIdx.value > 0) {
    currentQuestionIdx.value--
  }
}

const viewCertificate = async () => {
  if (!certificateId.value) {
    router.push({ name: 'student-certificates' })
    return
  }

  loadingCert.value = true
  try {
    const response = await api.get(`/certificados/${certificateId.value}/download`, {
      responseType: 'blob',
    })

    const blob = new Blob([response.data], { type: 'application/pdf' })
    const url = window.URL.createObjectURL(blob)
    window.open(url, '_blank')
    setTimeout(() => window.URL.revokeObjectURL(url), 5000)
  } catch (error) {
    console.error('Error al abrir certificado:', error)
    notificationStore.addNotification({
      title: 'Certificado Pendiente',
      message: 'No se pudo generar el documento. Verifica la configuración del curso.',
      type: 'error'
    })
    router.push({ name: 'student-certificates' })
  } finally {
    loadingCert.value = false
  }
}

const passed = computed(() => score.value >= parseFloat(evaluacion.value?.nota_aprobacion))

const finishExam = async () => {
  if (submitting.value) return
  submitting.value = true
  stopTimer()

  let totalPoints = 0
  let earnedPoints = 0

  evaluacion.value.preguntas.forEach((p) => {
    totalPoints += p.puntos
    const selectedResp = p.respuestas.find((r) => r.id === answers.value[p.id])
    if (selectedResp?.es_correcta) {
      earnedPoints += p.puntos
    }
  })

  score.value = totalPoints > 0 ? (earnedPoints / totalPoints) * 100 : 0
  finished.value = true

  if (passed.value) {
    confetti({
      particleCount: 150,
      spread: 70,
      origin: { y: 0.6 },
      colors: ['#10b981', '#059669', '#34d399'],
    })
  }

  try {
    const res = await api.post('/intentos-evaluacion', {
      evaluacion_id: evaluacion.value.id,
      usuario_id: authStore.user?.id,
      nota: score.value,
      fecha_inicio: startTime.value ? startTime.value.toISOString() : new Date().toISOString(),
      fecha_fin: new Date().toISOString(),
      aprobado: passed.value,
      respuestas_seleccionadas: answers.value,
    })

    if (res.data?.intentos_usados) {
      intentosUsados.value = res.data.intentos_usados
    } else {
      intentosUsados.value++
    }
    if (res.data?.intentos_permitidos) {
      maxIntentos.value = res.data.intentos_permitidos
    }

    if (res.data?.certificado?.id) {
      certificateId.value = res.data.certificado.id
    } else if (passed.value) {
      try {
        const certsRes = await api.get('/certificados/me')
        const latestCert = certsRes.data.find((c) => Number(c.curso_id) === Number(evaluacion.value.curso_id))
        if (latestCert) {
          certificateId.value = latestCert.id
        }
      } catch (e) {
        console.error('Error recuperando certificados:', e)
      }
    }
  } catch (error) {
    console.error('Error saving attempt:', error)
    const msg = error.response?.data?.message
    if (msg) {
      notificationStore.addNotification({
        title: 'Error de Envío',
        message: msg,
        type: 'error'
      })
    }
  } finally {
    submitting.value = false
  }
}

const startTimer = () => {
  timer.value = setInterval(() => {
    if (timeLeft.value > 0) {
      timeLeft.value--
    } else {
      finishExam()
    }
  }, 1000)
}

const stopTimer = () => {
  if (timer.value) clearInterval(timer.value)
}

const formatTime = (seconds) => {
  const m = Math.floor(seconds / 60)
  const s = seconds % 60
  return `${m}:${s.toString().padStart(2, '0')}`
}

const confirmExit = () => {
  modalStore.openModal({
    title: '¿Abandonar Examen?',
    message: 'Si sales ahora, perderás tu progreso en este intento.',
    confirmText: 'Sí, Salir',
    type: 'warning',
    onConfirm: () => {
      router.back()
    }
  })
}

const confirmFinish = () => {
  const totalPreguntas = evaluacion.value?.preguntas?.length || 0
  const respondidas = Object.keys(answers.value).length
  const sinResponder = totalPreguntas - respondidas
  const mensaje = sinResponder > 0
    ? `Tienes ${sinResponder} pregunta(s) sin responder. ¿Estás seguro de finalizar?`
    : '¿Estás seguro de que deseas finalizar y enviar tu examen?'

  modalStore.openModal({
    title: '¿Finalizar Examen?',
    message: mensaje,
    confirmText: 'Sí, Finalizar',
    cancelText: 'Seguir revisando',
    type: 'warning',
    onConfirm: () => {
      finishExam()
    }
  })
}

const exitExam = () => {
  router.push('/student/my-courses')
}

const retryExam = () => {
  finished.value = false
  currentQuestionIdx.value = 0
  answers.value = {}
  flaggedQuestions.value = []
  timeLeft.value = (evaluacion.value.tiempo_limite || 30) * 60
  startTime.value = new Date()
  startTimer()
}

/* Eventos de Protección Anti-copia y Salida Accidental */
const handleBeforeUnload = (e) => {
  if (!finished.value && !bloqueado.value) {
    e.preventDefault()
    e.returnValue = ''
  }
}

const handleVisibilityChange = () => {
  if (document.hidden && !finished.value && !bloqueado.value) {
    notificationStore.addNotification({
      title: 'Atención',
      message: 'Has cambiado de pestaña. Mantén la pantalla activa durante el examen.',
      type: 'warning'
    })
  }
}

const handleSecurityEvents = (e) => {
  if (finished.value || bloqueado.value) return
  
  // Bloquear menú contextual (clic derecho)
  if (e.type === 'contextmenu') {
    e.preventDefault()
  }
  
  // Bloquear accesos directos (Ctrl+C, Ctrl+U, F12, Ctrl+Shift+I)
  if (e.type === 'keydown') {
    if (
      (e.ctrlKey && (e.key === 'c' || e.key === 'u' || e.key === 'C' || e.key === 'U')) ||
      e.key === 'F12' ||
      (e.ctrlKey && e.shiftKey && (e.key === 'I' || e.key === 'i'))
    ) {
      e.preventDefault()
    }
  }
}

onMounted(() => {
  fetchExam()
  window.addEventListener('beforeunload', handleBeforeUnload)
  document.addEventListener('visibilitychange', handleVisibilityChange)
  document.addEventListener('contextmenu', handleSecurityEvents)
  document.addEventListener('keydown', handleSecurityEvents)
})

onUnmounted(() => {
  stopTimer()
  window.removeEventListener('beforeunload', handleBeforeUnload)
  document.removeEventListener('visibilitychange', handleVisibilityChange)
  document.removeEventListener('contextmenu', handleSecurityEvents)
  document.removeEventListener('keydown', handleSecurityEvents)
})
</script>

<style scoped>
.fade-slide-enter-active, .fade-slide-leave-active { transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1); }
.fade-slide-enter-from { transform: translateX(20px); opacity: 0; }
.fade-slide-leave-to { transform: translateX(-20px); opacity: 0; }
</style>