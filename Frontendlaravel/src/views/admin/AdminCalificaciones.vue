<template>
  <div class="space-y-8 animate-fade-in text-on-surface">

    <!-- Header -->
    <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
      <div>
        <p class="text-[10px] font-black uppercase tracking-[0.28em] text-accent-neon mb-2">Módulo Académico</p>
        <h2 class="text-3xl font-black font-lexend tracking-tighter">
          Calificaciones <span class="text-accent-neon italic">Generales</span>
        </h2>
        <p class="text-on-surface/40 mt-1 text-xs font-bold uppercase tracking-widest">
          Todos los intentos de evaluación de los estudiantes
        </p>
      </div>
      <!-- Stats summary -->
      <div class="flex gap-4 shrink-0">
        <div class="glass-card px-5 py-4 rounded-2xl text-center">
          <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/40">Total Intentos</p>
          <p class="text-2xl font-black text-on-surface mt-1">{{ intentos.length }}</p>
        </div>
        <div class="glass-card px-5 py-4 rounded-2xl text-center">
          <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/40">Aprobados</p>
          <p class="text-2xl font-black text-green-500 mt-1">{{ aprobados }}</p>
        </div>
        <div class="glass-card px-5 py-4 rounded-2xl text-center">
          <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/40">Reprobados</p>
          <p class="text-2xl font-black text-red-500 mt-1">{{ reprobados }}</p>
        </div>
      </div>
      <div class="flex flex-wrap items-center gap-4">
          <button @click="fetchIntentos" class="btn-premium btn-secondary-glass !py-4 px-8 group/btn relative overflow-hidden !border-none shadow-xl hover:shadow-accent-neon/20 transition-all duration-500">
             <span class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-180 duration-500 relative" :class="{ 'animate-spin': loading }">refresh</span>
             <span class="relative font-bold">Actualizar</span>
          </button>
        </div>
    </div>

    <!-- Filters -->
    <div class="glass-card p-6 rounded-[32px] flex flex-col sm:flex-row gap-4">
      <!-- Search by student -->
      <div class="relative flex-1">
        <span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-on-surface/30 text-[18px]">search</span>
        <input
          v-model="filterSearch"
          type="text"
          placeholder="Buscar estudiante o evaluación..."
          class="w-full bg-on-surface/[0.04] rounded-2xl py-3 pl-10 pr-4 text-xs font-bold focus:outline-none focus:ring-1 focus:ring-accent-neon/40 transition-all"
        />
      </div>
      <!-- Filter by estado -->
      <select
        v-model="filterEstado"
        class="bg-on-surface/[0.04] rounded-2xl py-3 px-4 text-xs font-bold focus:outline-none focus:ring-1 focus:ring-accent-neon/40 transition-all min-w-[160px]"
      >
        <option value="">Todos los estados</option>
        <option value="aprobado">Aprobado</option>
        <option value="reprobado">Reprobado</option>
      </select>
      <!-- Filter by course -->
      <select
        v-model="filterCurso"
        class="bg-on-surface/[0.04] rounded-2xl py-3 px-4 text-xs font-bold focus:outline-none focus:ring-1 focus:ring-accent-neon/40 transition-all min-w-[180px]"
      >
        <option value="">Todos los cursos</option>
        <option v-for="curso in cursosUnicos" :key="curso" :value="curso">{{ curso }}</option>
      </select>
    </div>

    <!-- Table -->
    <div class="glass-card-premium rounded-[20px] overflow-hidden shadow-2xl relative min-h-[400px] !border-none">
      <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
        <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando calificaciones...</p>
      </div>
      <div  class="overflow-x-auto">
        <table class="w-full min-w-[900px] text-left border-separate border-spacing-0">
          <thead>
            <tr class="border-b border-on-surface/5">
              <th class="px-8 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Estudiante</th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Evaluación / Curso</th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Nota</th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Estado</th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Fecha</th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-right">Detalle</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="intento in intentosFiltrados"
              :key="intento.id"
              class="group border-b border-on-surface/5 hover:bg-on-surface/[0.03] transition-colors"
            >
              <!-- Estudiante -->
              <td class="px-8 py-5">
                <div class="flex items-center gap-3">
                  <div class="h-9 w-9 rounded-xl bg-gradient-to-br from-accent-neon/20 to-accent-solar/20 flex items-center justify-center text-xs font-black text-accent-neon shrink-0">
                    {{ initials(intento.usuario) }}
                  </div>
                  <div>
                    <p class="text-xs font-black text-on-surface group-hover:text-accent-neon transition-colors">
                      {{ intento.usuario?.nombres }} {{ intento.usuario?.apellidos }}
                    </p>
                    <p class="text-[10px] text-on-surface/40 font-bold">{{ intento.usuario?.correo }}</p>
                  </div>
                </div>
              </td>
              <!-- Evaluación -->
              <td class="px-6 py-5">
                <p class="text-xs font-black text-on-surface">{{ intento.evaluacion?.titulo }}</p>
                <p class="text-[10px] text-on-surface/40 font-bold mt-0.5">{{ intento.evaluacion?.curso?.titulo || '—' }}</p>
              </td>
              <!-- Nota -->
              <td class="px-6 py-5">
                <span :class="['text-sm font-black', intento.aprobado ? 'text-green-500' : 'text-red-500']">
                  {{ Math.round(intento.nota || 0) }}%
                </span>
              </td>
              <!-- Estado -->
              <td class="px-6 py-5">
                <span :class="['px-3 py-1 text-[9px] font-black rounded-full uppercase tracking-widest', intento.aprobado ? 'bg-green-500/10 text-green-500' : 'bg-red-500/10 text-red-500']">
                  {{ intento.aprobado ? 'Aprobado' : 'Reprobado' }}
                </span>
              </td>
              <!-- Fecha -->
              <td class="px-6 py-5 text-[10px] text-on-surface/40 font-bold uppercase">
                {{ formatDate(intento.fecha_fin || intento.fecha_inicio) }}
              </td>
              <!-- Detalle -->
              <td class="px-6 py-5 text-right">
                <button
                  @click="openDetail(intento)"
                  class="px-3 py-1.5 bg-accent-neon/10 text-accent-neon text-[9px] font-black rounded-lg hover:bg-accent-neon hover:text-primary transition-all uppercase tracking-wider"
                >
                  Ver Respuestas
                </button>
              </td>
            </tr>
            <tr v-if="!intentosFiltrados.length">
              <td colspan="6" class="px-8 py-20 text-center text-on-surface/20">
                <span class="material-symbols-outlined text-4xl mb-3 block">search_off</span>
                <p class="text-[10px] font-black uppercase tracking-widest">Sin resultados</p>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- ===================== DETAIL MODAL ===================== -->
    <div v-if="showModal && selectedIntento" class="fixed inset-0 bg-background/80 backdrop-blur-xl z-[250] flex items-center justify-center p-4">
      <div class="glass-card max-w-4xl w-full max-h-[90vh] flex flex-col rounded-[32px] overflow-hidden shadow-2xl relative border border-on-surface/10 bg-background">

        <!-- Modal Header -->
        <div class="p-6 md:p-8 border-b border-on-surface/5 flex items-center justify-between shrink-0">
          <div>
            <h3 class="text-xl font-black text-on-surface font-lexend tracking-tight">
              {{ selectedIntento.usuario?.nombres }} {{ selectedIntento.usuario?.apellidos }}
              <span class="text-accent-neon"> — {{ selectedIntento.evaluacion?.titulo }}</span>
            </h3>
            <p class="text-xs text-on-surface/40 mt-1 uppercase font-bold tracking-wider">
              {{ formatDate(selectedIntento.fecha_fin || selectedIntento.fecha_inicio) }}
              · Duración: {{ calcDuration(selectedIntento.fecha_inicio, selectedIntento.fecha_fin) }}
            </p>
          </div>
          <button @click="showModal = false" class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:bg-red-500/10 hover:text-red-500 transition-all">
            <span class="material-symbols-outlined">close</span>
          </button>
        </div>

        <!-- Summary badges -->
        <div class="px-8 py-5 border-b border-on-surface/5 grid grid-cols-2 sm:grid-cols-4 gap-4 shrink-0">
          <div class="bg-on-surface/5 rounded-2xl p-4">
            <p class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Nota</p>
            <p :class="['text-2xl font-black mt-1', selectedIntento.aprobado ? 'text-green-500' : 'text-red-500']">
              {{ Math.round(selectedIntento.nota || 0) }}%
            </p>
          </div>
          <div class="bg-on-surface/5 rounded-2xl p-4">
            <p class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Aprobación mín.</p>
            <p class="text-2xl font-black text-on-surface mt-1">{{ Math.round(selectedIntento.evaluacion?.nota_aprobacion || 0) }}%</p>
          </div>
          <div class="bg-on-surface/5 rounded-2xl p-4">
            <p class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Estado</p>
            <span :class="['inline-block mt-2 px-3 py-1 text-[9px] font-black rounded-full uppercase tracking-widest', selectedIntento.aprobado ? 'bg-green-500/10 text-green-500' : 'bg-red-500/10 text-red-500']">
              {{ selectedIntento.aprobado ? 'Aprobado' : 'Reprobado' }}
            </span>
          </div>
          <div class="bg-on-surface/5 rounded-2xl p-4">
            <p class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Correctas</p>
            <p class="text-2xl font-black text-accent-neon mt-1">
              {{ correctCount }}/{{ selectedIntento.evaluacion?.preguntas?.length || 0 }}
            </p>
          </div>
        </div>

        <!-- Questions breakdown -->
        <div class="flex-1 overflow-y-auto p-6 md:p-8 space-y-5 custom-scrollbar">
          <!-- No answers stored -->
          <div v-if="!selectedIntento.respuestas_seleccionadas" class="text-center py-14 bg-yellow-500/5 rounded-2xl border border-yellow-500/10">
            <span class="material-symbols-outlined text-yellow-500 text-4xl mb-3">warning</span>
            <p class="text-xs font-black text-yellow-500 uppercase tracking-widest">Detalle no disponible</p>
            <p class="text-xs text-on-surface/40 mt-2 max-w-md mx-auto">
              Este intento fue realizado antes de la actualización que guarda las respuestas del estudiante.
            </p>
          </div>

          <template v-else>
            <h4 class="text-sm font-black text-on-surface uppercase tracking-widest">Desglose de preguntas</h4>

            <div
              v-for="(pregunta, qIdx) in selectedIntento.evaluacion?.preguntas"
              :key="pregunta.id"
              class="p-6 rounded-[20px] bg-on-surface/5 border border-on-surface/5 space-y-4"
            >
              <div class="flex items-start justify-between gap-4">
                <div class="flex-1">
                  <span class="text-[10px] font-black text-accent-neon uppercase tracking-wider">
                    Pregunta {{ qIdx + 1 }} ({{ pregunta.puntos }} pts)
                  </span>
                  <h5 class="text-sm font-bold text-on-surface mt-1 leading-relaxed">{{ pregunta.pregunta }}</h5>
                </div>
                <!-- Correct / Incorrect / No answer badge -->
                <span v-if="selectedIntento.respuestas_seleccionadas[pregunta.id] === undefined"
                  class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-on-surface/10 text-on-surface/40 shrink-0">
                  Sin responder
                </span>
                <span v-else-if="isCorrect(pregunta, selectedIntento.respuestas_seleccionadas)"
                  class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-green-500/10 text-green-500 flex items-center gap-1 shrink-0">
                  <span class="material-symbols-outlined text-[10px] font-black">check</span> Correcto
                </span>
                <span v-else class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-red-500/10 text-red-500 flex items-center gap-1 shrink-0">
                  <span class="material-symbols-outlined text-[10px] font-black">close</span> Incorrecto
                </span>
              </div>

              <!-- Options -->
              <div class="grid grid-cols-1 gap-2">
                <div
                  v-for="resp in pregunta.respuestas"
                  :key="resp.id"
                  :class="[
                    'flex items-center gap-3 p-3.5 rounded-xl text-xs transition-all border',
                    (resp.es_correcta === true || resp.es_correcta == 1)
                      ? 'bg-green-500/5 border-green-500/20 text-green-400 font-bold'
                      : (Number(selectedIntento.respuestas_seleccionadas[pregunta.id]) === Number(resp.id))
                        ? 'bg-red-500/5 border-red-500/20 text-red-400 font-bold'
                        : 'bg-on-surface/[0.02] border-transparent text-on-surface/50'
                  ]"
                >
                  <span class="material-symbols-outlined text-sm font-black shrink-0"
                    :class="[(resp.es_correcta === true || resp.es_correcta == 1) ? 'text-green-500' : 'text-red-500']">
                    {{
                      (resp.es_correcta === true || resp.es_correcta == 1)
                        ? 'check_circle'
                        : (Number(selectedIntento.respuestas_seleccionadas[pregunta.id]) === Number(resp.id))
                          ? 'cancel'
                          : 'radio_button_unchecked'
                    }}
                  </span>
                  <span class="flex-1 min-w-0">{{ resp.respuesta }}</span>
                  <span
                    v-if="Number(selectedIntento.respuestas_seleccionadas[pregunta.id]) === Number(resp.id)"
                    class="text-[8px] font-black uppercase tracking-wider bg-on-surface/10 px-2 py-0.5 rounded text-on-surface/60 shrink-0"
                  >
                    Elección del estudiante
                  </span>
                </div>
              </div>
            </div>
          </template>
        </div>

        <!-- Modal Footer -->
        <div class="p-6 border-t border-on-surface/5 flex justify-end shrink-0">
          <button @click="showModal = false" class="btn-premium btn-secondary-glass !py-3 !px-6">
            Cerrar Detalle
          </button>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from '@/services/api'

const loading = ref(true)
const intentos = ref([])

// Filters
const filterSearch = ref('')
const filterEstado = ref('')
const filterCurso = ref('')

// Modal
const showModal = ref(false)
const selectedIntento = ref(null)

// ---- fetch ----
const fetchIntentos = async () => {
  loading.value = true
  try {
    const res = await api.get('/intentos-evaluacion')
    intentos.value = res.data
  } catch (e) {
    console.error('Error cargando calificaciones:', e)
  } finally {
    loading.value = false
  }
}



// ---- computed stats ----
const aprobados = computed(() => intentos.value.filter(i => i.aprobado).length)
const reprobados = computed(() => intentos.value.filter(i => !i.aprobado).length)

const cursosUnicos = computed(() => {
  const set = new Set(intentos.value.map(i => i.evaluacion?.curso?.titulo).filter(Boolean))
  return [...set].sort()
})

const intentosFiltrados = computed(() => {
  return intentos.value.filter(i => {
    const nombre = `${i.usuario?.nombres || ''} ${i.usuario?.apellidos || ''} ${i.evaluacion?.titulo || ''}`.toLowerCase()
    const matchSearch = !filterSearch.value || nombre.includes(filterSearch.value.toLowerCase())
    const matchEstado = !filterEstado.value
      || (filterEstado.value === 'aprobado' && i.aprobado)
      || (filterEstado.value === 'reprobado' && !i.aprobado)
    const matchCurso = !filterCurso.value || i.evaluacion?.curso?.titulo === filterCurso.value
    return matchSearch && matchEstado && matchCurso
  })
})

// ---- modal ----
const openDetail = (intento) => {
  selectedIntento.value = intento
  showModal.value = true
}

// ---- helpers ----
const initials = (usuario) => {
  if (!usuario) return '??'
  return `${usuario.nombres?.charAt(0) || ''}${usuario.apellidos?.charAt(0) || ''}`
}

const formatDate = (dt) => {
  if (!dt) return '—'
  return new Date(dt).toLocaleDateString('es-BO', { day: '2-digit', month: 'short', year: 'numeric' })
}

const calcDuration = (start, end) => {
  if (!start || !end) return 'N/A'
  const diff = new Date(end) - new Date(start)
  if (isNaN(diff) || diff < 0) return 'N/A'
  const mins = Math.floor(diff / 60000)
  const secs = Math.floor((diff % 60000) / 1000)
  return mins > 0 ? `${mins}m ${secs}s` : `${secs}s`
}

const isCorrect = (pregunta, respuestas) => {
  const sel = respuestas[pregunta.id]
  if (!sel) return false
  const r = pregunta.respuestas?.find(r => Number(r.id) === Number(sel))
  return r ? (r.es_correcta === true || r.es_correcta == 1) : false
}

const correctCount = computed(() => {
  if (!selectedIntento.value?.respuestas_seleccionadas || !selectedIntento.value?.evaluacion?.preguntas) return 0
  return selectedIntento.value.evaluacion.preguntas.filter(p =>
    isCorrect(p, selectedIntento.value.respuestas_seleccionadas)
  ).length
})

onMounted(fetchIntentos)
</script>

<style scoped>
.custom-scrollbar::-webkit-scrollbar { width: 4px; }
.custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
.custom-scrollbar::-webkit-scrollbar-thumb { background: rgba(var(--accent-neon-rgb, 100 255 218), 0.15); border-radius: 10px; }
</style>
