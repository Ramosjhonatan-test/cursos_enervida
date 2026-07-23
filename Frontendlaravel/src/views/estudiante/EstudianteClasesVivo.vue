<template>
  <div class="relative min-h-screen">
    <!-- Orbes decorativos de fondo -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[500px] w-[500px] rounded-full bg-accent-neon/5 blur-[120px]"></div>
      <div class="absolute -right-[5%] top-[20%] h-[400px] w-[400px] rounded-full bg-accent-solar/5 blur-[100px]"></div>
    </div>

    <div class="relative z-10 space-y-12">
      <EstudiantePageHeader
        eyebrow="Calendario académico"
        title="Clases en"
        highlight="Vivo"
        description="Revisa rápidamente qué sesión viene, a qué curso pertenece y entra sin perder contexto."
      />

      <div v-if="loading" class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        <div v-for="i in 3" :key="i" class="h-64 rounded-[40px] course-card-premium loading-pulse"></div>
      </div>

      <div v-else-if="liveClasses.length === 0" class="student-empty flex flex-col items-center justify-center p-16 text-center">
        <div class="mb-6 flex h-24 w-24 items-center justify-center rounded-full bg-accent-neon/10 text-accent-neon">
          <span class="material-symbols-outlined text-5xl">event_busy</span>
        </div>
        <h2 class="font-lexend text-3xl font-black">Sin sesiones programadas</h2>
        <p class="mt-4 max-w-md text-on-surface/50">
          Cuando se agenden nuevas clases, aquí aparecerán con una lectura más rápida para teléfono, tablet y escritorio.
        </p>
      </div>

      <div v-else class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        <article
          v-for="clase in liveClasses"
          :key="clase.id"
          class="course-card-premium group flex flex-col p-8"
        >
          <div class="mb-8 flex items-center justify-between gap-4 pb-8">
            <div class="flex flex-col">
              <span class="text-[10px] font-black uppercase tracking-[0.3em] text-accent-neon">{{ formatDate(clase.fecha_inicio) }}</span>
              <span class="mt-1 text-sm font-bold text-on-surface/40">{{ formatTime(clase.fecha_inicio) }}</span>
            </div>
            <div class="flex h-14 w-14 items-center justify-center rounded-3xl bg-accent-neon/10 text-accent-neon shadow-inner group-hover:scale-110 transition-transform">
              <span class="material-symbols-outlined text-3xl">videocam</span>
            </div>
          </div>

          <h3 class="font-lexend text-2xl font-black leading-tight text-on-surface group-hover:text-accent-neon transition-colors">{{ clase.titulo }}</h3>
          <p class="mt-4 line-clamp-3 text-sm leading-relaxed text-on-surface/50">
            {{ clase.descripcion || 'Sesión interactiva en vivo para resolver dudas y profundizar en el contenido del curso.' }}
          </p>

          <div class="mt-10 flex items-center gap-4 rounded-3xl !border-none bg-on-surface/5 p-4 transition-colors group-hover:bg-on-surface/10">
            <div class="h-12 w-12 shrink-0 overflow-hidden rounded-2xl !border-none bg-on-surface/5 shadow-xl">
              <img :src="getImageUrl(clase.curso?.miniatura_url)" class="h-full w-full object-cover" />
            </div>
            <div class="min-w-0">
              <p class="text-[9px] font-black uppercase tracking-[0.3em] text-on-surface/30">Curso asociado</p>
              <span class="block truncate text-[11px] font-black uppercase tracking-widest text-on-surface/80">{{ clase.curso?.titulo || 'Curso' }}</span>
            </div>
          </div>

          <div class="mt-10">
            <a
            v-if="clase.url_clase || clase.sala_jitsi"
            :href="clase.url_clase || 'https://meet.jit.si/' + clase.sala_jitsi"
            target="_blank"
            class="btn-premium btn-primary-neon !w-full !py-4 !text-[11px] gap-2 shadow-neon-sm"
          >
              Unirme ahora
              <span class="material-symbols-outlined text-lg">open_in_new</span>
            </a>
            <div v-else class="rounded-3xl !border-none bg-on-surface/5 p-6 text-center">
              <span class="text-[10px] font-black uppercase tracking-widest text-on-surface/30">Link no disponible</span>
            </div>
          </div>
        </article>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, ref, onMounted } from 'vue'
import api from '@/services/api'
import EstudiantePageHeader from '@/components/estudiante/EstudiantePageHeader.vue'

const liveClasses = ref([])
const loading = ref(true)

const headerStats = computed(() => [
  {
    label: 'Sesiones',
    value: loading.value ? '...' : liveClasses.value.length,
    help: 'Programadas para tus cursos',
    icon: 'calendar_month',
  },
  {
    label: 'Acceso',
    value: '1 clic',
    help: 'Entrada directa desde cada tarjeta',
    icon: 'rocket_launch',
  },
])

onMounted(async () => {
  try {
    const response = await api.get('/clases-en-vivo')
    liveClasses.value = response.data
  } catch (error) {
    console.warn('Error loading live classes:', error)
  } finally {
    loading.value = false
  }
})

function getImageUrl(url) {
  if (!url) return null
  const value = String(url).trim().replaceAll('\\', '/')
  if (!value) return null
  if (value.startsWith('http')) return value
  const baseUrl = (import.meta.env.VITE_API_URL || 'http://localhost:3000').replace(/\/$/, '')
  return `${baseUrl}${value.startsWith('/') ? value : '/' + value}`
}

function formatDate(value) {
  if (!value) return 'Sin fecha'
  return new Date(value).toLocaleDateString('es-BO', {
    day: '2-digit',
    month: 'long',
    year: 'numeric',
  })
}

function formatTime(value) {
  if (!value) return ''
  return new Date(value).toLocaleTimeString('es-BO', {
    hour: '2-digit',
    minute: '2-digit',
  })
}
</script>
