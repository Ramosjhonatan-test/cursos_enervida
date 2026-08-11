<template>
  <div class="relative min-h-screen transition-colors duration-300">
    <!-- Orbes decorativos de fondo -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[500px] w-[500px] rounded-full bg-accent-neon/10 dark:bg-accent-neon/15 blur-[120px] animate-pulse"></div>
      <div class="absolute -right-[5%] top-[20%] h-[400px] w-[400px] rounded-full bg-accent-solar/10 dark:bg-accent-solar/5 blur-[100px]"></div>
    </div>

    <div class="relative z-10 max-w-7xl mx-auto pt-3 pb-6 sm:py-8 px-4 sm:px-6">
      <div class="space-y-8 sm:space-y-10">

        <!-- Header personalizado (estilo original intacto) -->
        <div class="flex flex-col gap-6 lg:flex-row lg:items-center lg:justify-between">
          <div class="space-y-2">
            <div class="text-[11px] sm:text-xs font-black uppercase tracking-[0.2em] text-accent-neon flex items-center gap-1.5">
              <span>HOLA, {{ typedName }}</span>
              <span class="inline-block w-1.5 h-3.5 bg-accent-neon animate-pulse"></span>
            </div>

            <h1 class="font-lexend text-3xl sm:text-4xl md:text-5xl font-black tracking-tight text-gray-900 dark:text-white">
              Tu <span class="text-transparent bg-clip-text bg-gradient-to-r from-accent-neon to-accent-solar">Escritorio</span>
            </h1>

            <p class="text-xs sm:text-sm text-gray-600 dark:text-white/60 max-w-xl">
              Bienvenido de nuevo. Aquí tienes un resumen de tu actividad para continuar tu formación.
            </p>
          </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-[1fr_380px] gap-6 sm:gap-10">
          <!-- Main Column -->
          <div class="space-y-8 sm:space-y-10">

            <!-- SKELETON LOADER -->
            <template v-if="loading">
              <div class="h-80 w-full rounded-3xl sm:rounded-[48px] bg-gray-200/60 dark:bg-white/5 animate-pulse border border-gray-300/40 dark:border-white/10"></div>
              <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6">
                <div v-for="i in 3" :key="i" class="h-72 rounded-3xl bg-gray-200/60 dark:bg-white/5 animate-pulse border border-gray-300/40 dark:border-white/10"></div>
              </div>
            </template>

            <template v-else>
              <!-- Curso Principal / Hero (estilo original, solo fix de botón) -->
              <section
                v-if="ultimoCurso"
                class="panel-hero group relative p-5 sm:p-8 md:p-12 overflow-hidden animate-in fade-in slide-in-from-bottom-4 duration-500 rounded-3xl sm:rounded-[48px] bg-white dark:bg-surface shadow-xl dark:shadow-2xl transition-all"
              >
                <div class="flex flex-col gap-6 md:gap-10 xl:flex-row xl:items-center">
                  <div class="relative aspect-video w-full shrink-0 overflow-hidden rounded-2xl sm:rounded-[32px] border-0 shadow-xl xl:w-[320px]">
                    <img :src="getFileUrl(ultimoCurso.curso?.miniatura_url)" class="h-full w-full object-cover transition-transform duration-1000 group-hover:scale-110" />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent opacity-0 transition-opacity duration-500 group-hover:opacity-100"></div>
                  </div>

                  <div class="flex-grow min-w-0">
                    <div class="mb-4 inline-flex items-center gap-2 rounded-xl bg-accent-solar text-background px-3.5 py-1.5 shadow-sm shadow-accent-neon/20">
                      <span class="relative flex h-2 w-2">
                        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-background opacity-75"></span>
                        <span class="relative inline-flex rounded-full h-2 w-2 bg-background"></span>
                      </span>
                      <span class="text-[10px] font-black uppercase tracking-[0.2em] text-background">Retomar ahora</span>
                    </div>
                    <h2 class="font-lexend text-2xl sm:text-3xl font-black leading-tight tracking-tight text-gray-900 dark:text-white md:text-4xl">
                      {{ ultimoCurso.curso?.titulo }}
                    </h2>

                    <div class="mt-6 md:mt-8 flex flex-col sm:flex-row sm:items-center gap-4 sm:gap-6">
                      <router-link :to="'/student/course/' + ultimoCurso.curso.id" class="btn-premium btn-primary-neon w-full sm:w-auto inline-flex items-center justify-center gap-2 !px-6 sm:!px-10 !py-4 sm:!py-5 !text-[11px] shadow-neon-sm whitespace-nowrap">
                        {{ (ultimoCurso.porcentaje_progreso || 0) > 0 ? 'Reanudar curso' : 'Empezar ahora' }}
                        <span class="material-symbols-outlined text-lg">play_arrow</span>
                      </router-link>
                      <div class="flex-grow w-full sm:max-w-xs">
                        <div class="mb-3 flex justify-between text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">
                          <span>Tu progreso</span>
                          <span class="text-accent-neon font-bold">{{ Math.round(ultimoCurso.porcentaje_progreso || 0) }}%</span>
                        </div>
                        <div class="glass-progress-bar h-2 w-full overflow-hidden rounded-full bg-gray-200 dark:bg-white/10">
                          <div class="glass-progress-fill h-full rounded-full bg-accent-solar transition-all duration-500" :style="{ width: `${ultimoCurso.porcentaje_progreso || 0}%` }"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </section>

              <!-- Recomendaciones / Catálogo (estilo original intacto) -->
              <section v-if="availableCourses.length > 0" class="space-y-6 animate-in fade-in slide-in-from-bottom-8 duration-1000">
                <div class="flex items-center justify-between">
                  <h3 class="font-lexend text-2xl font-black text-gray-900 dark:text-white">Explorar <span class="text-accent-solar">Nuevos Cursos</span></h3>
                  <router-link to="/student/catalog" class="text-[10px] font-black uppercase tracking-widest text-accent-solar hover:underline">Ver catálogo</router-link>
                </div>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-5 sm:gap-6">
                  <div
                    v-for="curso in availableCourses.slice(0, 6)"
                    :key="curso.id"
                    class="course-card-premium group overflow-hidden flex flex-col rounded-3xl bg-white dark:bg-surface shadow-lg hover:shadow-2xl hover:-translate-y-1 transition-all duration-300"
                  >
                    <div class="relative aspect-[4/3] overflow-hidden">
                      <img :src="getFileUrl(curso.miniatura_url)" class="h-full w-full object-cover transition-transform duration-700 group-hover:scale-110" />
                      <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/10 to-transparent"></div>
                      <div class="absolute top-4 right-4">
                        <span class="inline-flex items-center gap-1.5 px-3 py-1.5 bg-amber-500 text-white rounded-br-lg rounded-tl-2xl text-[10px] font-bold uppercase tracking-wider shadow-md">
                          <span class="material-symbols-outlined text-sm leading-none">{{ curso.precio === 0 ? 'redeem' : 'payments' }}</span>
                          <span>{{ curso.precio === 0 ? 'GRATIS' : curso.precio + ' Bs' }}</span>
                        </span>
                      </div>
                    </div>

                    <div class="p-6 flex-grow flex flex-col">
                      <h4 class="font-lexend font-black text-lg sm:text-xl leading-tight line-clamp-2 text-gray-900 dark:text-white">{{ curso.titulo }}</h4>
                      <p class="text-xs text-gray-600 dark:text-white/50 mt-3 line-clamp-2 leading-relaxed">{{ curso.descripcion }}</p>
                      <div class="mt-auto pt-5 flex items-center gap-2">
                        <button
                          @click="openCourseDetails(curso)"
                          class="flex-1 text-[11px] font-black uppercase tracking-widest py-3 px-4 rounded-xl bg-gray-100 hover:bg-gray-200 dark:bg-white/5 dark:hover:bg-white/10 text-gray-800 dark:text-white hover:text-accent-neon transition-all text-center cursor-pointer">
                           ver Detalles
                        </button>

                        <button
                          v-if="getEnrollmentState(curso.id) === 'COMPLETADO'"
                          disabled
                          class="flex-1 inline-flex items-center justify-center gap-1.5 text-[11px] font-black uppercase tracking-widest py-3 px-4 rounded-xl bg-accent-neon/15 text-accent-neon cursor-not-allowed">
                          <span class="material-symbols-outlined text-sm">workspace_premium</span>
                          Listo
                        </button>

                        <button
                          v-else-if="getEnrollmentState(curso.id) === 'INSCRITO'"
                          disabled
                          class="flex-1 inline-flex items-center justify-center gap-1.5 text-[11px] font-black uppercase tracking-widest py-3 px-4 rounded-xl bg-white/10 text-neutral-900 dark:text-white/60 cursor-not-allowed"
                        >
                          <span class="material-symbols-outlined text-sm">check_circle</span>
                          Inscrito
                        </button>

                        <button
                          v-else
                          @click="$emit('enroll', curso.id)"
                          class="flex-1 btn-premium btn-primary-neon text-[11px] font-black uppercase tracking-widest py-3 px-4 rounded-xl cursor-pointer"
                        >
                          Inscribirme
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </section>

              <!-- Estado vacío SOLO cuando NO hay absolutamente nada -->
              <section
                v-if="!ultimoCurso && inscripciones.length === 0 && availableCourses.length === 0"
                class="course-card-premium flex flex-col items-center justify-center p-8 sm:p-16 text-center rounded-3xl sm:rounded-[48px] border-0 bg-white dark:bg-surface shadow-xl"
              >
                <div class="mb-6 flex h-20 w-20 items-center justify-center rounded-full bg-accent-neon/10 text-accent-neon border border-accent-neon/20">
                  <span class="material-symbols-outlined text-4xl">school</span>
                </div>
                <h2 class="font-lexend text-3xl font-black text-gray-900 dark:text-white">Comienza tu viaje</h2>
                <p class="mt-4 max-w-md text-sm text-gray-600 dark:text-white/50">Explora nuestro catálogo de cursos especializados y da el primer paso en tu formación profesional hoy mismo.</p>
                <router-link to="/student/catalog" class="btn-premium btn-primary-neon mt-10 !px-12">Ver catálogo</router-link>
              </section>
            </template>
          </div>

          <!-- Sidebar Column -->
          <aside class="space-y-8">
            <!-- TU ACTIVIDAD: bloque sustancial con stats + progreso -->
            <div class="course-card-premium p-5 sm:p-6 rounded-3xl bg-white dark:bg-surface shadow-lg">
              <div class="flex items-center justify-between mb-5">
                <div class="flex items-center gap-2">
                  <span class="material-symbols-outlined text-accent-neon text-lg">insights</span>
                  <h3 class="text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Tu Actividad</h3>
                </div>
                <span class="text-[9px] font-black uppercase tracking-widest text-accent-neon">En vivo</span>
              </div>

              <div class="grid grid-cols-2 gap-3">
                <div class="text-center p-4 rounded-2xl bg-accent-neon/10">
                  <div class="flex items-center justify-center h-10 w-10 mx-auto rounded-xl bg-accent-neon/20 mb-2">
                    <span class="material-symbols-outlined text-accent-neon">school</span>
                  </div>
                  <div class="text-3xl font-lexend font-black text-accent-neon leading-none">
                    <span v-if="loading" class="inline-block h-7 w-8 bg-gray-200 dark:bg-white/10 animate-pulse rounded mx-auto"></span>
                    <span v-else>{{ cursosActivos.length }}</span>
                  </div>
                  <div class="text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 mt-2">Activos</div>
                </div>
                <div class="text-center p-4 rounded-2xl bg-accent-solar/10">
                  <div class="flex items-center justify-center h-10 w-10 mx-auto rounded-xl bg-accent-solar/20 mb-2">
                    <span class="material-symbols-outlined text-accent-solar">workspace_premium</span>
                  </div>
                  <div class="text-3xl font-lexend font-black text-accent-solar leading-none">
                    <span v-if="loading" class="inline-block h-7 w-8 bg-gray-200 dark:bg-white/10 animate-pulse rounded mx-auto"></span>
                    <span v-else>{{ cursosCompletados.length }}</span>
                  </div>
                  <div class="text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 mt-2">Completados</div>
                </div>
              </div>

              <div class="mt-5">
                <div class="flex justify-between items-center mb-2">
                  <span class="text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Avance promedio</span>
                  <span class="text-sm font-lexend font-black text-accent-neon">{{ promedioProgreso }}%</span>
                </div>
                <div class="h-2 w-full overflow-hidden rounded-full bg-white/5">
                  <div
                    class="h-full rounded-full bg-gradient-to-r from-accent-neon to-accent-solar transition-all duration-700"
                    :style="{ width: `${promedioProgreso}%` }"
                  ></div>
                </div>
              </div>
            </div>

            <!-- CONTINUAR FORMACIÓN (movido del main column para llenar sidebar) -->
            <section v-if="otrosCursos.length > 0" class="space-y-3">
              <div class="flex items-center justify-between px-2">
                <h3 class="font-lexend text-lg font-black text-gray-900 dark:text-white">Continuar <span class="text-accent-neon">formación</span></h3>
                <router-link to="/student/my-courses" class="text-[9px] font-black uppercase tracking-widest text-gray-400 hover:text-accent-neon">Ver todos</router-link>
              </div>
              <div class="space-y-2">
                <router-link
                  v-for="ins in otrosCursos.slice(0, 3)"
                  :key="ins.id"
                  :to="'/student/course/' + ins.curso?.id"
                  class="course-card-premium group flex items-center gap-3 p-3 transition-all rounded-2xl bg-white dark:bg-surface shadow-sm hover:shadow-md"
                >
                  <div class="h-10 w-14 shrink-0 overflow-hidden rounded-lg bg-gray-100 dark:bg-white/5">
                    <img :src="getFileUrl(ins.curso?.miniatura_url)" class="h-full w-full object-cover transition-transform group-hover:scale-105" />
                  </div>
                  <div class="min-w-0 flex-1">
                    <h4 class="truncate font-lexend text-xs font-black text-gray-900 dark:text-white group-hover:text-accent-neon transition-colors">{{ ins.curso?.titulo }}</h4>
                    <div class="mt-1.5 flex items-center gap-2">
                      <div class="h-1 flex-1 overflow-hidden rounded-full bg-white/5">
                        <div class="h-full bg-accent-neon rounded-full transition-all duration-500" :style="{ width: `${ins.porcentaje_progreso || 0}%` }"></div>
                      </div>
                      <span class="text-[9px] font-mono font-black text-gray-500 dark:text-white/40">{{ Math.round(ins.porcentaje_progreso || 0) }}%</span>
                    </div>
                  </div>
                  <span class="material-symbols-outlined text-gray-400 group-hover:text-accent-neon group-hover:translate-x-1 transition-all shrink-0 text-base">arrow_forward</span>
                </router-link>
              </div>
            </section>

            <!-- Clases en Vivo Sidebar (más sustancial) -->
            <section v-if="liveClasses && liveClasses.length > 0" class="space-y-4">
              <div class="flex items-center justify-between px-2">
                <h3 class="font-lexend text-xl font-black text-gray-900 dark:text-white">Próximos <span class="text-accent-neon">Vivos</span></h3>
                <router-link to="/student/live-classes" class="text-[9px] font-black uppercase tracking-widest text-gray-400 hover:text-accent-neon dark:text-white/40">Ver todos</router-link>
              </div>

              <div class="space-y-3">
                <div
                  v-for="clase in liveClasses.slice(0, 3)"
                  :key="clase.id"
                  class="course-card-premium p-5 flex flex-col gap-3 transition-all rounded-2xl bg-white dark:bg-surface shadow-md hover:shadow-lg dark:hover:bg-accent-neon/5"
                >
                  <div class="flex items-center justify-between">
                    <span class="inline-flex items-center gap-1.5 text-[9px] font-black uppercase tracking-widest px-2.5 py-1 rounded-full bg-accent-neon text-black">
                      <span class="h-1.5 w-1.5 rounded-full bg-black animate-pulse"></span>
                      En vivo
                    </span>
                    <span class="text-[9px] font-bold text-gray-400 dark:text-white/40 uppercase tracking-widest">{{ formatDate(clase.fecha) }}</span>
                  </div>
                  <h4 class="font-lexend font-black text-sm leading-snug line-clamp-2 text-gray-900 dark:text-white">{{ clase.titulo }}</h4>
                  <div class="flex items-center justify-between pt-1">
                    <div class="flex items-center gap-1.5">
                      <span class="material-symbols-outlined text-accent-neon text-base">schedule</span>
                      <span class="text-[10px] font-bold text-gray-500 dark:text-white/50">{{ formatTime(clase.fecha) }}</span>
                    </div>
                    <router-link to="/student/live-classes" class="inline-flex items-center gap-1 text-[9px] font-black uppercase tracking-widest text-accent-neon hover:underline">
                      Entrar
                      <span class="material-symbols-outlined text-sm">arrow_forward</span>
                    </router-link>
                  </div>
                </div>
              </div>
            </section>

            <!-- ACTIVIDAD RECIENTE (desde notifications) -->
            <section v-if="notifications && notifications.length > 0" class="space-y-3">
              <div class="flex items-center justify-between px-2">
                <h3 class="font-lexend text-lg font-black text-gray-900 dark:text-white flex items-center gap-2">
                  <span class="material-symbols-outlined text-accent-solar text-base">notifications_active</span>
                  Actividad <span class="text-accent-solar">reciente</span>
                </h3>
              </div>
              <div class="space-y-2">
                <div
                  v-for="n in notifications.slice(0, 3)"
                  :key="n.id || n.created_at"
                  class="course-card-premium p-3 rounded-xl bg-white dark:bg-surface shadow-sm hover:shadow-md transition-shadow"
                >
                  <div class="flex items-start gap-3">
                    <div class="h-8 w-8 shrink-0 rounded-xl bg-accent-solar/15 flex items-center justify-center">
                      <span class="material-symbols-outlined text-accent-solar text-base">campaign</span>
                    </div>
                    <div class="flex-1 min-w-0">
                      <p class="text-xs text-gray-700 dark:text-white/70 leading-snug line-clamp-2">{{ n.mensaje || n.titulo || n.texto || 'Nueva notificación' }}</p>
                      <p v-if="n.created_at" class="mt-1 text-[9px] font-bold text-gray-400 uppercase tracking-widest">{{ formatDate(n.created_at) }}</p>
                    </div>
                  </div>
                </div>
              </div>
            </section>

            <!-- Quick Link Support (más sustancial) -->
            <router-link
              to="/student/support"
              class="course-card-premium relative flex items-center gap-4 p-5 rounded-2xl group overflow-hidden bg-gradient-to-br from-accent-solar/15 via-white to-accent-neon/10 dark:from-accent-solar/10 dark:via-surface dark:to-accent-neon/5 shadow-lg hover:shadow-xl transition-all"
            >
              <div class="relative z-10 flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl bg-accent-solar text-background shadow-lg shadow-accent-solar/30 group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined text-xl">support_agent</span>
              </div>
              <div class="relative z-10 flex-1 min-w-0">
                <p class="text-[9px] font-black uppercase tracking-[0.2em] text-accent-solar mb-1">¿Necesitas ayuda?</p>
                <p class="text-sm font-black text-gray-900 dark:text-white">Centro de Soporte</p>
                <p class="text-[10px] text-gray-500 dark:text-white/40 mt-0.5">Respuesta en menos de 24h</p>
              </div>
              <span class="relative z-10 material-symbols-outlined text-gray-400 group-hover:text-accent-solar group-hover:translate-x-1 transition-all">
                arrow_forward
              </span>
              <div class="absolute -right-4 -bottom-4 h-24 w-24 rounded-full bg-accent-solar/20 blur-2xl group-hover:bg-accent-solar/30 transition-all"></div>
            </router-link>
          </aside>
        </div>
      </div>
    </div>

    <ModalDetalleCurso
      :isOpen="isModalOpen"
      :course="selectedCourse"
      :isEnrolled="selectedCourse ? getEnrollmentState(selectedCourse.id) === 'INSCRITO' || getEnrollmentState(selectedCourse.id) === 'COMPLETADO' : false"
      :courseStatus="selectedCourse ? getEnrollmentState(selectedCourse.id) : 'NONE'"
      @close="closeCourseDetails"
      @enroll="handleModalEnroll"
    />
  </div>
</template>

<script setup>
import { computed, ref, onMounted, watch } from 'vue'
import ModalDetalleCurso from '@/components/estudiante/ModalDetalleCurso.vue'
import { useAuthStore } from '@/stores/auth'
import { getFileUrl } from '@/config'
import api from '@/services/api'

const authStore = useAuthStore()

const props = defineProps({
  inscripciones: {
    type: Array,
    default: () => [],
  },
  ultimoCurso: {
    type: Object,
    default: null,
  },
  availableCourses: {
    type: Array,
    default: () => [],
  },
  notifications: {
    type: Array,
    default: () => [],
  },
  liveClasses: {
    type: Array,
    default: () => [],
  },
  loading: {
    type: Boolean,
    default: false,
  },
})

const emit = defineEmits(['enroll'])

const isModalOpen = ref(false)
const selectedCourse = ref(null)

// Efecto de máquina de escribir en el nombre (igual que el original)
const typedName = ref('')
const fullNameToType = computed(() => (authStore.user?.nombres || 'ESTUDIANTE').toUpperCase())

function startTypingEffect() {
  const text = fullNameToType.value
  typedName.value = ''
  let index = 0

  const interval = setInterval(() => {
    if (index < text.length) {
      typedName.value += text.charAt(index)
      index++
    } else {
      clearInterval(interval)
    }
  }, 100)
}

onMounted(() => {
  startTypingEffect()
})

watch(() => authStore.user?.nombres, () => {
  startTypingEffect()
})

const enrolledCourseIds = computed(() => {
  return new Set(props.inscripciones
    .filter(ins => ins.estado === 'ACTIVO' || ins.estado === 'PENDIENTE' || ins.estado === 'COMPLETADO')
    .map(ins => ins.curso_id || ins.curso?.id))
})

function getEnrollmentState(cursoId) {
  const inscripcion = props.inscripciones.find((ins) => {
    const courseId = ins.curso_id || ins.curso?.id
    return Number(courseId) === Number(cursoId)
  })

  if (!inscripcion) return 'NONE'
  if (inscripcion.estado === 'COMPLETADO') return 'COMPLETADO'
  if (inscripcion.estado === 'ACTIVO' || inscripcion.estado === 'PENDIENTE') return 'INSCRITO'
  return 'NONE'
}

async function openCourseDetails(course) {
  isModalOpen.value = true
  selectedCourse.value = course

  try {
    const response = await api.get(`/cursos/${course.id}`)
    selectedCourse.value = response.data
  } catch (error) {
    console.error('Error cargando detalle del curso:', error)
  }
}

function closeCourseDetails() {
  isModalOpen.value = false
  setTimeout(() => {
    selectedCourse.value = null
  }, 300)
}

function handleModalEnroll(course) {
  emit('enroll', course.id)
  closeCourseDetails()
}

const cursosActivos = computed(() => {
  return props.inscripciones.filter(ins => ins.estado === 'ACTIVO')
})

const cursosCompletados = computed(() => {
  return props.inscripciones.filter(ins => (ins.porcentaje_progreso || 0) >= 100)
})

const promedioProgreso = computed(() => {
  if (cursosActivos.value.length === 0) return 0
  const sum = cursosActivos.value.reduce((acc, ins) => acc + (ins.porcentaje_progreso || 0), 0)
  return Math.round(sum / cursosActivos.value.length)
})

const otrosCursos = computed(() => {
  if (!props.ultimoCurso) return cursosActivos.value
  return cursosActivos.value.filter(ins => ins.id !== props.ultimoCurso.id)
})

function formatDate(value) {
  if (!value) return 'Sin fecha'
  return new Date(value).toLocaleDateString('es-BO', { day: '2-digit', month: 'short' })
}

function formatTime(value) {
  if (!value) return ''
  return new Date(value).toLocaleTimeString('es-BO', { hour: '2-digit', minute: '2-digit' })
}
</script>
