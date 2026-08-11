<template>
  <div 
    :class="[
      'min-h-screen bg-background text-on-surface transition-colors duration-300 relative',
      showExamModal ? 'overflow-hidden h-screen' : ''
    ]"
  >
    
    <!-- Toast / Notificación Flotante -->
    <transition name="fade">
      <div 
        v-if="notification.show" 
        :class="[
          'fixed top-6 right-6 z-[110] flex items-center gap-3 rounded-2xl px-5 py-3.5 shadow-2xl backdrop-blur-xl transition-all duration-300 !border-none text-xs font-bold tracking-wide',
          notification.type === 'success' ? 'bg-accent-neon/20 text-accent-neon shadow-accent-neon/10' : '',
          notification.type === 'error' ? 'bg-red-500/20 text-red-400 shadow-red-500/10' : '',
          notification.type === 'info' ? 'bg-surface/90 text-on-surface shadow-black/20' : ''
        ]"
      >
        <span class="material-symbols-outlined text-base">
          {{ notification.type === 'success' ? 'check_circle' : notification.type === 'error' ? 'error' : 'info' }}
        </span>
        <span>{{ notification.message }}</span>
      </div>
    </transition>

    <!-- Overlay Móvil para Sidebar -->
    <transition name="fade">
      <div
        v-if="isSidebarOpen"
        class="fixed inset-0 z-40 bg-background/80 backdrop-blur-xl lg:hidden"
        @click="isSidebarOpen = false"
      ></div>
    </transition>

    <div class="flex min-h-screen">
      <!-- Sidebar de Navegación de Lecciones -->
      <aside
        :class="[
          'fixed inset-y-0 left-0 z-50 flex w-[88vw] max-w-sm flex-col bg-surface/95 backdrop-blur-2xl transition-transform duration-300 lg:sticky lg:top-0 lg:h-screen lg:w-[360px] lg:max-w-none lg:translate-x-0 !border-none',
          isSidebarOpen ? 'translate-x-0' : '-translate-x-full'
        ]"
      >
        <!-- Header del Sidebar -->
        <div class="p-6 relative">
          <div class="mb-6 flex items-center justify-between gap-4">
            <router-link to="/student/dashboard" class="flex items-center gap-3 text-accent-neon transition hover:gap-4">
              <span class="material-symbols-outlined text-sm font-black">arrow_back</span>
              <span class="text-[10px] font-black uppercase tracking-[0.3em]">Volver al portal</span>
            </router-link>
            <button
              type="button"
              class="grid h-10 w-10 place-items-center rounded-2xl bg-on-surface/5 text-on-surface/60 lg:hidden !border-none hover:text-on-surface transition-colors cursor-pointer"
              @click="isSidebarOpen = false"
            >
              <span class="material-symbols-outlined">close</span>
            </button>
          </div>

          <h2 class="line-clamp-2 font-lexend text-xl font-black tracking-tight text-on-surface">{{ curso?.titulo }}</h2>
          <p class="mt-2 text-[9px] font-black uppercase tracking-[0.2em] text-on-surface/40">Curso certificado</p>

          <!-- Barra de Progreso del Curso -->
          <div class="mt-6 space-y-2">
            <div class="flex items-end justify-between">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/50">Tu progreso</span>
              <span class="text-sm font-black text-accent-neon">{{ Math.round(progresoGeneral) }}%</span>
            </div>
            <div class="h-2 overflow-hidden rounded-full bg-on-surface/10 !border-none">
              <div 
                class="h-full bg-accent-neon shadow-[0_0_12px_var(--accent-neon)] transition-all duration-1000" 
                :style="{ width: progresoGeneral + '%' }"
              ></div>
            </div>
          </div>
        </div>

        <!-- Módulos y Lecciones Listado -->
        <div class="custom-scrollbar flex-1 space-y-4 overflow-y-auto p-4">
          <div v-for="(modulo, mIdx) in curso?.modulos" :key="modulo.id" class="space-y-2">
            <!-- Título del Módulo -->
            <div class="flex items-center gap-3 px-3 py-2 rounded-xl bg-on-surface/[0.02]">
              <span class="text-[10px] font-black uppercase tracking-widest text-accent-solar">Módulo {{ mIdx + 1 }}</span>
              <span v-if="isModuloBloqueado(mIdx)" class="material-symbols-outlined text-[14px] text-red-400" title="Debes completar el módulo anterior">lock</span>
            </div>
            <h3 :class="['px-3 text-xs font-black uppercase tracking-widest leading-snug', isModuloBloqueado(mIdx) ? 'text-on-surface/30' : 'text-on-surface/80']">
              {{ modulo.titulo }}
            </h3>

            <!-- Botones de Lecciones -->
            <div class="space-y-1.5 pt-1">
              <button
                v-for="leccion in modulo.lecciones"
                :key="leccion.id"
                type="button"
                @click="!isModuloBloqueado(mIdx) && selectLeccion(leccion)"
                :disabled="isModuloBloqueado(mIdx)"
                :aria-current="activeLeccion?.id === leccion.id ? 'true' : undefined"
                :class="[
                  'w-full rounded-2xl px-3.5 py-3 text-left transition-all duration-200 focus-visible:outline-none !border-none cursor-pointer',
                  activeLeccion?.id === leccion.id 
                    ? 'bg-accent-neon/10 text-accent-neon shadow-sm' 
                    : 'bg-on-surface/[0.03] hover:bg-on-surface/[0.08] text-on-surface/70',
                  isModuloBloqueado(mIdx) ? 'opacity-40 cursor-not-allowed hover:bg-on-surface/[0.03]' : ''
                ]"
              >
                <div class="flex items-start gap-3">
                  <div
                    :class="[
                      'mt-0.5 flex h-9 w-9 shrink-0 items-center justify-center rounded-xl transition-colors !border-none',
                      leccionCompletada(leccion.id) 
                        ? 'bg-accent-neon text-primary' 
                        : (activeLeccion?.id === leccion.id ? 'bg-accent-neon/20 text-accent-neon' : 'bg-on-surface/10 text-on-surface/50')
                    ]"
                  >
                    <span class="material-symbols-outlined text-sm font-black">
                      {{ leccionCompletada(leccion.id) ? 'check' : getIcon(leccion.tipo_contenido) }}
                    </span>
                  </div>
                  <div class="min-w-0 flex-1">
                    <div class="flex items-center justify-between gap-2">
                      <p :class="['line-clamp-2 text-sm font-bold leading-snug transition-colors', activeLeccion?.id === leccion.id ? 'text-accent-neon' : 'text-on-surface/90']">
                        {{ leccion.titulo }}
                      </p>
                      <!-- Badge Reproduciendo -->
                      <span v-if="activeLeccion?.id === leccion.id" class="flex h-2 w-2 shrink-0 rounded-full bg-accent-neon animate-ping" title="Reproduciendo"></span>
                    </div>
                    <p class="mt-1 text-[9px] font-black uppercase tracking-wider text-on-surface/40">
                      {{ leccion.tipo_contenido }}
                    </p>
                  </div>
                </div>
              </button>
            </div>
          </div>
        </div>
      </aside>

      <!-- Contenido Principal -->
      <main class="flex min-w-0 flex-1 flex-col">
        <!-- Top Navbar Stickied -->
        <header class="sticky top-0 z-30 bg-background/90 px-4 py-4 backdrop-blur-xl md:px-6 lg:px-10 !border-none">
          <div class="flex flex-col gap-4 md:flex-row md:items-center md:justify-between relative z-10">
            <div class="flex min-w-0 items-center gap-3">
              <button 
                @click="isSidebarOpen = !isSidebarOpen" 
                class="flex h-11 w-11 shrink-0 items-center justify-center rounded-2xl bg-on-surface/5 text-on-surface/70 hover:text-accent-neon transition-all !border-none cursor-pointer"
              >
                <span class="material-symbols-outlined">{{ isSidebarOpen ? 'menu_open' : 'menu' }}</span>
              </button>
              <div class="min-w-0">
                <p class="text-[9px] font-black uppercase tracking-[0.2em] text-accent-neon">{{ curso?.categoria?.nombre || 'Curso' }}</p>
                <h1 class="truncate text-sm font-black uppercase tracking-widest md:text-base text-on-surface">{{ activeLeccion?.titulo || 'Cargando curso...' }}</h1>
              </div>
            </div>

            <div class="flex items-center justify-between gap-3 md:justify-end">
              <div class="rounded-2xl !border-none bg-on-surface/[0.05] px-4 py-2">
                <p class="text-[9px] font-black uppercase tracking-[0.2em] text-on-surface/40">Avance</p>
                <p class="text-sm font-black text-accent-neon">{{ Math.round(progresoGeneral) }}%</p>
              </div>
              <div class="flex items-center gap-2">
                <button 
                  @click="prevLeccion" 
                  :disabled="!hasPrev" 
                  class="flex h-10 w-10 items-center justify-center rounded-xl bg-on-surface/5 text-on-surface/70 transition-all hover:text-accent-neon disabled:opacity-20 !border-none cursor-pointer"
                >
                  <span class="material-symbols-outlined">navigate_before</span>
                </button>
                <button 
                  @click="nextLeccion" 
                  :disabled="!hasNext" 
                  class="flex h-10 w-10 items-center justify-center rounded-xl bg-on-surface/5 text-on-surface/70 transition-all hover:text-accent-neon disabled:opacity-20 !border-none cursor-pointer"
                >
                  <span class="material-symbols-outlined">navigate_next</span>
                </button>
              </div>
            </div>
          </div>
        </header>

        <!-- Área de Reproducción / Visualización -->
        <div class="custom-scrollbar flex-1 overflow-y-auto bg-background">
          <!-- Spinner Loading -->
          <div v-if="loading" class="flex h-full min-h-[60vh] flex-col items-center justify-center gap-6 p-6">
            <div class="h-16 w-16 animate-spin rounded-full border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)]"></div>
            <p class="text-[10px] font-black uppercase tracking-[0.4em] text-accent-neon">Cargando contenido...</p>
          </div>

          <div v-else-if="activeLeccion" class="mx-auto flex w-full max-w-6xl flex-col gap-6 p-4 md:p-6 lg:p-8">
            <div class="flex flex-col lg:flex-row gap-6">
              
              <!-- Visor según Tipo de Contenido -->
              <div class="flex-1 w-full flex flex-col gap-6">
                
                <!-- 1. VIDEO Container -->
                <div v-if="activeLeccion.tipo_contenido === 'VIDEO'" class="aspect-video w-full overflow-hidden rounded-[32px] !border-none bg-black shadow-2xl relative group">
                  <iframe
                    v-if="isYoutube(activeLeccion.video_url)"
                    :src="getYoutubeEmbed(activeLeccion.video_url)"
                    class="h-full w-full absolute inset-0"
                    frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen
                  ></iframe>
                  <video v-else-if="activeLeccion.video_url" :src="getFileUrl(activeLeccion.video_url)" controls class="h-full w-full object-cover absolute inset-0"></video>
                  <div v-else class="flex h-full items-center justify-center text-on-surface/30">
                    <p class="text-xs font-black uppercase tracking-widest">Video no disponible</p>
                  </div>
                </div>

                <!-- 2. PDF Container -->
                <div v-else-if="activeLeccion.tipo_contenido === 'PDF'" class="w-full flex flex-col gap-4">
                  <!-- Pantalla Grande: Visor Iframe incorporado -->
                  <div class="hidden lg:block h-[68vh] min-h-[460px] w-full overflow-hidden rounded-[32px] !border-none bg-on-surface/[0.03] shadow-lg">
                    <iframe :src="getFileUrl(activeLeccion.pdf_url)" class="h-full w-full" frameborder="0"></iframe>
                  </div>
                  
                  <!-- Móvil/Tablet: Tarjeta Limpia de Lectura -->
                  <div class="lg:hidden rounded-[32px] p-8 text-center flex flex-col items-center justify-center !border-none bg-on-surface/[0.03] py-12">
                    <div class="mb-5 flex h-16 w-16 items-center justify-center rounded-2xl bg-accent-neon/10 text-accent-neon !border-none shadow-inner">
                      <span class="material-symbols-outlined text-3xl font-black">picture_as_pdf</span>
                    </div>
                    <h3 class="font-lexend text-lg font-black mb-2 text-on-surface">Documento de Lectura</h3>
                    <p class="text-xs text-on-surface/60 max-w-xs mb-6 leading-relaxed">
                      Para una lectura óptima y fluida en tu dispositivo, abre este PDF en pantalla completa.
                    </p>
                    <a :href="getFileUrl(activeLeccion.pdf_url)" target="_blank" class="btn-premium btn-primary-neon !px-8 !py-4 gap-2 text-xs w-full sm:w-auto inline-flex justify-center items-center shadow-neon-sm !border-none">
                      <span class="material-symbols-outlined text-base">open_in_new</span>
                      Abrir en pantalla completa
                    </a>
                  </div>
                </div>

                <!-- 3. TEXTO Container -->
                <div v-else-if="activeLeccion.tipo_contenido === 'TEXTO'" class="course-card-premium rounded-[32px] p-6 md:p-10 !border-none bg-on-surface/[0.03]">
                  <div class="prose max-w-none prose-headings:text-on-surface prose-p:text-on-surface/80 prose-a:text-accent-neon text-on-surface/80 leading-relaxed" v-html="activeLeccion.descripcion || activeLeccion.contenido"></div>
                </div>

              </div>
            </div>

            <!-- Información y Acción de la Lección -->
            <div class="course-card-premium rounded-[32px] p-6 md:p-8 flex flex-col md:flex-row items-start md:items-center justify-between gap-6 !border-none bg-on-surface/[0.03]">
              <div class="flex-1 min-w-0">
                <div class="flex items-center gap-3 mb-2">
                  <span class="px-3 py-1 text-[10px] font-black uppercase tracking-[0.2em] rounded-full bg-accent-neon/10 text-accent-neon !border-none">
                    {{ activeLeccion.tipo_contenido }}
                  </span>
                  <p class="text-[10px] font-black uppercase tracking-[0.2em] text-on-surface/40">Lección activa</p>
                </div>
                <h2 class="font-lexend text-2xl font-black tracking-tight text-on-surface line-clamp-2">{{ activeLeccion.titulo }}</h2>
                <p v-if="curso?.instructor" class="mt-2 text-sm font-medium text-on-surface/60 flex items-center gap-2">
                  <span class="material-symbols-outlined text-sm">person</span>
                  Instructor: <span class="text-on-surface/90 font-bold">{{ curso.instructor.nombres }} {{ curso.instructor.apellidos }}</span>
                </p>
              </div>

              <div class="shrink-0 w-full md:w-auto flex flex-col sm:flex-row gap-3">
                <button
                  @click="toggleComplete"
                  :disabled="marking"
                  :class="[
                    'btn-premium !w-full md:!w-auto !justify-center !px-6 !py-3.5 gap-2.5 transition-all duration-300 !border-none cursor-pointer',
                    leccionCompletada(activeLeccion.id) 
                      ? 'bg-accent-neon/10 text-accent-neon shadow-[0_0_15px_rgba(16,185,129,0.15)]' 
                      : 'btn-primary-neon shadow-lg'
                  ]"
                >
                  <span class="material-symbols-outlined text-[18px] font-black">
                    {{ leccionCompletada(activeLeccion.id) ? 'check_circle' : 'task_alt' }}
                  </span>
                  {{ leccionCompletada(activeLeccion.id) ? 'Completado' : 'Marcar completado' }}
                </button>
              </div>
            </div>

            <!-- Descripción Detallada (Para VIDEO o PDF) -->
            <div v-if="activeLeccion.descripcion && activeLeccion.tipo_contenido !== 'TEXTO'" class="course-card-premium rounded-[32px] p-6 md:p-8 lg:p-10 !border-none bg-on-surface/[0.03]">
              <h3 class="text-sm font-black uppercase tracking-widest text-on-surface/80 mb-6 flex items-center gap-2">
                <span class="material-symbols-outlined text-accent-neon">info</span>
                Acerca de esta lección
              </h3>
              <div class="prose max-w-none prose-headings:text-on-surface prose-p:text-on-surface/70 prose-a:text-accent-neon prose-strong:text-on-surface text-on-surface/80 leading-relaxed" v-html="activeLeccion.descripcion"></div>
            </div>

            <!-- CTA de Evaluación Final (Visualización al 100%) -->
            <div v-if="curso?.evaluaciones?.length > 0 && Math.round(progresoGeneral) === 100 && !hasTakenExam" class="mt-4 course-card-premium relative overflow-hidden rounded-[32px] p-8 md:p-12 text-center !border-none bg-on-surface/[0.05]">
              <div class="pointer-events-none absolute inset-0 -z-10 bg-[radial-gradient(circle_at_center,_var(--accent-neon)_0%,_transparent_70%)] opacity-10"></div>
              <div class="relative z-10 flex flex-col items-center">
                <div class="mb-6 flex h-20 w-20 items-center justify-center rounded-[24px] bg-accent-neon/10 text-accent-neon !border-none">
                  <span class="material-symbols-outlined text-4xl font-black">workspace_premium</span>
                </div>
                <h3 class="font-lexend text-2xl md:text-3xl font-black tracking-tight text-on-surface mb-3">¡Has completado el contenido!</h3>
                <p class="text-sm text-on-surface/60 max-w-lg mx-auto mb-8">
                  Estás listo para tomar la evaluación final de este curso. Asegúrate de tener buena conexión a internet y tiempo disponible.
                </p>
                <button @click="showExamModal = true" class="btn-premium btn-primary-neon !px-10 !py-4 gap-3 text-sm !border-none cursor-pointer">
                  <span class="material-symbols-outlined text-lg">assignment</span>
                  Iniciar Evaluación Final
                </button>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>

    <!-- Modal de Confirmación de Evaluación -->
    <Teleport to="body">
      <transition name="fade">
        <div 
          v-if="showExamModal" 
          class="fixed inset-0 z-[200] flex items-center justify-center bg-[#0b132b]/60 backdrop-blur-md p-4 overflow-y-auto"
          @click.self="showExamModal = false"
        >
          <div class="glass-card-premium relative w-full max-w-lg overflow-hidden rounded-[32px] p-8 md:p-10 text-center !border-none shadow-[0_10px_40px_-10px_rgba(16,185,129,0.2)] bg-on-surface/5 text-on-surface animate-fade-in">
            
            <!-- Radial Gradient original -->
            <div class="pointer-events-none absolute inset-0 -z-10 bg-[radial-gradient(circle_at_center,_var(--accent-neon)_0%,_transparent_70%)] opacity-5"></div>

            <div class="relative z-10 flex flex-col items-center">
              <div class="mb-6 flex h-20 w-20 items-center justify-center rounded-[24px] bg-accent-neon/10 text-accent-neon !border-none">
                <span class="material-symbols-outlined text-4xl font-black">workspace_premium</span>
              </div>

              <h3 class="font-lexend text-2xl md:text-3xl font-black tracking-tight text-on-surface mb-3">
                ¡Has completado el curso!
              </h3>

              <p class="text-sm text-on-surface/60 max-w-lg mx-auto mb-8">
                Estás listo para tomar la evaluación final de este curso. Asegúrate de tener buena conexión a internet y tiempo disponible.
              </p>

              <div class="flex flex-col sm:flex-row gap-4 justify-center items-center w-full">
                <button 
                  type="button" 
                  @click="showExamModal = false" 
                  class="w-full sm:w-auto flex items-center justify-center gap-2 py-3.5 px-6 text-[11px] font-black uppercase tracking-widest text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-2xl transition-all duration-200 cursor-pointer !border-none"
                >
                  <span class="material-symbols-outlined text-base">schedule</span>
                  Realizar más tarde
                </button>

                <router-link 
                  :to="'/student/exam/' + curso?.evaluaciones?.[0]?.id" 
                  class="w-full sm:w-auto btn-premium btn-primary-neon !px-8 !py-3.5 gap-2 text-xs rounded-2xl inline-flex items-center justify-center font-black uppercase tracking-wider"
                >
                  <span class="material-symbols-outlined text-lg">assignment</span>
                  Iniciar Evaluación
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </transition>
    </Teleport>

  </div>
</template>
<script setup>
import { ref, onMounted, computed, nextTick } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '@/services/api'
import { getFileUrl } from '@/config'
import { useAuthStore } from '@/stores/auth'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

// Estados Reactivos
const curso = ref(null)
const activeLeccion = ref(null)
const loading = ref(true)
const marking = ref(false)
const isSidebarOpen = ref(false)
const completadas = ref([])
const showExamModal = ref(false)
const userIntentos = ref([])
const notification = ref({ show: false, message: '', type: 'info' })

// Mapeo de Completitud
const leccionCompletada = (id) => completadas.value.includes(id)

// Notificaciones temporales de UI (Toast)
const showToast = (message, type = 'info', duration = 3000) => {
  notification.value = { show: true, message, type }
  setTimeout(() => {
    notification.value.show = false
  }, duration)
}

// Verificación de intento previo de examen
const hasTakenExam = computed(() => {
  if (!curso.value?.evaluaciones?.length) return false
  const evalIds = curso.value.evaluaciones.map((e) => e.id)
  return userIntentos.value.some((i) => evalIds.includes(i.evaluacion_id))
})

// Carga Inicial de Datos del Curso, Progreso e Intentos
const fetchCourseData = async () => {
  loading.value = true
  try {
    const [cursoRes, progresoRes, intentosRes] = await Promise.all([
      api.get(`/cursos/${route.params.id}`),
      api.get('/progreso'),
      api.get('/intentos-evaluacion').catch(() => ({ data: [] }))
    ])

    curso.value = cursoRes.data
    completadas.value = (progresoRes.data || []).map((p) => p.leccion_id)
    userIntentos.value = (intentosRes.data || []).filter((i) => i.usuario_id === authStore.user?.id)

    if (!curso.value) {
      router.replace('/student/my-courses')
      return
    }

    if (hasTakenExam.value) {
      router.push('/student/my-courses')
      return
    }

    // Seleccionar la primera lección no completada o la primera por defecto
    if (leccionesList.value.length > 0) {
      const primeraIncompleta = leccionesList.value.find((l) => !leccionCompletada(l.id))
      activeLeccion.value = primeraIncompleta || leccionesList.value[0]
    }

    isSidebarOpen.value = window.innerWidth >= 1024
  } catch (error) {
    if (error?.response?.status === 403 || error?.response?.status === 404) {
      router.replace('/student/my-courses')
      return
    }
  } finally {
    loading.value = false
    await nextTick()
    
    // Si ya tiene 100% de avance al entrar, sugerir la evaluación
    if (Math.round(progresoGeneral.value) === 100 && curso.value?.evaluaciones?.length > 0 && !hasTakenExam.value) {
      showExamModal.value = true
    }
  }
}

// Aplanado de todas las lecciones del curso
const leccionesList = computed(() => {
  if (!curso.value?.modulos) return []
  return curso.value.modulos.flatMap((m) => m.lecciones || [])
})

// Índice de la Lección Actual
const currentLeccionIdx = computed(() => {
  if (!activeLeccion.value) return -1
  return leccionesList.value.findIndex((l) => l.id === activeLeccion.value.id)
})

// Bloqueo Progresivo de Módulos (Requiere completar todas las lecciones del módulo anterior)
const isModuloBloqueado = (mIdx) => {
  if (mIdx === 0) return false
  if (!curso.value?.modulos) return false

  for (let i = 0; i < mIdx; i++) {
    const mod = curso.value.modulos[i]
    if (mod?.lecciones) {
      const allCompleted = mod.lecciones.every((l) => leccionCompletada(l.id))
      if (!allCompleted) return true
    }
  }
  return false
}

// Control de Navegación (Siguiente / Anterior)
const hasNext = computed(() => {
  if (currentLeccionIdx.value < 0 || currentLeccionIdx.value >= leccionesList.value.length - 1) return false
  const nextLecc = leccionesList.value[currentLeccionIdx.value + 1]
  const moduloIdx = curso.value.modulos.findIndex((m) => m.lecciones?.some((l) => l.id === nextLecc.id))
  if (moduloIdx > -1 && isModuloBloqueado(moduloIdx)) return false
  return true
})

const hasPrev = computed(() => currentLeccionIdx.value > 0)

// Cálculo Porcentual Global del Curso
const progresoGeneral = computed(() => {
  if (!leccionesList.value.length) return 0
  const completadasEnCurso = leccionesList.value.filter((l) => leccionCompletada(l.id)).length
  return (completadasEnCurso / leccionesList.value.length) * 100
})

// Selección Manual de Lección
const selectLeccion = (leccion) => {
  activeLeccion.value = leccion
  if (window.innerWidth < 1024) isSidebarOpen.value = false
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

const nextLeccion = () => {
  if (hasNext.value) {
    selectLeccion(leccionesList.value[currentLeccionIdx.value + 1])
  }
}

const prevLeccion = () => {
  if (hasPrev.value) {
    selectLeccion(leccionesList.value[currentLeccionIdx.value - 1])
  }
}

// Acción de Completar / Desmarcar Lección
const toggleComplete = async () => {
  if (!activeLeccion.value || marking.value) return

  const isComp = leccionCompletada(activeLeccion.value.id)
  marking.value = true

  try {
    if (!isComp) {
      await api.post('/progreso', {
        usuario_id: authStore.user.id,
        leccion_id: activeLeccion.value.id,
        completado: true
      })
      completadas.value.push(activeLeccion.value.id)
      showToast('Lección completada exitosamente', 'success')

      if (Math.round(progresoGeneral.value) === 100 && curso.value?.evaluaciones?.length > 0 && !hasTakenExam.value) {
        setTimeout(() => {
          showExamModal.value = true
        }, 800)
      } else if (hasNext.value) {
        setTimeout(nextLeccion, 1000)
      }
    }
  } catch (error) {
    showToast('Error al actualizar el progreso', 'error')
  } finally {
    marking.value = false
  }
}

// Utilidades para Íconos e Integración con YouTube
const getIcon = (tipo) => {
  switch (tipo?.toUpperCase()) {
    case 'VIDEO':
      return 'play_circle'
    case 'PDF':
      return 'description'
    case 'TEXTO':
      return 'article'
    case 'QUIZ':
    case 'EVALUACION':
      return 'quiz'
    case 'RECURSO':
      return 'folder_zip'
    default:
      return 'play_arrow'
  }
}

const isYoutube = (url) => {
  if (!url) return false
  return url.includes('youtube.com') || url.includes('youtu.be')
}

const getYoutubeEmbed = (url) => {
  if (!url) return ''
  let id = ''
  if (url.includes('v=')) {
    id = url.split('v=')[1].split('&')[0]
  } else if (url.includes('youtu.be/')) {
    id = url.split('youtu.be/')[1].split('?')[0]
  } else if (url.includes('embed/')) {
    id = url.split('embed/')[1].split('?')[0]
  }
  return `https://www.youtube.com/embed/${id}?rel=0&modestbranding=1`
}

onMounted(() => {
  fetchCourseData()
})
</script>

<style scoped>
.custom-scrollbar::-webkit-scrollbar {
  width: 4px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(16, 185, 129, 0.16);
  border-radius: 10px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: rgba(16, 185, 129, 0.3);
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>