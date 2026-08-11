<template>
  <div class="space-y-10 animate-in fade-in duration-300 transition-colors">
    <!-- Page Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
      <div>
        <p class="text-[10px] font-black uppercase tracking-[0.3em] text-accent-neon">Sistema / Validación</p>
        <h1 class="mt-2 font-lexend text-3xl font-black tracking-tight text-gray-900 dark:text-white">
          Verificación de <span class="text-gradient-neon">Certificados QR</span>
        </h1>
        <p class="mt-2 text-sm font-medium text-gray-600 dark:text-white/60 max-w-lg">
          Ingresa el código de certificado para validar su autenticidad y consultar los datos del alumno registrado en la base de datos.
        </p>
      </div>

      <div class="flex items-center gap-3 px-5 py-3 rounded-2xl bg-accent-neon/10 border border-accent-neon/20 shadow-sm backdrop-blur-sm">
        <span class="material-symbols-outlined text-accent-neon text-2xl">qr_code_scanner</span>
        <div>
          <p class="text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Módulo</p>
          <p class="text-xs font-black text-gray-900 dark:text-white/90">Autenticidad de Certificados</p>
        </div>
      </div>
    </div>

    <!-- Search / Input Card -->
    <section class="course-card-premium p-6 sm:p-8 md:p-10 bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 rounded-3xl shadow-xl dark:shadow-2xl transition-all">
      <h2 class="mb-6 text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 flex items-center gap-2">
        <span class="material-symbols-outlined text-accent-neon text-base">manage_search</span>
        Verificar código
      </h2>

      <form @submit.prevent="verificar" class="flex flex-col sm:flex-row gap-4">
        <div class="relative flex-1">
          <span class="material-symbols-outlined absolute left-5 top-1/2 -translate-y-1/2 text-gray-400 dark:text-white/30 text-xl pointer-events-none">badge</span>
          <input
            v-model="codigo"
            type="text"
            placeholder="Ej: CERT-A1B2C3D4E5"
            class="input-cyber !rounded-2xl w-full !pl-14 !pr-6 !py-4 uppercase tracking-widest bg-gray-50/80 dark:bg-black/30 text-gray-900 dark:text-white border-gray-200 dark:border-white/10 placeholder:text-gray-400 dark:placeholder:text-white/30 focus:bg-white dark:focus:bg-black/50 transition-all"
            :class="{ '!border-red-500/60 focus:!ring-red-500/20': error && !loading }"
            @input="resetResult"
          />
        </div>
        <button
          type="submit"
          :disabled="loading || !codigo.trim()"
          class="btn-premium btn-primary-neon !px-10 !py-4 !text-[11px] shrink-0 relative overflow-hidden disabled:opacity-50 disabled:cursor-not-allowed shadow-md hover:shadow-accent-neon/20 transition-all"
        >
          <div v-if="loading" class="animate-spin rounded-full h-4 w-4 border-2 border-background border-t-transparent"></div>
          <span v-else class="material-symbols-outlined text-lg">search</span>
          {{ loading ? 'Verificando...' : 'Verificar' }}
        </button>
      </form>

      <!-- Hint pills -->
      <div v-if="hints && hints.length" class="mt-5 flex flex-wrap items-center gap-2">
        <span class="text-[9px] font-black uppercase tracking-widest text-gray-400 dark:text-white/30">Ejemplos:</span>
        <button
          v-for="hint in hints"
          :key="hint"
          type="button"
          @click="usarHint(hint)"
          class="text-[10px] font-mono font-bold uppercase tracking-wider text-accent-neon/90 hover:text-accent-neon hover:underline transition-colors px-2 py-0.5 rounded-lg bg-accent-neon/5 hover:bg-accent-neon/10"
        >
          {{ hint }}
        </button>
      </div>
    </section>

    <!-- Import JSON backup section -->
    <section class="course-card-premium p-6 sm:p-8 md:p-10 bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 rounded-3xl shadow-xl dark:shadow-2xl transition-all">
      <h2 class="mb-6 text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 flex items-center gap-2">
        <span class="material-symbols-outlined text-accent-neon text-base">upload_file</span>
        Importar respaldo local (.json)
      </h2>

      <div class="grid grid-cols-1 lg:grid-cols-[1fr_auto] gap-4 items-center">
        <label class="group flex items-center gap-3 rounded-2xl border border-dashed border-gray-300 dark:border-white/15 bg-gray-50/60 dark:bg-white/[0.02] px-5 py-3.5 cursor-pointer hover:bg-gray-100/80 dark:hover:bg-white/[0.05] hover:border-accent-neon/50 transition-all">
          <span class="material-symbols-outlined text-accent-neon group-hover:scale-110 transition-transform">attach_file</span>
          <span class="text-xs font-bold text-gray-700 dark:text-white/70 truncate">
            {{ selectedFile ? selectedFile.name : 'Selecciona un archivo JSON de respaldo' }}
          </span>
          <input type="file" accept=".json,application/json" class="hidden" @change="onFileSelected" />
        </label>

        <button
          type="button"
          @click="importarJson"
          :disabled="importing || !selectedFile"
          class="btn-premium btn-secondary-neon !px-8 !py-4 !text-[11px] shrink-0 disabled:opacity-50 disabled:cursor-not-allowed shadow-md transition-all"
        >
          <div v-if="importing" class="animate-spin rounded-full h-4 w-4 border-2 border-current border-t-transparent"></div>
          <span v-else class="material-symbols-outlined text-lg">upload</span>
          {{ importing ? 'Importando...' : 'Importar JSON' }}
        </button>
      </div>

      <p class="mt-3 text-[10px] font-semibold text-gray-400 dark:text-white/40 leading-relaxed">
        Esta importación solo fusiona los registros en el JSON local de respaldo y no altera la base de datos principal.
      </p>

      <div 
        v-if="importMessage" 
        class="mt-4 rounded-2xl px-4 py-3 text-[11px] font-bold transition-all flex items-center gap-2" 
        :class="importError ? 'bg-red-500/10 text-red-600 dark:text-red-400 border border-red-500/20' : 'bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border border-emerald-500/20'"
      >
        <span class="material-symbols-outlined text-base shrink-0">{{ importError ? 'error' : 'check_circle' }}</span>
        <span>{{ importMessage }}</span>
      </div>
    </section>

    <!-- Result: Loading skeleton -->
    <section v-if="loading" class="course-card-premium p-8 sm:p-10 bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 rounded-3xl animate-pulse">
      <div class="h-6 w-48 rounded-xl bg-gray-200 dark:bg-white/10 mb-4"></div>
      <div class="h-4 w-full max-w-sm rounded-xl bg-gray-200 dark:bg-white/10 mb-3"></div>
      <div class="h-4 w-full max-w-xs rounded-xl bg-gray-200 dark:bg-white/10"></div>
    </section>

    <!-- Result: VALID -->
    <section
      v-else-if="resultado"
      class="course-card-premium p-6 sm:p-8 md:p-12 bg-white dark:bg-surface border border-emerald-500/40 rounded-3xl shadow-2xl dark:shadow-[0_0_50px_rgba(16,185,129,0.12)] animate-in fade-in slide-in-from-bottom-3 transition-all"
    >
      <!-- Header del resultado -->
      <div class="flex flex-col sm:flex-row sm:items-center gap-6 mb-8 sm:mb-10">
        <div class="flex h-20 w-20 shrink-0 items-center justify-center rounded-3xl bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 shadow-[0_0_30px_rgba(16,185,129,0.2)] border border-emerald-500/20">
          <span class="material-symbols-outlined text-5xl font-black">verified</span>
        </div>
        <div>
          <span class="inline-flex items-center gap-1.5 mb-2 px-3.5 py-1 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-700 dark:text-emerald-400 text-[10px] font-black uppercase tracking-[0.25em]">
            <span class="material-symbols-outlined text-xs">check</span> Certificado Auténtico
          </span>
          <h2 class="font-lexend text-2xl sm:text-3xl font-black tracking-tight text-gray-900 dark:text-white">
            {{ resultado.estudiante }}
          </h2>
          <p class="text-xs font-mono font-bold text-accent-neon dark:text-accent-neon/90 uppercase tracking-wider mt-1">
            {{ resultado.codigo_certificado }}
          </p>
        </div>
      </div>

      <!-- Datos del certificado en grid -->
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4 sm:gap-6">
        <div
          v-for="campo in camposResultado"
          :key="campo.label"
          class="p-5 rounded-2xl bg-gray-50/80 dark:bg-black/30 border border-gray-200/60 dark:border-white/5 space-y-1.5 hover:border-gray-300 dark:hover:border-white/10 transition-colors"
        >
          <p class="text-[9px] font-black uppercase tracking-widest text-gray-400 dark:text-white/40">{{ campo.label }}</p>
          <p class="text-sm font-black text-gray-900 dark:text-white leading-snug" :class="campo.class">{{ campo.value }}</p>
        </div>
      </div>

      <!-- Footer de seguridad -->
      <div class="mt-8 pt-6 border-t border-gray-200 dark:border-white/10 flex flex-col sm:flex-row sm:items-center gap-4 justify-between">
        <div class="flex items-center gap-2.5 text-[10px] font-bold text-gray-500 dark:text-white/50">
          <span class="material-symbols-outlined text-emerald-500 dark:text-emerald-400 text-base">verified_user</span>
          <span>Registro permanente en base de datos · Emitido por Campus Enervida</span>
        </div>
        <button
          @click="resetResult"
          class="btn-premium bg-gray-100 hover:bg-gray-200/80 dark:bg-white/5 dark:hover:bg-white/10 border border-gray-200 dark:border-white/10 text-gray-900 dark:text-white !px-6 !py-3 !text-[10px] font-black uppercase tracking-widest shrink-0 transition-all active:scale-95"
        >
          <span class="material-symbols-outlined text-sm">refresh</span>
          Nueva consulta
        </button>
      </div>
    </section>

    <!-- Result: INVALID -->
    <section
      v-else-if="error"
      class="course-card-premium p-6 sm:p-8 md:p-12 bg-white dark:bg-surface border border-red-500/40 rounded-3xl shadow-2xl dark:shadow-[0_0_50px_rgba(239,68,68,0.12)] animate-in fade-in slide-in-from-bottom-3 transition-all"
    >
      <div class="flex flex-col sm:flex-row sm:items-center gap-6">
        <div class="flex h-20 w-20 shrink-0 items-center justify-center rounded-3xl bg-red-500/10 text-red-600 dark:text-red-400 shadow-[0_0_30px_rgba(239,68,68,0.2)] border border-red-500/20 animate-pulse">
          <span class="material-symbols-outlined text-5xl font-black">gpp_maybe</span>
        </div>
        <div class="flex-1">
          <span class="inline-flex items-center gap-1.5 mb-2 px-3.5 py-1 rounded-full bg-red-500/10 border border-red-500/20 text-red-700 dark:text-red-400 text-[10px] font-black uppercase tracking-[0.25em]">
            <span class="material-symbols-outlined text-xs">close</span> Certificado Inválido
          </span>
          <h2 class="font-lexend text-2xl font-black tracking-tight text-gray-900 dark:text-white">No encontrado en el sistema</h2>
          <p class="mt-2 text-sm text-gray-600 dark:text-white/60 leading-relaxed">
            El código <span class="font-mono text-red-600 dark:text-red-400 font-bold uppercase bg-red-500/10 px-2 py-0.5 rounded-md">{{ codigo }}</span> no corresponde a ningún certificado emitido por esta plataforma. Puede tratarse de un documento duplicado, alterado o fraudulento.
          </p>
        </div>
      </div>

      <div class="mt-6 p-4 rounded-2xl bg-red-500/10 border border-red-500/20 text-xs font-bold text-red-700 dark:text-red-400 leading-relaxed flex items-start gap-3">
        <span class="material-symbols-outlined text-lg shrink-0 text-red-600 dark:text-red-400">warning</span>
        <span>Recomendamos no aceptar este certificado como válido para ningún proceso académico o laboral.</span>
      </div>
    </section>

    <!-- Historial de verificaciones recientes -->
    <section v-if="historial && historial.length > 0" class="course-card-premium p-6 sm:p-8 bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 rounded-3xl shadow-xl transition-all">
      <h2 class="mb-6 text-[10px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40 flex items-center gap-2">
        <span class="material-symbols-outlined text-accent-neon text-base">history</span>
        Consultas recientes (esta sesión)
      </h2>
      <div class="space-y-3">
        <div
          v-for="item in historial"
          :key="item.codigo"
          class="flex items-center justify-between p-4 rounded-2xl bg-gray-50/80 dark:bg-black/20 hover:bg-gray-100/80 dark:hover:bg-white/5 border border-gray-200/60 dark:border-white/5 transition-all cursor-pointer group"
          @click="usarHint(item.codigo)"
        >
          <div class="flex items-center gap-4">
            <span
              class="material-symbols-outlined text-xl shrink-0 transition-transform group-hover:scale-110"
              :class="item.valido ? 'text-emerald-600 dark:text-emerald-400' : 'text-red-600 dark:text-red-400'"
            >
              {{ item.valido ? 'check_circle' : 'cancel' }}
            </span>
            <div>
              <p class="text-xs font-mono font-black uppercase tracking-wider text-gray-900 dark:text-white/90">{{ item.codigo }}</p>
              <p class="text-[10px] font-semibold text-gray-500 dark:text-white/40">{{ item.valido ? item.nombre : 'No encontrado' }}</p>
            </div>
          </div>
          <span
            class="px-3 py-1 rounded-full text-[9px] font-black uppercase tracking-wider border"
            :class="item.valido ? 'bg-emerald-500/10 border-emerald-500/20 text-emerald-700 dark:text-emerald-400' : 'bg-red-500/10 border-red-500/20 text-red-700 dark:text-red-400'"
          >
            {{ item.valido ? 'Válido' : 'Inválido' }}
          </span>
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
const importing = ref(false)
const resultado = ref(null)
const error = ref(false)
const historial = ref([])
const selectedFile = ref(null)
const importMessage = ref('')
const importError = ref(false)

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

function onFileSelected(event) {
  const file = event.target.files?.[0]
  selectedFile.value = file || null
  importMessage.value = ''
  importError.value = false
}

async function importarJson() {
  if (!selectedFile.value) return

  importing.value = true
  importMessage.value = ''
  importError.value = false

  const formData = new FormData()
  formData.append('file', selectedFile.value)

  try {
    const res = await api.post('/certificados/import-json', formData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    importMessage.value = res.data?.message || 'Importación completada correctamente.'
    importError.value = false
    selectedFile.value = null
  } catch (e) {
    importError.value = true
    importMessage.value = e?.response?.data?.message || 'No se pudo importar el JSON.'
  } finally {
    importing.value = false
  }
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
