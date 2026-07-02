<template>
  <div class="relative min-h-screen">
    <!-- Orbes decorativos de fondo -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[500px] w-[500px] rounded-full bg-accent-neon/10 blur-[120px] animate-pulse"></div>
      <div class="absolute -right-[5%] top-[20%] h-[400px] w-[400px] rounded-full bg-accent-solar/5 blur-[100px]"></div>
    </div>

    <div class="relative z-10 max-w-7xl mx-auto py-6 sm:py-10 px-4 sm:px-6">
      <div class="space-y-12">
        <!-- Header -->
        <div class="flex flex-col gap-8 lg:flex-row lg:items-center lg:justify-between">
          <EstudiantePageHeader
            :eyebrow="`Hola, ${authStore.user?.nombres || 'Estudiante'}`"
            title="Tu"
            highlight="Escritorio "
            description="Bienvenido de nuevo. Aquí tienes un resumen de tu actividad para continuar tu formación."
          />
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-[1fr_380px] gap-6 sm:gap-10">
          <!-- Main Column -->
          <div class="space-y-12">
            <!-- Curso Principal / Hero -->
            <section v-if="ultimoCurso" class="panel-hero group relative p-5 sm:p-8 md:p-12 overflow-hidden animate-in fade-in slide-in-from-bottom-4 duration-500 rounded-3xl sm:rounded-[48px]">
              <div class="flex flex-col gap-6 md:gap-10 xl:flex-row xl:items-center">
                <div class="relative aspect-video w-full shrink-0 overflow-hidden rounded-2xl sm:rounded-[32px] !border-none shadow-2xl xl:w-[320px]">
                  <img :src="getFileUrl(ultimoCurso.curso?.miniatura_url)" class="h-full w-full object-cover transition-transform duration-1000 group-hover:scale-110" />
                  <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent opacity-0 transition-opacity duration-500 group-hover:opacity-100"></div>
                </div>
                
                <div class="flex-grow min-w-0">
                  <div class="mb-4 inline-flex items-center gap-2 rounded-full bg-accent-neon/10 px-4 py-1.5 !border-none">
                    <span class="relative flex h-2 w-2">
                      <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
                      <span class="relative inline-flex rounded-full h-2 w-2 bg-accent-neon"></span>
                    </span>
                    <span class="text-[10px] font-black uppercase tracking-[0.2em] text-accent-neon">Retomar ahora</span>
                  </div>
                  
                  <h2 class="font-lexend text-2xl sm:text-3xl font-black leading-tight tracking-tight text-on-surface md:text-4xl">
                    {{ ultimoCurso.curso?.titulo }}
                  </h2>
                  
                  <div class="mt-6 md:mt-8 flex flex-col sm:flex-row sm:items-center gap-4 sm:gap-6">
                    <router-link :to="'/student/course/' + ultimoCurso.curso.id" class="btn-premium btn-primary-neon w-full sm:w-auto inline-flex items-center justify-center gap-2 !px-6 sm:!px-10 !py-4 sm:!py-5 !text-[11px] shadow-neon-sm">
                      {{ (ultimoCurso.porcentaje_progreso || 0) > 0 ? 'Reanudar curso' : 'Empezar ahora' }}
                      <span class="material-symbols-outlined text-lg">play_arrow</span>
                    </router-link>
                    
                    <div class="flex-grow w-full sm:max-w-xs">
                      <div class="mb-3 flex justify-between text-[10px] font-black uppercase tracking-widest text-on-surface/40">
                        <span>Tu progreso</span>
                        <span class="text-accent-neon">{{ Math.round(ultimoCurso.porcentaje_progreso || 0) }}%</span>
                      </div>
                      <div class="glass-progress-bar h-2">
                        <div class="glass-progress-fill" :style="{ width: `${ultimoCurso.porcentaje_progreso || 0}%` }"></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </section>

            <!-- Otros cursos en progreso -->
            <section v-if="otrosCursos.length > 0" class="animate-in fade-in slide-in-from-bottom-6 duration-700">
              <div class="mb-8 flex items-center justify-between">
                <h3 class="font-lexend text-2xl font-black">Continuar <span class="text-accent-neon">formación</span></h3>
                <router-link to="/student/my-courses" class="text-[10px] font-black uppercase tracking-widest text-accent-neon hover:underline">Ver todos</router-link>
              </div>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div v-for="ins in otrosCursos" :key="ins.id" class="course-card-premium group relative flex items-center gap-4 sm:gap-6 p-4 sm:p-5 transition-all rounded-2xl sm:rounded-[28px]">
                  <div class="h-16 w-20 sm:h-20 sm:w-24 shrink-0 overflow-hidden rounded-xl sm:rounded-2xl !border-none bg-on-surface/5">
                    <img :src="getFileUrl(ins.curso?.miniatura_url)" class="h-full w-full object-cover" />
                  </div>
                  <div class="min-w-0 flex-grow">
                    <h4 class="truncate font-lexend text-sm sm:text-base font-black">{{ ins.curso?.titulo }}</h4>
                    <div class="mt-3 flex items-center gap-3 sm:gap-4">
                      <div class="h-1.5 flex-grow overflow-hidden rounded-full bg-on-surface/5">
                        <div class="h-full bg-accent-neon/40 transition-all" :style="{ width: `${ins.porcentaje_progreso || 0}%` }"></div>
                      </div>
                      <span class="text-[9px] font-black text-on-surface/30">{{ Math.round(ins.porcentaje_progreso || 0) }}%</span>
                    </div>
                  </div>
                  <router-link :to="'/student/course/' + ins.curso?.id" class="absolute inset-0 z-10" aria-label="Continuar curso"></router-link>
                </div>
              </div>
            </section>

            <!-- Recomendaciones -->
            <section v-if="availableCourses.length > 0 && inscripciones.length < 5" class="space-y-6 animate-in fade-in slide-in-from-bottom-8 duration-1000">
              <div class="flex items-center justify-between">
                <h3 class="font-lexend text-2xl font-black">Explorar <span class="text-accent-solar">Nuevos Cursos</span></h3>
                <router-link to="/student/catalog" class="text-[10px] font-black uppercase tracking-widest text-accent-solar hover:underline">Ver catálogo</router-link>
              </div>
              <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6">
                <div v-for="curso in availableCourses.slice(0, 3)" :key="curso.id" class="course-card-premium group overflow-hidden flex flex-col">
                  <div class="relative aspect-video overflow-hidden">
                    <img :src="getFileUrl(curso.miniatura_url)" class="h-full w-full object-cover transition-transform group-hover:scale-110" />
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
                  </div>
                  <div class="p-5 flex-grow flex flex-col">
                    <h4 class="font-lexend font-black text-base line-clamp-1">{{ curso.titulo }}</h4>
                    <p class="text-[10px] text-on-surface/40 mt-2 line-clamp-2 leading-relaxed">{{ curso.descripcion }}</p>
                    <div class="mt-auto pt-6 flex flex-col gap-2">
                      <div class="flex items-center justify-between mb-1">
                        <span class="text-xs font-bold text-accent-neon">{{ curso.precio === 0 ? 'Gratis' : curso.precio + ' Bs' }}</span>
                      </div>
                      <div class="flex flex-col sm:flex-row items-stretch sm:items-center gap-2 w-full">
                        <button @click="openCourseDetails(curso)" class="flex-1 text-[9px] font-black uppercase tracking-widest py-2.5 px-3 rounded-xl !border-none bg-on-surface/5 hover:bg-on-surface/10 hover:text-accent-neon transition-all text-center">Ver detalles</button>
                        <button v-if="isEnrolled(curso.id)" disabled class="btn-premium flex items-center justify-center gap-2 flex-1 !rounded-xl !px-3 !py-2.5 !text-[9px] bg-on-surface/10 text-on-surface/50 !border-none cursor-not-allowed">
                          <span class="material-symbols-outlined text-[12px]">check_circle</span>
                          Inscrito
                        </button>
                        <button v-else @click="$emit('enroll', curso.id)" class="btn-premium btn-primary-neon flex-1 text-[9px] font-black uppercase tracking-widest py-2.5 px-3 rounded-xl bg-on-surface/5 hover:bg-accent-neon hover:text-primary transition-all text-center">Inscribirme</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </section>

            <!-- Estado vacío si no hay cursos -->
            <section v-if="!ultimoCurso && inscripciones.length === 0" class="course-card-premium flex flex-col items-center justify-center p-8 sm:p-16 text-center rounded-3xl sm:rounded-[48px] !border-none bg-on-surface/5">
              <div class="mb-6 flex h-20 w-20 items-center justify-center rounded-full bg-accent-neon/10 text-accent-neon">
                <span class="material-symbols-outlined text-4xl">school</span>
              </div>
              <h2 class="font-lexend text-3xl font-black">Comienza tu viaje</h2>
              <p class="mt-4 max-w-md text-on-surface/50">Explora nuestro catálogo de cursos especializados y da el primer paso en tu formación profesional hoy mismo.</p>
              <router-link to="/student/catalog" class="btn-premium btn-primary-neon mt-10 !px-12">Ver catálogo</router-link>
            </section>
          </div>

          <!-- Sidebar Column -->
          <aside class="space-y-10">
            <!-- Welcome / Announcements -->
            <div class="course-card-premium p-5 sm:p-8 rounded-3xl sm:rounded-[40px]">
              <div class="flex h-12 w-12 items-center justify-center rounded-2xl bg-accent-neon text-primary mb-6">
                <span class="material-symbols-outlined">campaign</span>
              </div>
              <h4 class="font-lexend text-xl font-black mb-3">Anuncio <span class="text-accent-neon">Oficial</span></h4>
              <p class="text-sm text-on-surface/60 leading-relaxed">
                ¡Nueva sección de laboratorios próximamente! Prepárate para aplicar tus conocimientos en entornos reales.
              </p>
              <div class="mt-6 pt-6 border-t !border-on-surface/5 flex items-center justify-between">
                <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Hace 2 horas</span>
                <button class="text-[9px] font-black uppercase tracking-widest text-accent-neon">Saber más</button>
              </div>
            </div>

            <!-- Stats Grid in Sidebar -->
            <div class="grid grid-cols-2 gap-4">
              <div class="course-card-premium p-4 sm:p-6 rounded-2xl sm:rounded-[32px]">
                <div class="text-[9px] font-black uppercase tracking-widest text-on-surface/30 mb-3">Activos</div>
                <div class="text-3xl font-lexend font-black text-accent-neon">{{ cursosActivos.length }}</div>
                <div class="mt-2 text-[10px] font-bold text-on-surface/20 uppercase tracking-tighter">Cursos hoy</div>
              </div>
              <div class="course-card-premium p-4 sm:p-6 rounded-2xl sm:rounded-[32px]">
                <div class="text-[9px] font-black uppercase tracking-widest text-on-surface/30 mb-3">Éxito</div>
                <div class="text-3xl font-lexend font-black text-accent-solar">{{ cursosCompletados.length }}</div>
                <div class="mt-2 text-[10px] font-bold text-on-surface/20 uppercase tracking-tighter">Terminados</div>
              </div>
            </div>

            <!-- Clases en Vivo Sidebar -->
            <section v-if="liveClasses && liveClasses.length > 0" class="space-y-6">
              <div class="flex items-center justify-between px-2">
                <h3 class="font-lexend text-xl font-black">Próximas <span class="text-accent-neon">Vivos</span></h3>
                <router-link to="/student/live-classes" class="text-[9px] font-black uppercase tracking-widest text-on-surface/30 hover:text-accent-neon">Ver todos</router-link>
              </div>
              
              <div class="space-y-4">
                <div v-for="clase in liveClasses.slice(0, 3)" :key="clase.id" class="course-card-premium p-4 sm:p-5 flex flex-col gap-3 transition-all hover:bg-on-surface/[0.08] rounded-2xl sm:rounded-[28px]">
                  <div class="flex items-center justify-between">
                    <span class="text-[8px] font-black uppercase tracking-widest px-2 py-0.5 rounded bg-accent-neon/10 text-accent-neon !border-none">Clase</span>
                    <span class="text-[9px] font-bold text-on-surface/30">{{ formatDate(clase.fecha) }}</span>
                  </div>
                  <h4 class="font-lexend font-black text-sm truncate">{{ clase.titulo }}</h4>
                  <div class="flex items-center justify-between">
                    <div class="flex items-center gap-2">
                      <span class="material-symbols-outlined text-accent-neon text-base">schedule</span>
                      <span class="text-[10px] font-black text-on-surface/50">{{ formatTime(clase.fecha) }}</span>
                    </div>
                    <router-link to="/student/live-classes" class="text-[9px] font-black uppercase tracking-widest text-accent-neon">Entrar</router-link>
                  </div>
                </div>
              </div>
            </section>
            
            <!-- Quick Link Support -->
            <router-link to="/student/support" class="flex items-center justify-between p-5 sm:p-6 course-card-premium rounded-2xl sm:rounded-[32px] group overflow-hidden">
              <div class="relative z-10">
                <p class="text-[9px] font-black uppercase tracking-[0.2em] text-accent-solar mb-1">¿Necesitas ayuda?</p>
                <p class="text-sm font-black">Centro de Soporte</p>
              </div>
              <div class="relative z-10 h-10 w-10 flex items-center justify-center rounded-xl bg-accent-solar text-primary shadow-solar-sm group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined">help</span>
              </div>
              <div class="absolute -right-4 -bottom-4 h-24 w-24 rounded-full bg-accent-solar/10 blur-2xl group-hover:bg-accent-solar/20 transition-all"></div>
            </router-link>
          </aside>
        </div>
      </div>
    </div>
      
    <ModalDetalleCurso
      :isOpen="isModalOpen"
      :course="selectedCourse"
      :isEnrolled="selectedCourse ? isEnrolled(selectedCourse.id) : false"
      @close="closeCourseDetails"
      @enroll="handleModalEnroll"
    />
  </div>
</template>

<script setup>
import { computed, ref } from 'vue'
import EstudiantePageHeader from '@/components/estudiante/EstudiantePageHeader.vue'
import ModalDetalleCurso from '@/components/estudiante/ModalDetalleCurso.vue'
import { useAuthStore } from '@/stores/auth'
import { getFileUrl } from '@/config'

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

const enrolledCourseIds = computed(() => {
  return new Set(props.inscripciones.map(ins => ins.curso_id || ins.curso?.id))
})

function isEnrolled(cursoId) {
  return enrolledCourseIds.value.has(cursoId)
}

function openCourseDetails(course) {
  selectedCourse.value = course
  isModalOpen.value = true
}

function closeCourseDetails() {
  isModalOpen.value = false
  setTimeout(() => {
    selectedCourse.value = null
  }, 300) // Wait for transition
}

function handleModalEnroll(course) {
  emit('enroll', course.id)
  closeCourseDetails()
}

const cursosActivos = computed(() => {
  return props.inscripciones.filter(ins => ins.estado === 'activa')
})

const cursosCompletados = computed(() => {
  return props.inscripciones.filter(ins => ins.porcentaje_progreso >= 100)
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

