<template>
  <div class="min-h-screen bg-background text-on-surface font-lexend relative overflow-hidden">
    <!-- Fondo con orbes de luz neón flotantes -->
    <div class="pointer-events-none fixed inset-0 -z-10 overflow-hidden">
      <div class="absolute -top-40 -left-40 h-[600px] w-[600px] rounded-full bg-accent-neon/5 blur-[150px] animate-pulse" style="animation-duration: 10s;"></div>
      <div class="absolute -bottom-40 -right-40 h-[600px] w-[600px] rounded-full bg-accent-solar/5 blur-[150px] animate-pulse" style="animation-duration: 7s;"></div>
    </div>

    <header class="sticky top-0 z-40 bg-background/85 px-4 py-4 backdrop-blur-xl md:px-8">
      <div class="absolute bottom-0 left-0 right-0 h-px bg-on-surface/5"></div>
      <div class="mx-auto flex max-w-6xl flex-col gap-4 md:flex-row md:items-center md:justify-between relative z-10">
        <div class="flex min-w-0 items-center gap-4">
          <div class="flex h-12 w-12 items-center justify-center rounded-[18px] bg-accent-neon shadow-lg shadow-accent-neon/20">
            <span class="material-symbols-outlined font-black text-primary">assignment</span>
          </div>
          <div class="min-w-0">
            <h1 class="truncate text-lg font-black tracking-tight md:text-xl">{{ evaluacion?.titulo || 'Evaluacion' }}</h1>
            <p class="mt-1 text-[10px] font-black uppercase tracking-[0.28em] text-accent-neon">Examen de certificacion</p>
          </div>
        </div>

        <div class="flex items-center justify-between gap-3 md:justify-end">
          <div v-if="!finished && !bloqueado" :class="['flex items-center gap-3 rounded-2xl bg-on-surface/5 px-4 py-3 border transition-all duration-300', timeLeft < 120 ? 'border-red-500/50 bg-red-500/10 shadow-[0_0_15px_rgba(239,68,68,0.2)] animate-pulse' : 'border-transparent']">
            <span class="material-symbols-outlined animate-pulse text-accent-neon" :class="{'text-red-500': timeLeft < 120}">timer</span>
            <span :class="['text-lg font-black tabular-nums md:text-xl', timeLeft < 120 ? 'text-red-500' : 'text-on-surface']">
              {{ formatTime(timeLeft) }}
            </span>
          </div>

          <!-- Intentos restantes -->
          <div v-if="!finished && !bloqueado && maxIntentos > 0" class="hidden items-center gap-2 rounded-2xl !border-none bg-on-surface/5 px-4 py-3 sm:flex">
            <span class="material-symbols-outlined text-accent-solar text-sm">replay</span>
            <span class="text-xs font-black text-on-surface/60">{{ intentosRestantes }} intento(s)</span>
          </div>

          <button v-if="!finished && !bloqueado" @click="confirmExit" class="flex h-11 w-11 items-center justify-center rounded-2xl bg-on-surface/5 text-on-surface/40 transition-all hover:bg-red-500/10 hover:text-red-500">
            <span class="material-symbols-outlined">close</span>
          </button>
        </div>
      </div>
    </header>

    <main class="mx-auto flex min-h-[calc(100vh-88px)] w-full max-w-6xl flex-col justify-center p-4 md:p-8 relative z-10">
      <div v-if="loading" class="flex flex-col items-center gap-6 py-20">
        <div class="h-16 w-16 animate-spin rounded-full border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)]"></div>
        <p class="text-[10px] font-black uppercase tracking-[0.4em] text-accent-neon">Preparando examen...</p>
      </div>

      <!-- Bloqueado: sin intentos disponibles -->
      <div v-else-if="bloqueado" class="mx-auto w-full max-w-3xl animate-in fade-in">
        <div class="glass-card-premium relative overflow-hidden rounded-[32px] !border-none bg-red-500/5 p-8 text-center shadow-2xl shadow-red-500/10 md:rounded-[48px] md:p-12">
          <div class="mx-auto mb-8 flex h-24 w-24 items-center justify-center rounded-[32px] !border-none bg-red-500/10 text-red-500">
            <span class="material-symbols-outlined text-5xl font-black">block</span>
          </div>
          <h2 class="text-4xl font-black tracking-tight md:text-5xl">Sin intentos</h2>
          <p class="mb-6 mt-4 text-sm font-medium uppercase tracking-[0.28em] text-on-surface-variant opacity-70">
            Has agotado tus {{ maxIntentos }} intento(s) para esta evaluación.
          </p>
          <p class="mb-10 text-sm leading-7 text-on-surface/50">
            Contacta a tu administrador si necesitas intentos adicionales.
          </p>
          <button @click="exitExam" class="btn-premium btn-secondary-glass !px-8 !py-4 gap-3">
            <span class="material-symbols-outlined text-lg">arrow_back</span>
            Volver al curso
          </button>
        </div>
      </div>

      <transition name="fade-slide" mode="out-in">
        <div v-if="!loading && !finished && !bloqueado" :key="currentQuestionIdx" class="w-full">
          <!-- LMS Grid layout: Izquierda área de preguntas, Derecha panel lateral -->
          <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 items-start">
            
            <!-- Columna Izquierda: Preguntas y respuestas -->
            <div class="lg:col-span-2 space-y-6">
              
              <!-- Encabezado de Pregunta con progreso horizontal -->
              <div class="flex flex-col gap-3">
                <div class="flex items-center justify-between">
                  <p class="text-[10px] font-black uppercase tracking-[0.2em] text-on-surface/40">Pregunta {{ currentQuestionIdx + 1 }} de {{ evaluacion?.preguntas?.length }}</p>
                  <span class="rounded-full bg-accent-neon/10 px-3 py-1 text-[10px] font-black uppercase tracking-widest text-accent-neon">
                    {{ currentQuestion?.puntos }} puntos
                  </span>
                </div>
                <div class="h-1.5 w-full bg-on-surface/10 rounded-full overflow-hidden">
                  <div class="h-full bg-accent-neon transition-all duration-500" :style="{ width: ((currentQuestionIdx + 1) / evaluacion?.preguntas?.length) * 100 + '%' }"></div>
                </div>
              </div>

              <!-- Carta de la Pregunta Principal -->
              <div class="glass-card-premium relative overflow-hidden rounded-[32px] p-6 shadow-2xl md:rounded-[40px] md:p-10 border border-on-surface/5">
                <div class="absolute left-0 top-0 h-full w-1.5 bg-accent-neon opacity-40"></div>

                <h2 class="mb-8 pr-4 text-xl font-black leading-tight md:text-2xl text-on-surface">{{ currentQuestion?.pregunta }}</h2>

                <!-- Respuestas -->
                <div class="grid grid-cols-1 gap-4">
                  <button
                    v-for="(resp, respIdx) in currentQuestion?.respuestas"
                    :key="resp.id"
                    @click="selectAnswer(resp.id)"
                    :class="[
                      'flex w-full items-center gap-4 rounded-[24px] p-4 text-left transition-all duration-300 border-2',
                      answers[currentQuestion.id] === resp.id 
                        ? 'border-accent-neon bg-accent-neon/10 shadow-lg shadow-accent-neon/5' 
                        : 'border-on-surface/5 bg-on-surface/5 hover:bg-on-surface/10 hover:border-on-surface/10'
                    ]"
                  >
                    <!-- Círculo de Opción A, B, C, D -->
                    <div
                      :class="[
                        'flex h-10 w-10 shrink-0 items-center justify-center rounded-xl text-sm font-black transition-all duration-300',
                        answers[currentQuestion.id] === resp.id 
                          ? 'bg-accent-neon text-primary shadow-[0_0_15px_rgba(16,185,129,0.4)]' 
                          : 'bg-on-surface/10 text-on-surface/60'
                      ]"
                    >
                      {{ ['A', 'B', 'C', 'D', 'E', 'F'][respIdx] || '•' }}
                    </div>
                    <span :class="['text-sm font-bold leading-6 md:text-base flex-1', answers[currentQuestion.id] === resp.id ? 'text-on-surface' : 'text-on-surface/80']">
                      {{ resp.respuesta }}
                    </span>
                    
                    <!-- Check dinámico al final -->
                    <div 
                      v-if="answers[currentQuestion.id] === resp.id"
                      class="flex h-6 w-6 items-center justify-center rounded-full bg-accent-neon/20 text-accent-neon animate-in zoom-in duration-200"
                    >
                      <span class="material-symbols-outlined text-[14px] font-black">check</span>
                    </div>
                  </button>
                </div>
              </div>

              <!-- Botones de Navegación de Pie -->
              <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between pt-2">
                <button @click="prevQuestion" :disabled="currentQuestionIdx === 0" class="btn-premium btn-secondary-glass !w-full sm:!w-auto !justify-center !px-8 !py-4 gap-3 disabled:opacity-20">
                  <span class="material-symbols-outlined text-sm">arrow_back</span>
                  Anterior
                </button>

                <button
                  v-if="currentQuestionIdx < (evaluacion?.preguntas?.length - 1)"
                  @click="nextQuestion"
                  :disabled="answers[currentQuestion?.id] === undefined"
                  class="btn-premium btn-primary-neon !w-full sm:!w-auto !justify-center !px-8 !py-4 gap-3"
                >
                  Siguiente
                  <span class="material-symbols-outlined text-sm">arrow_forward</span>
                </button>

                <button
                  v-else
                  @click="confirmFinish"
                  :disabled="answers[currentQuestion?.id] === undefined || submitting"
                  class="btn-premium btn-primary-neon !w-full sm:!w-auto !justify-center !px-8 !py-4 gap-3 shadow-accent-neon/40"
                >
                  {{ submitting ? 'Enviando...' : 'Finalizar examen' }}
                  <span class="material-symbols-outlined text-sm">send</span>
                </button>
              </div>
            </div>

            <!-- Columna Derecha: Panel de Navegación de preguntas de la Evaluación -->
            <div class="space-y-6 lg:sticky lg:top-28">
              
              <!-- Cuadrícula de Preguntas (Navegación tipo LMS) -->
              <div class="glass-card-premium p-6 rounded-[28px] border border-on-surface/5">
                <div class="flex items-center justify-between mb-4">
                  <h3 class="text-xs font-black uppercase tracking-wider text-on-surface/40">Panel del Examen</h3>
                  <span class="text-[10px] font-black uppercase tracking-wider text-accent-neon">
                    {{ Object.keys(answers).length }}/{{ evaluacion?.preguntas?.length }} Respondidas
                  </span>
                </div>
                
                <div class="grid grid-cols-5 gap-2.5">
                  <button 
                    v-for="(q, idx) in evaluacion?.preguntas" 
                    :key="q.id"
                    @click="currentQuestionIdx = idx"
                    :class="[
                      'h-10 w-10 rounded-xl flex items-center justify-center text-xs font-black transition-all border-2 relative',
                      currentQuestionIdx === idx 
                        ? 'border-accent-neon bg-accent-neon/10 text-accent-neon shadow-[0_0_12px_rgba(16,185,129,0.3)]' 
                        : (answers[q.id] !== undefined 
                            ? 'border-emerald-500/20 bg-emerald-500/5 text-emerald-400' 
                            : 'border-on-surface/5 bg-on-surface/5 text-on-surface/55 hover:bg-on-surface/10 hover:border-on-surface/10')
                    ]"
                  >
                    {{ idx + 1 }}
                    <!-- Mini punto verde si está contestada -->
                    <div 
                      v-if="answers[q.id] !== undefined" 
                      class="absolute -top-1 -right-1 h-2 w-2 rounded-full bg-accent-neon"
                    ></div>
                  </button>
                </div>

                <!-- Info explicativa -->
                <div class="mt-5 pt-4 border-t border-on-surface/5 flex flex-wrap gap-4 text-[10px] font-black uppercase tracking-wider text-on-surface/40">
                  <div class="flex items-center gap-1.5">
                    <span class="h-2 w-2 rounded-full bg-accent-neon"></span>
                    <span>Respondido</span>
                  </div>
                  <div class="flex items-center gap-1.5">
                    <span class="h-2 w-2 rounded-full bg-on-surface/10"></span>
                    <span>Pendiente</span>
                  </div>
                </div>
              </div>
              
            </div>

          </div>
        </div>

        <!-- RESULTADOS -->
        <div v-else-if="finished" class="mx-auto w-full max-w-lg animate-in fade-in px-2">
          <div class="relative overflow-hidden rounded-[28px] p-6 md:p-8 text-center" style="background: linear-gradient(145deg, rgba(var(--surface-card-rgb, 30,41,59), 0.95), rgba(var(--surface-card-rgb, 30,41,59), 0.7)); backdrop-filter: blur(40px); border: 1px solid rgba(255,255,255,0.06);">
            <!-- Glow decorativo -->
            <div :class="['pointer-events-none absolute -top-24 left-1/2 -translate-x-1/2 h-48 w-48 rounded-full blur-[80px] opacity-30', passed ? 'bg-accent-neon' : 'bg-red-500']"></div>

            <!-- Anillo de puntaje circular -->
            <div class="relative z-10 mx-auto mb-5 h-28 w-28">
              <svg viewBox="0 0 120 120" class="h-full w-full -rotate-90">
                <circle cx="60" cy="60" r="52" fill="none" stroke="currentColor" stroke-width="8" class="text-on-surface/10" />
                <circle cx="60" cy="60" r="52" fill="none" stroke-width="8" stroke-linecap="round"
                  :stroke="passed ? 'var(--accent-neon, #10b981)' : '#ef4444'"
                  :stroke-dasharray="2 * Math.PI * 52"
                  :stroke-dashoffset="2 * Math.PI * 52 * (1 - Math.round(score) / 100)"
                  style="transition: stroke-dashoffset 1.2s cubic-bezier(0.4, 0, 0.2, 1);"
                  :filter="passed ? 'drop-shadow(0 0 6px rgba(16,185,129,0.5))' : 'drop-shadow(0 0 6px rgba(239,68,68,0.4))'"
                />
              </svg>
              <div class="absolute inset-0 flex flex-col items-center justify-center">
                <span :class="['text-3xl font-black tabular-nums', passed ? 'text-accent-neon' : 'text-red-500']">{{ Math.round(score) }}%</span>
              </div>
            </div>

            <!-- Título y subtítulo -->
            <h2 class="text-2xl font-black tracking-tight md:text-3xl">
              {{ passed ? '¡Aprobaste!' : 'Sigue intentando' }}
            </h2>
            <p class="mt-2 mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-on-surface-variant/60">
              {{ passed ? 'Evaluación completada con éxito' : 'No alcanzaste la nota mínima' }}
            </p>

            <!-- Stats en línea horizontal -->
            <div class="mb-6 flex items-center justify-center gap-3 flex-wrap">
              <div class="flex items-center gap-2 rounded-full bg-on-surface/5 px-4 py-2">
                <span class="material-symbols-outlined text-sm text-accent-solar">verified</span>
                <span class="text-xs font-bold text-on-surface/60">Mín. {{ Math.round(evaluacion.nota_aprobacion) }}%</span>
              </div>
              <div class="flex items-center gap-2 rounded-full bg-on-surface/5 px-4 py-2">
                <span class="material-symbols-outlined text-sm text-accent-neon">replay</span>
                <span class="text-xs font-bold text-on-surface/60">{{ intentosUsados }}/{{ maxIntentos }} intentos</span>
              </div>
            </div>

            <!-- Botones compactos -->
            <div class="relative z-10 flex flex-col gap-3">
              <button v-if="passed" @click="viewCertificate" :disabled="loadingCert" class="btn-premium btn-primary-neon !w-full !justify-center !py-3.5 gap-2 text-sm">
                <span class="material-symbols-outlined text-base">{{ loadingCert ? 'hourglass_empty' : 'workspace_premium' }}</span>
                {{ loadingCert ? 'Generando...' : 'Ver certificado' }}
              </button>

              <button v-if="!passed && intentosRestantes > 0" @click="retryExam" class="btn-premium btn-primary-neon !w-full !justify-center !py-3.5 gap-2 text-sm">
                <span class="material-symbols-outlined text-base">refresh</span>
                Reintentar ({{ intentosRestantes }})
              </button>

              <div v-if="!passed && intentosRestantes <= 0" class="flex w-full items-center justify-center gap-2 rounded-2xl bg-red-500/10 px-5 py-3 text-xs font-bold text-red-400">
                <span class="material-symbols-outlined text-base">block</span>
                Sin intentos restantes
              </div>

              <button @click="exitExam" class="btn-premium btn-secondary-glass !w-full !justify-center !py-3.5 gap-2 text-sm">
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

    // Consultar cuántos intentos ya usó este usuario
    try {
      const intentosRes = await api.get('/intentos-evaluacion')
      const misIntentos = intentosRes.data.filter(
        (i) => Number(i.evaluacion_id) === Number(evaluacion.value.id) && Number(i.usuario_id) === Number(authStore.user?.id)
      )
      intentosUsados.value = misIntentos.length

      // Si ya aprobó, no permitir más intentos
      const yaAprobo = misIntentos.some((i) => i.aprobado === true)
      if (yaAprobo) {
        bloqueado.value = true
        return
      }

      // Si ya agotó intentos
      if (intentosUsados.value >= maxIntentos.value) {
        bloqueado.value = true
        return
      }
    } catch (e) {
      console.warn('No se pudo verificar intentos previos:', e)
    }

    timeLeft.value = (evaluacion.value.tiempo_limite || 30) * 60
    startTime.value = new Date()
    startTimer()
  } catch (error) {
    console.error('Error fetching exam:', error)
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

  score.value = (earnedPoints / totalPoints) * 100
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

    // Actualizar contadores de intentos desde la respuesta del backend
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
  timeLeft.value = (evaluacion.value.tiempo_limite || 30) * 60
  startTime.value = new Date()
  startTimer()
}

onMounted(() => {
  fetchExam()
})

onUnmounted(() => {
  stopTimer()
})
</script>

<style scoped>
.fade-slide-enter-active, .fade-slide-leave-active { transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1); }
.fade-slide-enter-from { transform: translateX(20px); opacity: 0; }
.fade-slide-leave-to { transform: translateX(-20px); opacity: 0; }
</style>
