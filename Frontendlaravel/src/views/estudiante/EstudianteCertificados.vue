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

      <div v-if="loading" class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        <div v-for="i in 3" :key="i" class="h-80 rounded-[40px] course-card-premium loading-pulse"></div>
      </div>

      <div v-else-if="certificates.length === 0" class="student-empty flex flex-col items-center justify-center p-16 text-center">
        <div class="mb-6 flex h-24 w-24 items-center justify-center rounded-full bg-accent-neon/10 text-accent-neon">
          <span class="material-symbols-outlined text-5xl">workspace_premium</span>
        </div>
        <h2 class="font-lexend text-3xl font-black">Sin certificados aún</h2>
        <p class="mt-4 max-w-md text-on-surface/50">
          Completa tus cursos al cien por ciento y esta sección se convertirá en tu repositorio de diplomas listos para descargar.
        </p>
        <router-link to="/student/my-courses" class="btn-premium btn-primary-neon mt-10 !px-12">Ver mis cursos</router-link>
      </div>

      <div v-else class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        <article
          v-for="cert in certificates"
          :key="cert.id"
          class="course-card-premium group"
        >
          <div class="relative aspect-[4/3] overflow-hidden bg-on-surface/5 p-10">
            <div class="absolute inset-0 bg-gradient-to-br from-accent-neon/20 via-transparent to-accent-solar/20 opacity-50"></div>
            <span class="material-symbols-outlined absolute right-8 top-8 text-6xl text-accent-neon/10 transition-all group-hover:scale-110 group-hover:text-accent-neon/30">verified</span>
            
            <div class="relative z-10 flex h-full flex-col justify-between">
              <div>
                <p class="text-[10px] font-black uppercase tracking-[0.3em] text-accent-neon">Certificado oficial</p>
                <h3 class="mt-6 font-lexend text-2xl font-black leading-tight text-on-surface/90">{{ cert.curso?.titulo }}</h3>
              </div>
              
              <div class="rounded-2xl !border-none bg-on-surface/5 backdrop-blur-md px-6 py-4">
                <p class="text-[9px] font-black uppercase tracking-[0.3em] text-on-surface/30">Código de validación</p>
                <p class="mt-2 text-xs font-black uppercase tracking-[0.2em] text-accent-neon">{{ cert.codigo_certificado }}</p>
              </div>
            </div>
          </div>

          <div class="flex flex-1 flex-col p-8">
            <div class="mb-6 flex items-center justify-between gap-4 pb-6">
              <div class="flex flex-col">
                <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Emisión</span>
                <span class="text-sm font-bold text-on-surface/80">{{ formatDate(cert.fecha_emision) }}</span>
              </div>
              <span class="rounded-full bg-emerald-500/10 px-4 py-1.5 text-[9px] font-black uppercase tracking-widest text-emerald-400 !border-none">Aprobado</span>
            </div>

            <p class="mb-8 text-sm leading-relaxed text-on-surface/50">
              Descarga el archivo PDF y mantenlo listo para validaciones, postulaciones o respaldo personal de tu formación.
            </p>

            <button @click="downloadCertificate(cert)" class="btn-premium btn-primary-neon !w-full !py-4 !text-[11px]">
              Descargar PDF
              <span class="material-symbols-outlined text-lg">download</span>
            </button>
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
import { useNotificationStore } from '@/stores/notificationStore'

const certificates = ref([])
const loading = ref(true)
const notificationStore = useNotificationStore()

const headerStats = computed(() => [
  {
    label: 'Emitidos',
    value: loading.value ? '...' : certificates.value.length,
    help: 'Diplomas disponibles para descarga',
    icon: 'workspace_premium',
  },
  {
    label: 'Entrega',
    value: 'PDF',
    help: 'Apertura directa desde la tarjeta',
    icon: 'description',
  },
])

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

async function downloadCertificate(cert) {
  try {
    const response = await api.get(`/certificados/${cert.id}/download`, {
      responseType: 'blob',
    })
    const url = window.URL.createObjectURL(new Blob([response.data]))
    const link = document.createElement('a')
    link.href = url
    link.setAttribute('download', `Certificado-${cert.curso?.titulo || cert.id}.pdf`)
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)
  } catch (error) {
    console.error('Download error:', error)
    notificationStore.addNotification({
      title: 'Error de descarga',
      message: 'No se pudo descargar el certificado en este momento.',
      type: 'error',
    })
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
