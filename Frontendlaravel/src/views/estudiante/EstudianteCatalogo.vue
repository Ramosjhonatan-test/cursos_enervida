<template>
  <div class="relative min-h-screen transition-colors duration-300">
    <!-- Orbes decorativos de fondo -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[500px] w-[500px] rounded-full bg-accent-neon/10 dark:bg-accent-neon/15 blur-[120px] animate-pulse"></div>
      <div class="absolute -right-[5%] top-[20%] h-[400px] w-[400px] rounded-full bg-accent-solar/10 dark:bg-accent-solar/5 blur-[100px]"></div>
    </div>

    <div class="relative z-10 max-w-7xl mx-auto py-6 sm:py-10 px-4 sm:px-6 space-y-8 md:space-y-12">
      <!-- Header de la Página -->
      <EstudiantePageHeader
        eyebrow="Programas de formación"
        title="Catálogo de"
        highlight="Cursos"
        description="Explora las rutas disponibles, compara niveles y envía tu solicitud desde una vista más clara y cómoda."
      />

      <!-- Estado de Carga (Skeletons) -->
      <div v-if="loading" class="grid grid-cols-1 gap-6 sm:gap-8 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        <div 
          v-for="i in 8" 
          :key="i" 
          class="h-[420px] rounded-3xl bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 p-5 flex flex-col justify-between animate-pulse shadow-sm"
        >
          <div class="w-full h-44 rounded-2xl bg-gray-200 dark:bg-white/10"></div>
          <div class="space-y-3 my-4">
            <div class="h-4 w-1/3 rounded bg-gray-200 dark:bg-white/10"></div>
            <div class="h-6 w-3/4 rounded bg-gray-200 dark:bg-white/10"></div>
            <div class="h-4 w-full rounded bg-gray-200 dark:bg-white/10"></div>
          </div>
          <div class="h-11 w-full rounded-xl bg-gray-200 dark:bg-white/10 mt-auto"></div>
        </div>
      </div>

      <!-- Estado Vacío -->
      <div 
        v-else-if="availableCourses.length === 0" 
        class="student-empty flex flex-col items-center justify-center p-8 sm:p-16 text-center rounded-3xl sm:rounded-[48px] bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 shadow-xl"
      >
        <div class="mx-auto mb-6 flex h-20 w-20 sm:h-24 sm:w-24 items-center justify-center rounded-full bg-accent-neon/10 text-accent-neon border border-accent-neon/20 shadow-md">
          <span class="material-symbols-outlined text-4xl sm:text-5xl">explore</span>
        </div>
        <h2 class="font-lexend text-2xl sm:text-3xl font-black text-gray-900 dark:text-white">No hay cursos disponibles</h2>
        <p class="mx-auto mt-3 max-w-md text-xs sm:text-sm text-gray-600 dark:text-white/50 leading-relaxed">
          Cuando se publiquen nuevas rutas formativas, aparecerán aquí con sus niveles, precios y acceso rápido.
        </p>
      </div>

      <!-- Grid Principal de Cursos -->
      <div v-else class="grid grid-cols-1 gap-6 sm:gap-8 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        <article
          v-for="curso in availableCourses"
          :key="curso.id"
          class="course-card-premium group relative flex flex-col rounded-3xl bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 shadow-lg hover:shadow-2xl dark:hover:border-accent-neon/40 transition-all duration-500 overflow-hidden"
        >
          <!-- Miniatura e Insignias -->
          <div class="relative aspect-video w-full overflow-hidden">
            <img 
              :src="getFileUrl(curso.miniatura_url)" 
              class="h-full w-full object-cover transition-transform duration-700 group-hover:scale-110" 
              :alt="curso.titulo"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent"></div>
            
            <!-- Badge Nivel -->
            <span class="absolute top-3 left-3 sm:top-4 sm:left-4 rounded-full bg-accent-neon px-3 py-1 text-[8px] sm:text-[9px] font-black uppercase tracking-widest text-background shadow-lg shadow-accent-neon/20">
              {{ curso.nivel || 'Básico' }}
            </span>
          </div>

          <!-- Contenido -->
          <div class="flex flex-1 flex-col p-5 sm:p-6">
            <!-- Categoría y Metadata -->
            <div class="mb-3 flex flex-wrap items-center justify-between gap-2">
              <span class="rounded-full bg-accent-neon/10 px-3 py-1 text-[8px] sm:text-[9px] font-black uppercase tracking-[0.15em] text-accent-neon border border-accent-neon/20">
                {{ curso.categoria?.nombre || 'Curso' }}
              </span>
              <span class="text-[9px] font-black uppercase tracking-widest text-gray-400 dark:text-white/30">Acceso guiado</span>
            </div>

            <!-- Título del Curso -->
            <h3 class="font-lexend text-base sm:text-lg font-black leading-snug text-gray-900 dark:text-white group-hover:text-accent-neon transition-colors line-clamp-2">
              {{ curso.titulo }}
            </h3>

            <!-- Descripción Corta -->
            <p class="mt-2.5 line-clamp-3 text-xs leading-relaxed text-gray-600 dark:text-white/50">
              {{ curso.descripcion_corta || 'Formación técnica especializada para avanzar con criterio y buen ritmo.' }}
            </p>

            <!-- Footer: Inversión & Acciones -->
            <div class="mt-auto pt-6 flex flex-col gap-3">
              <div class="flex justify-between items-center pb-2 border-b border-gray-100 dark:border-white/5">
                <p class="text-[9px] font-black uppercase tracking-widest text-gray-400 dark:text-white/30">Inversión</p>
                <span class="text-base sm:text-lg font-black text-accent-neon">
                  {{ curso.precio ? `${curso.precio} BS` : 'Gratis' }}
                </span>
              </div>

              <div class="flex flex-col sm:flex-row gap-2 w-full">
                <!-- Botón Ver Detalle -->
                <button 
                  @click="openCourseDetails(curso)" 
                  class="w-full sm:w-1/2 text-[9px] font-black uppercase tracking-widest py-3 sm:py-3.5 rounded-xl border-0 bg-gray-100 hover:bg-gray-200 dark:bg-white/5 dark:hover:bg-white/10 text-gray-800 dark:text-white hover:text-accent-neon transition-all text-center"
                >
                  Ver detalle
                </button>

                <!-- Botón de Estado del Curso -->
                <button 
                  v-if="getEnrollmentState(curso.id) === 'COMPLETADO'" 
                  disabled 
                  class="btn-premium w-full sm:w-1/2 flex items-center justify-center gap-1.5 rounded-xl py-3 sm:py-3.5 text-[9px] bg-accent-neon/10 text-accent-neon border-0 cursor-not-allowed"
                >
                  <span class="material-symbols-outlined text-sm">workspace_premium</span>
                  Completado
                </button>

                <button 
                  v-else-if="getEnrollmentState(curso.id) === 'INSCRITO'" 
                  disabled 
                  class="btn-premium w-full sm:w-1/2 flex items-center justify-center gap-1.5 rounded-xl py-3 sm:py-3.5 text-[9px] bg-gray-200/80 dark:bg-white/10 text-gray-500 dark:text-white/50 border-0 cursor-not-allowed"
                >
                  <span class="material-symbols-outlined text-sm">check_circle</span>
                  Inscrito
                </button>

                <button 
                  v-else 
                  @click="$emit('enroll', curso.id)" 
                  class="btn-premium btn-primary-neon w-full sm:w-1/2 rounded-xl py-3 sm:py-3.5 text-[9px] font-black uppercase tracking-widest"
                >
                  Inscribirme
                </button>
              </div>
            </div>
          </div>
        </article>
      </div>
    </div>

    <!-- Modal Detalle -->
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
import { computed, ref } from 'vue'
import EstudiantePageHeader from '@/components/estudiante/EstudiantePageHeader.vue'
import ModalDetalleCurso from '@/components/estudiante/ModalDetalleCurso.vue'
import { getFileUrl } from '@/config'
import api from '@/services/api'

const props = defineProps({
  availableCourses: {
    type: Array,
    default: () => [],
  },
  inscripciones: {
    type: Array,
    default: () => [],
  },
  loading: {
    type: Boolean,
    default: false,
  },
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

function isEnrolled(cursoId) {
  return enrolledCourseIds.value.has(cursoId)
}

const emit = defineEmits(['enroll'])

const isModalOpen = ref(false)
const selectedCourse = ref(null)

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

const headerStats = computed(() => [
  {
    label: 'Cursos abiertos',
    value: props.loading ? '...' : props.availableCourses.length,
    help: 'Oferta visible para solicitudes',
    icon: 'school',
  },
  {
    label: 'Lectura rapida',
    value: '4 columnas',
    help: 'La grilla se adapta mejor en tablet y movil',
    icon: 'dashboard',
  },
])

</script>
