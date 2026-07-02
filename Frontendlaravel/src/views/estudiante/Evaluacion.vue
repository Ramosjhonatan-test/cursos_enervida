<template>
  <div class="min-h-screen bg-background text-on-surface font-lexend">
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
          <div v-if="!finished && !bloqueado" class="flex items-center gap-3 rounded-2xl !border-none bg-on-surface/5 px-4 py-3">
            <span class="material-symbols-outlined animate-pulse text-accent-neon">timer</span>
            <span :class="['text-lg font-black tabular-nums md:text-xl', timeLeft < 60 ? 'text-red-500' : 'text-on-surface']">
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

    <main class="mx-auto flex min-h-[calc(100vh-88px)] w-full max-w-6xl flex-col justify-center p-4 md:p-8">
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
          <div class="mb-8 flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
            <div>
              <p class="mb-2 text-[10px] font-black uppercase tracking-[0.2em] text-on-surface/30">Pregunta {{ currentQuestionIdx + 1 }} de {{ evaluacion?.preguntas?.length }}</p>
              <div class="flex flex-wrap gap-2">
                <div
                  v-for="(q, idx) in evaluacion?.preguntas"
                  :key="idx"
                  :class="[
                    'h-1.5 rounded-full transition-all duration-500',
                    idx === currentQuestionIdx ? 'w-10 bg-accent-neon' : (answers[q.id] !== undefined ? 'w-5 bg-accent-neon/40' : 'w-5 bg-on-surface/10')
                  ]"
                ></div>
              </div>
            </div>
            <span class="self-start rounded-full !border-none bg-accent-neon/10 px-4 py-2 text-[10px] font-black uppercase tracking-widest text-accent-neon md:self-auto">
              {{ currentQuestion?.puntos }} puntos
            </span>
          </div>

          <div class="glass-card-premium relative overflow-hidden rounded-[32px] p-6 shadow-2xl md:rounded-[48px] md:p-10 lg:p-14">
            <div class="absolute left-0 top-0 h-full w-1.5 bg-accent-neon opacity-25"></div>

            <h2 class="mb-8 pr-4 text-2xl font-black leading-tight md:text-3xl">{{ currentQuestion?.pregunta }}</h2>

            <div class="grid grid-cols-1 gap-4">
              <button
                v-for="resp in currentQuestion?.respuestas"
                :key="resp.id"
                @click="selectAnswer(resp.id)"
                :class="[
                  'flex w-full items-start gap-4 rounded-[24px] p-4 text-left transition-all duration-300 md:p-6 !border-none',
                  answers[currentQuestion.id] === resp.id ? 'bg-accent-neon/10 shadow-lg' : 'bg-on-surface/5 hover:bg-on-surface/10'
                ]"
              >
                <div
                  :class="[
                    'flex h-8 w-8 shrink-0 items-center justify-center rounded-xl transition-all',
                    answers[currentQuestion.id] === resp.id ? 'bg-accent-neon text-primary shadow-[0_0_10px_var(--accent-neon)]' : 'bg-on-surface/10 text-transparent'
                  ]"
                >
                  <span class="material-symbols-outlined text-sm font-black">check</span>
                </div>
                <span :class="['text-sm font-bold leading-6 md:text-lg', answers[currentQuestion.id] === resp.id ? 'text-on-surface' : 'text-on-surface/60']">
                  {{ resp.respuesta }}
                </span>
              </button>
            </div>
          </div>

          <div class="mt-8 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
            <button @click="prevQuestion" :disabled="currentQuestionIdx === 0" class="btn-premium btn-secondary-glass !w-full sm:!w-auto !justify-center !px-8 !py-4 gap-3 disabled:opacity-20">
              <span class="material-symbols-outlined text-sm">arrow_back</span>
              Anterior
            </button>

            <button
              v-if="currentQuestionIdx < (evaluacion?.preguntas?.length - 1)"
              @click="nextQuestion"
              :disabled="answers[currentQuestion.id] === undefined"
              class="btn-premium btn-primary-neon !w-full sm:!w-auto !justify-center !px-8 !py-4 gap-3"
            >
              Siguiente
              <span class="material-symbols-outlined text-sm">arrow_forward</span>
            </button>

            <button
              v-else
              @click="finishExam"
              :disabled="answers[currentQuestion.id] === undefined || submitting"
              class="btn-premium btn-primary-neon !w-full sm:!w-auto !justify-center !px-8 !py-4 gap-3 shadow-accent-neon/40"
            >
              {{ submitting ? 'Enviando...' : 'Finalizar examen' }}
              <span class="material-symbols-outlined text-sm">send</span>
            </button>
          </div>
        </div>

        <!-- RESULTADOS -->
        <div v-else-if="finished" class="mx-auto w-full max-w-3xl animate-in fade-in">
          <div :class="['glass-card-premium relative overflow-hidden rounded-[32px] !border-none p-8 text-center shadow-2xl md:rounded-[48px] md:p-12', passed ? 'bg-accent-neon/5 shadow-accent-neon/10' : 'bg-red-500/5 shadow-red-500/10']">
            <div v-if="passed" class="pointer-events-none absolute inset-0 -z-10 bg-[radial-gradient(circle_at_center,_var(--accent-neon)_0%,_transparent_70%)] opacity-10"></div>

            <div :class="['relative z-10 mx-auto mb-8 flex h-24 w-24 items-center justify-center rounded-[32px] !border-none shadow-inner', passed ? 'bg-accent-neon/10 text-accent-neon' : 'bg-red-500/10 text-red-500']">
              <span class="material-symbols-outlined text-5xl font-black">{{ passed ? 'workspace_premium' : 'error' }}</span>
            </div>

            <h2 class="text-4xl font-black tracking-tight md:text-5xl">
              {{ passed ? 'Felicitaciones' : 'Sigue intentando' }}
            </h2>
            <p class="mb-10 mt-4 text-sm font-medium uppercase tracking-[0.28em] text-on-surface-variant opacity-70">
              {{ passed ? 'Has aprobado la evaluacion' : 'No alcanzaste la nota minima' }}
            </p>

            <div class="mb-10 grid grid-cols-1 gap-4 sm:grid-cols-3">
              <div class="rounded-[28px] !border-none bg-on-surface/5 p-6">
                <p class="mb-2 text-[10px] font-black uppercase tracking-widest text-on-surface/40">Tu puntaje</p>
                <h4 :class="['text-4xl font-black', passed ? 'text-accent-neon' : 'text-red-500']">{{ Math.round(score) }}%</h4>
              </div>
              <div class="rounded-[28px] !border-none bg-on-surface/5 p-6">
                <p class="mb-2 text-[10px] font-black uppercase tracking-widest text-on-surface/40">Aprobacion</p>
                <h4 class="text-4xl font-black text-on-surface">{{ Math.round(evaluacion.nota_aprobacion) }}%</h4>
              </div>
              <div class="rounded-[28px] !border-none bg-on-surface/5 p-6">
                <p class="mb-2 text-[10px] font-black uppercase tracking-widest text-on-surface/40">Intentos</p>
                <h4 class="text-4xl font-black text-on-surface">{{ intentosUsados }}/{{ maxIntentos }}</h4>
              </div>
            </div>

            <div class="relative z-10 flex flex-col gap-4 sm:flex-row">
              <button @click="exitExam" class="btn-premium btn-secondary-glass !w-full !justify-center !px-8 !py-4 gap-3">
                <span class="material-symbols-outlined text-lg">arrow_back</span>
                Volver al curso
              </button>

              <button v-if="!passed && intentosRestantes > 0" @click="retryExam" class="btn-premium btn-primary-neon !w-full !justify-center !px-8 !py-4 gap-3">
                <span class="material-symbols-outlined text-lg">refresh</span>
                Reintentar ({{ intentosRestantes }} restante{{ intentosRestantes > 1 ? 's' : '' }})
              </button>

              <div v-if="!passed && intentosRestantes <= 0" class="flex w-full items-center justify-center gap-2 rounded-2xl !border-none bg-red-500/10 px-6 py-4 text-sm font-bold text-red-400">
                <span class="material-symbols-outlined text-lg">block</span>
                Sin intentos restantes
              </div>

              <button v-if="passed" @click="viewCertificate" :disabled="loadingCert" class="btn-premium btn-primary-neon !w-full !justify-center !px-8 !py-4 gap-3">
                <span class="material-symbols-outlined text-lg">{{ loadingCert ? 'hourglass_empty' : 'workspace_premium' }}</span>
                {{ loadingCert ? 'Generando...' : 'Ver certificado' }}
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
