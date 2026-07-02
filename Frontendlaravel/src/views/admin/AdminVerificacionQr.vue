<template>
  <div class="space-y-10 animate-in fade-in">
    <!-- Page Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
      <div>
        <p class="text-[10px] font-black uppercase tracking-[0.3em] text-accent-neon">Sistema / Validación</p>
        <h1 class="mt-2 font-lexend text-3xl font-black tracking-tight">Verificación de <span class="text-gradient-neon">Certificados QR</span></h1>
        <p class="mt-2 text-sm text-on-surface/50 max-w-lg">Ingresa el código de certificado para validar su autenticidad y consultar los datos del alumno registrado en la base de datos.</p>
      </div>
      <div class="flex items-center gap-3 px-5 py-3 rounded-2xl bg-accent-neon/5 !border-none">
        <span class="material-symbols-outlined text-accent-neon text-2xl">qr_code_scanner</span>
        <div>
          <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Módulo</p>
          <p class="text-xs font-black text-on-surface/80">Autenticidad de Diplomas</p>
        </div>
      </div>
    </div>

    <!-- Search / Input Card -->
    <section class="course-card-premium p-8 md:p-10">
      <h2 class="mb-6 text-[10px] font-black uppercase tracking-widest text-on-surface/40 flex items-center gap-2">
        <span class="material-symbols-outlined text-accent-neon text-sm">manage_search</span>
        Verificar código
      </h2>

      <form @submit.prevent="verificar" class="flex flex-col sm:flex-row gap-4">
        <div class="relative flex-1">
          <span class="material-symbols-outlined absolute left-5 top-1/2 -translate-y-1/2 text-on-surface/30 text-xl">badge</span>
          <input
            v-model="codigo"
            type="text"
            placeholder="Ej: CERT-A1B2C3D4E5"
            class="input-cyber !rounded-2xl w-full !pl-14 !pr-6 !py-4 uppercase tracking-widest"
            :class="{ 'border-red-500/50': error && !loading }"
            @input="resetResult"
          />
        </div>
        <button
          type="submit"
          :disabled="loading || !codigo.trim()"
          class="btn-premium btn-primary-neon !px-10 !py-4 !text-[11px] shrink-0 relative overflow-hidden"
        >
          <div v-if="loading" class="animate-spin rounded-full h-4 w-4 border-t-2 border-primary"></div>
          <span v-else class="material-symbols-outlined text-lg">search</span>
          {{ loading ? 'Verificando...' : 'Verificar' }}
        </button>
      </form>

      <!-- Hint pills -->
      <div class="mt-4 flex flex-wrap gap-2">
        <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/20">Ejemplos:</span>
        <button
          v-for="hint in hints"
          :key="hint"
          type="button"
          @click="usarHint(hint)"
          class="text-[9px] font-mono font-black uppercase tracking-wider text-accent-neon/60 hover:text-accent-neon transition-colors"
        >{{ hint }}</button>
      </div>
    </section>

    <!-- Result: Loading skeleton -->
    <section v-if="loading" class="course-card-premium p-10 animate-pulse">
      <div class="h-6 w-48 rounded-xl bg-on-surface/5 mb-4"></div>
      <div class="h-4 w-full max-w-sm rounded-xl bg-on-surface/5 mb-3"></div>
      <div class="h-4 w-full max-w-xs rounded-xl bg-on-surface/5"></div>
    </section>

    <!-- Result: VALID -->
    <section
      v-else-if="resultado"
      class="course-card-premium p-8 md:p-12 border border-emerald-500/20 animate-in fade-in slide-in-from-bottom-2"
    >
      <!-- Header del resultado -->
      <div class="flex flex-col sm:flex-row sm:items-center gap-6 mb-10">
        <div class="flex h-20 w-20 shrink-0 items-center justify-center rounded-3xl bg-emerald-500/10 text-emerald-400 shadow-[0_0_30px_rgba(16,185,129,0.15)]">
          <span class="material-symbols-outlined text-5xl font-black">verified</span>
        </div>
        <div>
          <span class="inline-block mb-2 px-4 py-1 rounded-full bg-emerald-500/10 text-emerald-400 text-[9px] font-black uppercase tracking-[0.3em] !border-none">✓ Certificado Auténtico</span>
          <h2 class="font-lexend text-2xl font-black tracking-tight">{{ resultado.estudiante }}</h2>
          <p class="text-[10px] font-mono font-bold text-accent-neon/70 uppercase tracking-wider mt-1">{{ resultado.codigo_certificado }}</p>
        </div>
      </div>

      <!-- Datos del certificado en grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
        <div
          v-for="campo in camposResultado"
          :key="campo.label"
          class="p-5 rounded-2xl bg-on-surface/[0.03] space-y-1.5"
        >
          <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">{{ campo.label }}</p>
          <p class="text-sm font-black text-on-surface/85 leading-snug" :class="campo.class">{{ campo.value }}</p>
        </div>
      </div>

      <!-- Footer de seguridad -->
      <div class="mt-8 pt-6 border-t border-on-surface/5 flex flex-col sm:flex-row sm:items-center gap-4 justify-between">
        <div class="flex items-center gap-3 text-[10px] font-bold text-on-surface/40">
          <span class="material-symbols-outlined text-emerald-400 text-base">verified_user</span>
          Registro permanente en base de datos · Emitido por Campus Enervida
        </div>
        <button
          @click="resetResult"
          class="btn-premium glass-card !bg-on-surface/[0.04] !border-none !px-6 !py-3 !text-[10px] font-black uppercase tracking-widest shrink-0"
        >
          <span class="material-symbols-outlined text-sm">refresh</span>
          Nueva consulta
        </button>
      </div>
    </section>

    <!-- Result: INVALID -->
    <section
      v-else-if="error"
      class="course-card-premium p-8 md:p-12 border border-red-500/20 animate-in fade-in slide-in-from-bottom-2"
    >
      <div class="flex flex-col sm:flex-row sm:items-center gap-6">
        <div class="flex h-20 w-20 shrink-0 items-center justify-center rounded-3xl bg-red-500/10 text-red-400 shadow-[0_0_30px_rgba(239,68,68,0.15)] animate-pulse">
          <span class="material-symbols-outlined text-5xl font-black">gpp_maybe</span>
        </div>
        <div class="flex-1">
          <span class="inline-block mb-2 px-4 py-1 rounded-full bg-red-500/10 text-red-400 text-[9px] font-black uppercase tracking-[0.3em] !border-none">✗ Certificado Inválido</span>
          <h2 class="font-lexend text-2xl font-black tracking-tight">No encontrado en el sistema</h2>
          <p class="mt-2 text-sm text-on-surface/50 leading-relaxed">
            El código <span class="font-mono text-red-400 font-bold uppercase">{{ codigo }}</span> no corresponde a ningún certificado emitido por esta plataforma. Puede tratarse de un documento duplicado, alterado o fraudulento.
          </p>
        </div>
      </div>

      <div class="mt-6 p-4 rounded-2xl bg-red-500/5 text-[10px] font-bold text-red-400/80 leading-relaxed flex items-start gap-3">
        <span class="material-symbols-outlined text-base shrink-0">warning</span>
        Recomendamos no aceptar este certificado como válido para ningún proceso académico o laboral.
      </div>
    </section>

    <!-- Historial de verificaciones recientes (sesión) -->
    <section v-if="historial.length > 0" class="course-card-premium p-8">
      <h2 class="mb-6 text-[10px] font-black uppercase tracking-widest text-on-surface/40 flex items-center gap-2">
        <span class="material-symbols-outlined text-accent-neon text-sm">history</span>
        Consultas recientes (esta sesión)
      </h2>
      <div class="space-y-3">
        <div
          v-for="item in historial"
          :key="item.codigo"
          class="flex items-center justify-between p-4 rounded-2xl bg-on-surface/[0.02] hover:bg-on-surface/[0.04] transition-colors cursor-pointer"
          @click="usarHint(item.codigo)"
        >
          <div class="flex items-center gap-4">
            <span
              class="material-symbols-outlined text-xl"
              :class="item.valido ? 'text-emerald-400' : 'text-red-400'"
            >{{ item.valido ? 'check_circle' : 'cancel' }}</span>
            <div>
              <p class="text-xs font-mono font-black uppercase tracking-wider text-on-surface/80">{{ item.codigo }}</p>
              <p class="text-[9px] font-bold text-on-surface/40">{{ item.valido ? item.nombre : 'No encontrado' }}</p>
            </div>
          </div>
          <span
            class="px-3 py-1 rounded-full text-[9px] font-black uppercase tracking-wider !border-none"
            :class="item.valido ? 'bg-emerald-500/10 text-emerald-400' : 'bg-red-500/10 text-red-400'"
          >{{ item.valido ? 'Válido' : 'Inválido' }}</span>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import api from '@/services/api'

const codigo = ref('')
const loading = ref(false)
const resultado = ref(null)
const error = ref(false)
const historial = ref([])

// Hints de ejemplo para guiar al administrador
const hints = ['CERT-XXXXXXXXXX']

const camposResultado = computed(() => {
  if (!resultado.value) return []
  return [
    { label: 'Estudiante', value: resultado.value.estudiante, class: 'uppercase' },
    { label: 'Cédula / DNI', value: resultado.value.ci || 'N/A', class: 'font-mono' },
    { label: 'Curso Aprobado', value: resultado.value.curso, class: 'text-accent-neon' },
    { label: 'Categoría', value: resultado.value.categoria || '—', class: '' },
    { label: 'Instructor', value: resultado.value.instructor || '—', class: '' },
    { label: 'Fecha de Emisión', value: resultado.value.fecha_emision, class: '' },
  ]
})

function resetResult() {
  resultado.value = null
  error.value = false
}

function usarHint(code) {
  codigo.value = code
  resetResult()
}

async function verificar() {
  if (!codigo.value.trim()) return
  loading.value = true
  resetResult()

  const codigoLimpio = codigo.value.trim().toUpperCase()

  try {
    const res = await api.get(`/certificados/validar/${codigoLimpio}`)
    resultado.value = res.data
    // Agregar al historial
    historial.value.unshift({
      codigo: codigoLimpio,
      valido: true,
      nombre: res.data.estudiante
    })
  } catch (e) {
    error.value = true
    historial.value.unshift({
      codigo: codigoLimpio,
      valido: false,
      nombre: null
    })
  } finally {
    loading.value = false
  }
}
</script>
