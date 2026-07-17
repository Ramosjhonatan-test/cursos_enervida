<template>
  <div class="relative min-h-screen flex items-center justify-center p-4 bg-background overflow-hidden font-inter text-on-surface">
    <!-- Orbes decorativos de fondo con brillos y desenfoque -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[500px] w-[500px] rounded-full bg-accent-neon/5 blur-[120px]"></div>
      <div class="absolute -right-[5%] top-[20%] h-[400px] w-[400px] rounded-full bg-accent-solar/5 blur-[100px]"></div>
      <div class="absolute left-[30%] bottom-[-10%] h-[350px] w-[350px] rounded-full bg-primary/5 blur-[90px]"></div>
    </div>

    <!-- Contenedor Principal (Glassmorphism) -->
    <div class="relative z-10 w-full max-w-2xl glass-card-premium rounded-[48px] p-8 md:p-12 shadow-[0_20px_50px_rgba(0,0,0,0.3)] animate-in fade-in zoom-in-95 duration-500">
      
      <!-- Logo o Nombre de la Academia -->
      <div class="flex justify-center mb-8">
        <div class="px-6 py-2.5 rounded-2xl bg-on-surface/5 backdrop-blur-md flex items-center gap-2">
          <span class="material-symbols-outlined text-accent-neon text-xl font-black">school</span>
          <span class="font-lexend text-xs font-black uppercase tracking-[0.25em] text-on-surface/80">Campus Enervida</span>
        </div>
      </div>

      <!-- Estado: Cargando / Verificando -->
      <div v-if="loading" class="text-center py-12 space-y-6">
        <div class="relative mx-auto w-24 h-24 flex items-center justify-center">
          <div class="absolute inset-0 rounded-full border-4 border-accent-neon/20 animate-pulse"></div>
          <div class="absolute inset-0 rounded-full border-4 border-t-accent-neon animate-spin"></div>
          <span class="material-symbols-outlined text-accent-neon text-4xl font-black">verified_user</span>
        </div>
        <div>
          <h2 class="font-lexend text-xl font-black tracking-tight">Verificando Código</h2>
          <p class="mt-2 text-xs font-bold uppercase tracking-widest text-on-surface/40">Consultando base de datos académica...</p>
        </div>
      </div>

      <!-- Estado: Certificado Válido (Éxito) -->
      <div v-else-if="certificado" class="space-y-8">
        <div class="text-center">
          <!-- Insignia de Verificado con micro-animación -->
          <div class="mx-auto mb-6 flex h-24 w-24 items-center justify-center rounded-full bg-emerald-500/10 text-emerald-400 shadow-[0_0_30px_rgba(16,185,129,0.2)] animate-bounce-short">
            <span class="material-symbols-outlined text-5xl font-black">verified</span>
          </div>
          <p class="text-[10px] font-black uppercase tracking-[0.3em] text-emerald-400">Verificación Oficial Exitosa</p>
          <h2 class="mt-3 font-lexend text-3xl font-black tracking-tight leading-tight">Certificado <span class="text-gradient-neon">Auténtico</span></h2>
          <p class="mt-4 text-sm text-on-surface/60 max-w-md mx-auto leading-relaxed">
            Se confirma que este documento es real, válido y ha sido emitido oficialmente por nuestra plataforma de aprendizaje.
          </p>
        </div>

        <!-- Tarjeta de Información Detallada -->
        <div class="p-6 md:p-8 rounded-3xl bg-on-surface/[0.03] space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Estudiante -->
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Estudiante Certificado</span>
              <p class="text-base font-black text-on-surface/90 uppercase">{{ certificado.estudiante }}</p>
            </div>
            <!-- Documento de Identidad -->
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Documento de Identidad (CI)</span>
              <p class="text-base font-black text-on-surface/90 uppercase">{{ certificado.ci }}</p>
            </div>
            <!-- Curso -->
            <div class="space-y-1 md:col-span-2">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Curso Aprobado</span>
              <p class="text-lg font-black text-accent-neon leading-snug">{{ certificado.curso }}</p>
            </div>
            <!-- Categoria -->
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Categoría</span>
              <p class="text-sm font-bold text-on-surface/75">{{ certificado.categoria }}</p>
            </div>
            <!-- Instructor -->
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Instructor Firmante</span>
              <p class="text-sm font-bold text-on-surface/75">{{ certificado.instructor || 'N/A' }}</p>
            </div>
          </div>

          <div class="pt-6 border-t border-on-surface/5 grid grid-cols-1 sm:grid-cols-2 gap-4">
            <!-- Código -->
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Código de Verificación</span>
              <p class="text-xs font-mono font-black text-accent-neon uppercase tracking-wider">{{ certificado.codigo_certificado }}</p>
            </div>
            <!-- Emisión -->
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Fecha de Emisión</span>
              <p class="text-xs font-bold text-on-surface/75">{{ certificado.fecha_emision }}</p>
            </div>
          </div>
        </div>

        <!-- Mensaje de Confianza de Seguridad -->
        <div class="flex gap-4 p-4 rounded-2xl bg-emerald-500/5 text-[10px] font-bold text-on-surface/50 leading-relaxed items-start">
          <span class="material-symbols-outlined text-emerald-400 text-lg shrink-0 mt-0.5">security</span>
          <p>
            Este registro está almacenado de forma permanente y encriptada en la base de datos de Campus Enervida. Cumple con todos los requisitos curriculares y académicos exigidos.
          </p>
        </div>
      </div>

      <!-- Estado: Código Inválido (Error) -->
      <div v-else class="text-center py-6 space-y-8 animate-in fade-in duration-300">
        <div class="mx-auto flex h-24 w-24 items-center justify-center rounded-full bg-red-500/10 text-red-400 shadow-[0_0_30px_rgba(239,68,68,0.2)] animate-pulse">
          <span class="material-symbols-outlined text-5xl font-black">gpp_maybe</span>
        </div>
        
        <div class="space-y-3">
          <p class="text-[10px] font-black uppercase tracking-[0.3em] text-red-400">Error de Autenticidad</p>
          <h2 class="font-lexend text-3xl font-black tracking-tight leading-tight">Certificado No Válido</h2>
          <p class="mt-4 text-sm text-on-surface/50 max-w-md mx-auto leading-relaxed">
            El código <span class="font-mono text-red-400 font-bold uppercase">{{ code }}</span> no corresponde a ningún certificado registrado en nuestra base de datos.
          </p>
        </div>

        <div class="p-5 rounded-2xl bg-red-500/5 text-xs text-red-400/80 leading-relaxed max-w-md mx-auto">
           <strong>Alerta:</strong> Si el código QR de un certificado físico o digital te dirigió a esta página de alerta, es probable que se trate de un documento duplicado, adulterado o fraudulento.
        </div>

        <div class="pt-4">
          <router-link to="/" class="btn-premium glass-card !bg-on-surface/[0.05] !border-none !px-8 !py-4 text-xs">
            Ir a Inicio
          </router-link>
        </div>
      </div>
      
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import api from '@/services/api'

const route = useRoute()
const code = ref(route.params.codigo || '')
const loading = ref(true)
const certificado = ref(null)

onMounted(async () => {
  try {
    const response = await api.get(`/certificados/validar/${code.value}`)
    certificado.value = response.data
  } catch (error) {
    console.error('Error validating certificate:', error)
    certificado.value = null
  } finally {
    loading.value = false
  }
})
</script>

<style scoped>
@keyframes bounce-short {
  0%, 100% {
    transform: translateY(0);
  }
  50% {
    transform: translateY(-8px);
  }
}

.animate-bounce-short {
  animation: bounce-short 2s ease-in-out infinite;
}
</style>
