<template>
  <div class="relative min-h-screen flex items-center justify-center p-4 bg-background overflow-hidden font-inter text-on-surface">
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[500px] w-[500px] rounded-full bg-accent-neon/5 blur-[120px]"></div>
      <div class="absolute -right-[5%] top-[20%] h-[400px] w-[400px] rounded-full bg-accent-solar/5 blur-[100px]"></div>
      <div class="absolute left-[30%] bottom-[-10%] h-[350px] w-[350px] rounded-full bg-primary/5 blur-[90px]"></div>
    </div>

    <div class="relative z-10 w-full max-w-2xl glass-card-premium rounded-[48px] p-8 md:p-12 shadow-[0_20px_50px_rgba(0,0,0,0.3)] animate-in fade-in zoom-in-95 duration-500">
      <div class="flex justify-center mb-8">
        <div class="px-6 py-2.5 rounded-2xl bg-on-surface/5 backdrop-blur-md flex items-center gap-2">
          <span class="material-symbols-outlined text-accent-neon text-xl font-black">school</span>
          <span class="font-lexend text-xs font-black uppercase tracking-[0.25em] text-on-surface/80">Campus Enervida</span>
        </div>
      </div>

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

      <div v-else-if="resultado" class="space-y-8">
        <div class="text-center">
          <div class="mx-auto mb-6 flex h-24 w-24 items-center justify-center rounded-full bg-emerald-500/10 text-emerald-400 shadow-[0_0_30px_rgba(16,185,129,0.2)] animate-bounce-short">
            <span class="material-symbols-outlined text-5xl font-black">verified</span>
          </div>
          <p class="text-[10px] font-black uppercase tracking-[0.3em] text-emerald-400">Verificación Oficial Exitosa</p>
          <h2 class="mt-3 font-lexend text-3xl font-black tracking-tight leading-tight">Certificado <span class="text-gradient-neon">Auténtico</span></h2>
          <p class="mt-4 text-sm text-on-surface/60 max-w-md mx-auto leading-relaxed">
            Se confirma que este documento es real, válido y ha sido emitido oficialmente por nuestra plataforma de aprendizaje.
          </p>
        </div>

        <div class="p-6 md:p-8 rounded-3xl bg-on-surface/[0.03] space-y-6">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Estudiante Certificado</span>
              <p class="text-base font-black text-on-surface/90 uppercase">{{ resultado.estudiante }}</p>
            </div>
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Documento de Identidad (CI)</span>
              <p class="text-base font-black text-on-surface/90 uppercase">{{ resultado.ci }}</p>
            </div>
            <div class="space-y-1 md:col-span-2">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Curso Aprobado</span>
              <p class="text-lg font-black text-accent-neon leading-snug">{{ resultado.curso }}</p>
            </div>
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Categoría</span>
              <p class="text-sm font-bold text-on-surface/75">{{ resultado.categoria }}</p>
            </div>
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Instructor Firmante</span>
              <p class="text-sm font-bold text-on-surface/75">{{ resultado.instructor || 'N/A' }}</p>
            </div>
          </div>

          <div class="pt-6 border-t border-on-surface/5 grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Código de Verificación</span>
              <p class="text-xs font-mono font-black text-accent-neon uppercase tracking-wider">{{ resultado.codigo_certificado }}</p>
            </div>
            <div class="space-y-1">
              <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Fecha de Emisión</span>
              <p class="text-xs font-bold text-on-surface/75">{{ resultado.fecha_emision }}</p>
            </div>
          </div>
        </div>

        <div class="flex gap-4 p-4 rounded-2xl bg-emerald-500/5 text-[10px] font-bold text-on-surface/50 leading-relaxed items-start">
          <span class="material-symbols-outlined text-emerald-400 text-lg shrink-0 mt-0.5">security</span>
          <p>
            Este registro está almacenado de forma permanente y encriptada en la base de datos de Campus Enervida. Cumple con todos los requisitos curriculares y académicos exigidos.
          </p>
        </div>
      </div>

      <div v-else-if="buscado" class="text-center py-6 space-y-8 animate-in fade-in duration-300">
        <div class="mx-auto flex h-24 w-24 items-center justify-center rounded-full bg-red-500/10 text-red-400 shadow-[0_0_30px_rgba(239,68,68,0.2)] animate-pulse">
          <span class="material-symbols-outlined text-5xl font-black">gpp_maybe</span>
        </div>

        <div class="space-y-3">
          <p class="text-[10px] font-black uppercase tracking-[0.3em] text-red-400">Error de Autenticidad</p>
          <h2 class="font-lexend text-3xl font-black tracking-tight leading-tight">Certificado No Válido</h2>
          <p class="mt-4 text-sm text-on-surface/50 max-w-md mx-auto leading-relaxed">
            El código <span class="font-mono text-red-400 font-bold uppercase">{{ codigoIngresado }}</span> no corresponde a ningún certificado registrado en nuestra base de datos.
          </p>
        </div>

        <div class="p-5 rounded-2xl bg-red-500/5 text-xs text-red-400/80 leading-relaxed max-w-md mx-auto">
          <strong>Alerta:</strong> Si el código QR de un certificado físico o digital te dirigió a esta página de alerta, es probable que se trate de un documento duplicado, adulterado o fraudulento.
        </div>

        <div class="pt-4 grid gap-3 sm:grid-cols-2">
          <router-link to="/" class="btn-premium btn-primary-neon !px-8 !py-4 text-xs shadow-neon-sm text-primary">
            Ir a Inicio
          </router-link>
          <router-link to="/verificar" class="btn-premium btn-primary-solar !px-8 !py-4 text-xs shadow-[0_0_20px_rgba(234,179,8,0.25)]">
            Volver a verificar
          </router-link>
        </div>
      </div>

      <div v-else class="space-y-6">
        <div class="text-center">
          <div class="mx-auto mb-6 flex h-24 w-24 items-center justify-center rounded-full bg-accent-neon/10 text-accent-neon shadow-[0_0_30px_rgba(6,182,212,0.15)]">
            <span class="material-symbols-outlined text-5xl font-black">search</span>
          </div>
          <p class="text-[10px] font-black uppercase tracking-[0.3em] text-accent-neon">Búsqueda global</p>
          <h2 class="mt-3 font-lexend text-3xl font-black tracking-tight leading-tight">Ingresa un código para verificar</h2>
          <p class="mt-4 text-sm text-on-surface/60 max-w-md mx-auto leading-relaxed">
            Puedes buscar cualquier certificado por su código de verificación y consultar su autenticidad de forma instantánea.
          </p>
        </div>

        <form @submit.prevent="buscarCertificado" class="flex flex-col gap-3 rounded-[28px] border border-white/10 bg-on-surface/[0.03] p-4 sm:flex-row sm:items-center sm:p-6">
          <div class="flex-1">
            <label for="codigo" class="mb-2 block text-[10px] font-black uppercase tracking-[0.3em] text-on-surface/35">
              Código de verificación
            </label>
            <input id="codigo" v-model="codigoIngresado" type="text" placeholder="Ej. BS02260002" class="w-full rounded-2xl border border-white/10 bg-background/70 px-4 py-3 text-sm font-semibold text-on-surface outline-none ring-0 placeholder:text-on-surface/30 focus:border-accent-neon"/>
          </div>
          <button type="submit" class="btn-premium btn-primary-neon !px-8 !py-3 !text-[11px] sm:!min-w-[180px]" :disabled="loading">
            {{ loading ? 'Verificando...' : 'Verificar' }}
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed, ref, watch, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '@/services/api'

const route = useRoute()
const router = useRouter()
const codigoIngresado = ref('')
const loading = ref(false)
const resultado = ref(null)
const buscado = ref(false)

const codigoActual = computed(() => (route.params.codigo || '').trim())

const normalizeCodigo = (value) => {
  return (value || '').toString().trim().toUpperCase()
}

const buscarCertificado = async () => {
  const codigo = normalizeCodigo(codigoIngresado.value || codigoActual.value)
  if (!codigo) return

  if (codigo !== normalizeCodigo(codigoActual.value)) {
    await router.push({ name: 'verificar-certificado', params: { codigo } })
    return
  }

  loading.value = true
  resultado.value = null
  buscado.value = false

  try {
    const response = await api.get(`/certificados/validar/${codigo}`)
    resultado.value = response.data
    buscado.value = true
  } catch (error) {
    if (error.response?.status !== 404) {
      console.error('Error validando certificado:', error)
    }
    resultado.value = null
    buscado.value = true
  } finally {
    loading.value = false
  }
}

watch(
  () => route.params.codigo,
  (newCodigo) => {
    const codigo = normalizeCodigo(newCodigo)
    codigoIngresado.value = codigo

    if (codigo) {
      buscarCertificado()
    } else {
      resultado.value = null
      buscado.value = false
      loading.value = false
    }
  },
  { immediate: true }
)

onMounted(() => {
  if (!codigoActual.value) {
    codigoIngresado.value = ''
    resultado.value = null
    buscado.value = false
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
