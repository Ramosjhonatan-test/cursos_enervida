<template>
  <div class="relative min-h-screen">
    <!-- Orbes decorativos de fondo -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[500px] w-[500px] rounded-full bg-accent-neon/5 blur-[120px]"></div>
      <div class="absolute -right-[5%] top-[20%] h-[400px] w-[400px] rounded-full bg-accent-solar/5 blur-[100px]"></div>
    </div>

    <div class="relative z-10 space-y-12">
      <EstudiantePageHeader
        eyebrow="Logros académicos"
        title="Mis"
        highlight="Certificados"
        description="Mantiene visibles tus certificados aprobados y deja la descarga a un paso, también desde móvil."
      />

      <!-- Estados de carga Skeleton -->
      <div v-if="loading" class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        <div v-for="i in 3" :key="i" class="h-80 rounded-[30px] bg-gray-200/50 dark:bg-white/5 animate-pulse border border-gray-300/40 dark:border-white/10"></div>
      </div>

      <!-- Estado vacío -->
      <div v-else-if="certificates.length === 0" class="glass-card-premium flex flex-col items-center justify-center p-16 text-center rounded-[30px] bg-white dark:bg-surface border border-gray-200 dark:border-white/10 shadow-xl">
        <div class="mb-6 flex h-24 w-24 items-center justify-center rounded-2xl bg-accent-neon/10 border border-accent-neon/20 text-accent-neon shadow-lg shadow-accent-neon/5">
          <span class="material-symbols-outlined text-5xl font-black">workspace_premium</span>
        </div>
        <h2 class="font-lexend text-2xl font-black text-gray-900 dark:text-white">Sin certificados aún</h2>
        <p class="mt-3 max-w-md text-xs uppercase tracking-wider text-gray-500 dark:text-white/50 font-bold">
          Completa tus cursos al cien por ciento y esta sección se convertirá en tu repositorio de diplomas listos para descargar.
        </p>
        <router-link to="/student/my-courses" class="mt-8 px-8 py-3.5 rounded-xl bg-accent-neon text-gray-950 font-black text-xs uppercase tracking-widest shadow-lg hover:shadow-accent-neon/30 hover:-translate-y-0.5 active:scale-95 transition-all flex items-center gap-2">
          Ver mis cursos
          <span class="material-symbols-outlined text-base">arrow_forward</span>
        </router-link>
      </div>

      <!-- Listado de certificados -->
      <div v-else class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        <article
          v-for="cert in certificates"
          :key="cert.id"
          class="glass-card-premium group flex flex-col justify-between overflow-hidden rounded-[30px] bg-white dark:bg-surface border border-gray-200 dark:border-white/10 shadow-xl transition-all duration-300 hover:border-accent-neon/40 hover:shadow-2xl hover:shadow-accent-neon/5"
        >
          <!-- Encabezado de la Tarjeta -->
          <div class="relative overflow-hidden bg-gray-100 dark:bg-white/5 p-8 border-b border-gray-200 dark:border-white/10">
            <div class="absolute inset-0 bg-gradient-to-br from-accent-neon/10 via-transparent to-accent-solar/10 opacity-50"></div>
            <span class="material-symbols-outlined absolute right-6 top-6 text-5xl text-accent-neon/20 transition-all duration-300 group-hover:scale-110 group-hover:text-accent-neon/40">verified</span>
            
            <div class="relative z-10 flex flex-col gap-4">
              <div>
                <p class="text-[9px] font-black uppercase tracking-[0.3em] text-accent-neon">Certificado oficial</p>
                <h3 class="mt-3 font-lexend text-lg font-black leading-snug text-gray-900 dark:text-white line-clamp-2">
                  {{ cert.curso?.titulo || 'Curso de Especialización' }}
                </h3>
              </div>
              
              <!-- Código de Validación con Botón de Copiar -->
              <div class="flex items-center justify-between rounded-xl bg-gray-200/60 dark:bg-white/10 border border-gray-300/40 dark:border-white/10 px-4 py-2.5">
                <div>
                  <p class="text-[8px] font-black uppercase tracking-[0.2em] text-gray-400 dark:text-white/40">Código único</p>
                  <p class="mt-0.5 text-xs font-black uppercase tracking-widest text-gray-800 dark:text-white font-mono">{{ cert.codigo_certificado }}</p>
                </div>
                <button 
                  @click="copyCode(cert.codigo_certificado)" 
                  title="Copiar código"
                  class="flex h-8 w-8 items-center justify-center rounded-lg bg-white dark:bg-white/10 border border-gray-300/50 dark:border-white/10 text-gray-600 dark:text-white/70 hover:text-accent-neon hover:border-accent-neon/40 transition-all cursor-pointer"
                >
                  <span class="material-symbols-outlined text-sm">content_copy</span>
                </button>
              </div>
            </div>
          </div>

          <!-- Cuerpo e Información Inferior -->
          <div class="flex flex-1 flex-col justify-between p-6 gap-6">
            <div class="flex items-center justify-between gap-4">
              <div class="flex flex-col">
                <span class="text-[9px] font-black uppercase tracking-widest text-gray-400 dark:text-white/40">Fecha de Emisión</span>
                <span class="text-xs font-bold text-gray-700 dark:text-white/80 mt-0.5">{{ formatDate(cert.fecha_emision) }}</span>
              </div>
              <span class="rounded-full bg-emerald-500/10 border border-emerald-500/20 px-3.5 py-1 text-[9px] font-black uppercase tracking-widest text-emerald-500 flex items-center gap-1">
                <span class="h-1.5 w-1.5 rounded-full bg-emerald-500"></span>
                Aprobado
              </span>
            </div>

            <p class="text-xs leading-relaxed text-gray-500 dark:text-white/60 font-medium">
              Documento oficial listo para respaldo profesional, validaciones de currículum o postulaciones laborales.
            </p>

            <button 
              @click="downloadCertificate(cert)" 
              :disabled="downloadingId === cert.id"
              class="w-full py-3.5 rounded-xl bg-accent-neon text-gray-950 font-black text-xs uppercase tracking-widest shadow-lg hover:shadow-accent-neon/30 hover:-translate-y-0.5 active:scale-95 transition-all flex items-center justify-center gap-2 cursor-pointer disabled:opacity-50"
            >
              <span class="material-symbols-outlined text-base">
                {{ downloadingId === cert.id ? 'hourglass_empty' : 'download' }}
              </span>
              {{ downloadingId === cert.id ? 'Generando PDF...' : 'Descargar PDF' }}
            </button>
          </div>
        </article>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '@/services/api'
import EstudiantePageHeader from '@/components/estudiante/EstudiantePageHeader.vue'
import { useNotificationStore } from '@/stores/notificationStore'

const certificates = ref([])
const loading = ref(true)
const downloadingId = ref(null)
const notificationStore = useNotificationStore()

onMounted(async () => {
  try {
    const response = await api.get('/certificados/me')
    certificates.value = response.data
  } catch (error) {
    console.warn('Error loading certificates:', error)
  } finally {
    loading.value = false
  }
})

const copyCode = (code) => {
  navigator.clipboard.writeText(code)
  notificationStore.addNotification({
    title: 'Código copiado',
    message: `El código ${code} se copió al portapapeles.`,
    type: 'success'
  })
}

async function downloadCertificate(cert) {
  if (downloadingId.value) return
  downloadingId.value = cert.id
  
  try {
    const response = await api.get(`/certificados/${cert.id}/download`, {
      responseType: 'blob',
    })
    const url = window.URL.createObjectURL(new Blob([response.data], { type: 'application/pdf' }))
    const link = document.createElement('a')
    link.href = url
    link.setAttribute('download', `Certificado-${cert.curso?.titulo || cert.id}.pdf`)
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
    setTimeout(() => window.URL.revokeObjectURL(url), 5000)
  } catch (error) {
    console.error('Download error:', error)
    notificationStore.addNotification({
      title: 'Error de descarga',
      message: 'No se pudo descargar el certificado en este momento.',
      type: 'error',
    })
  } finally {
    downloadingId.value = null
  }
}

function formatDate(value) {
  if (!value) return 'Sin fecha'
  return new Date(value).toLocaleDateString('es-BO', {
    day: '2-digit',
    month: 'short',
    year: 'numeric',
  })
}
</script>