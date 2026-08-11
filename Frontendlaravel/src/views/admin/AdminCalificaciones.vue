<template>
  <div class="space-y-8 animate-fade-in text-on-surface">
    <!-- Header -->
    <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
      <div>
        <p class="text-[10px] font-black uppercase tracking-[0.28em] text-accent-neon mb-2">
          Módulo Académico
        </p>
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
          <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/40">
            Total Intentos
          </p>
          <p class="text-2xl font-black text-on-surface mt-1">
            {{ intentos.length }}
          </p>
        </div>
        <div class="glass-card px-5 py-4 rounded-2xl text-center">
          <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/40">
            Aprobados
          </p>
          <p class="text-2xl font-black text-green-500 mt-1">{{ aprobados }}</p>
        </div>
        <div class="glass-card px-5 py-4 rounded-2xl text-center">
          <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/40">
            Reprobados
          </p>
          <p class="text-2xl font-black text-red-500 mt-1">{{ reprobados }}</p>
        </div>
      </div>
      <div class="flex flex-wrap items-center gap-2 sm:gap-4">
        <!-- CÁPSULA COMPACTA DE EXPORTACIÓN (ADAPTATIVA LUZ/OSCURO) -->
        <div
          class="flex items-center gap-2 bg-slate-200/50 dark:bg-white/5 p-1 rounded-2xl border border-slate-300/60 dark:border-white/10 shadow-sm dark:shadow-inner transition-colors duration-300">
          <!-- BOTÓN EXCEL -->
          <button @click="exportData('excel')" :disabled="exportStatus.excel !== 'idle'"
            class="relative h-10 px-3 sm:px-4 rounded-xl hover:bg-emerald-500/15 dark:hover:bg-amber-500/20 text-slate-700 dark:text-white/80 hover:text-emerald-600 dark:hover:text-amber-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] sm:text-xs tracking-wider transition-all flex items-center justify-center min-w-[70px] sm:min-w-[85px] overflow-hidden"
            title="Exportar a Excel">
            <div v-if="exportStatus.excel === 'idle'" class="flex items-center gap-1.5 transition-all">
              <span class="material-symbols-outlined text-[18px]">table_view</span>
              <span class="hidden sm:inline">XLS</span>
            </div>
            <span v-else-if="exportStatus.excel === 'loading'"
              class="material-symbols-outlined text-[18px] animate-spin text-emerald-600 dark:text-amber-400">sync</span>
            <span v-else-if="exportStatus.excel === 'success'"
              class="material-symbols-outlined text-[22px] text-emerald-500 animate-bounce">check_circle</span>
          </button>

          <!-- DIVISOR VERTICAL PARA MODO CLARO Y OSCURO -->
          <div class="h-5 w-[1px] bg-slate-300 dark:bg-white/10"></div>

          <!-- BOTÓN PDF -->
          <button @click="exportData('pdf')" :disabled="exportStatus.pdf !== 'idle'"
            class="relative h-10 px-3 sm:px-4 rounded-xl hover:bg-rose-500/15 dark:hover:bg-rose-500/20 text-slate-700 dark:text-white/80 hover:text-rose-600 dark:hover:text-rose-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] sm:text-xs tracking-wider transition-all flex items-center justify-center min-w-[70px] sm:min-w-[85px] overflow-hidden"
            title="Exportar a PDF">
            <div v-if="exportStatus.pdf === 'idle'" class="flex items-center gap-1.5 transition-all">
              <span class="material-symbols-outlined text-[18px]">picture_as_pdf</span>
              <span class="hidden sm:inline">PDF</span>
            </div>
            <span v-else-if="exportStatus.pdf === 'loading'"
              class="material-symbols-outlined text-[18px] animate-spin text-rose-600 dark:text-rose-400">sync</span>
            <span v-else-if="exportStatus.pdf === 'success'"
              class="material-symbols-outlined text-[22px] text-emerald-500 animate-bounce">check_circle</span>
          </button>
        </div>

        <!-- BOTÓN ACTUALIZAR -->
        <button @click="fetchIntentos"
          class="btn-premium btn-secondary-glass !py-3 px-6 group/btn relative overflow-hidden shadow-md dark:shadow-xl hover:shadow-accent-neon/20 transition-all duration-500 active:scale-95 flex items-center gap-2">
          <span
            class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-180 duration-500 relative"
            :class="{ 'animate-spin': loading }">refresh</span>
          <span class="relative font-bold">Actualizar</span>
        </button>
      </div>
    </div>

    <!-- Filters -->
    <div class="glass-card p-6 rounded-[32px] flex flex-col sm:flex-row gap-4">
      <!-- Search by student -->
      <div class="relative flex-1">
        <span
          class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-on-surface/30 text-[18px]">search</span>
        <input v-model="filterSearch" type="text" placeholder="Buscar estudiante o evaluación..."
          class="w-full bg-on-surface/[0.04] rounded-2xl py-3 pl-10 pr-4 text-xs font-bold focus:outline-none focus:ring-1 focus:ring-accent-neon/40 transition-all" />
      </div>
      <!-- Filter by estado -->
      <select v-model="filterEstado"
        class="bg-on-surface/[0.04] rounded-2xl py-3 px-4 text-xs font-bold focus:outline-none focus:ring-1 focus:ring-accent-neon/40 transition-all min-w-[160px]">
        <option value="">Todos los estados</option>
        <option value="aprobado">Aprobado</option>
        <option value="reprobado">Reprobado</option>
      </select>
      <!-- Filter by course -->
      <select v-model="filterCurso"
        class="bg-on-surface/[0.04] rounded-2xl py-3 px-4 text-xs font-bold focus:outline-none focus:ring-1 focus:ring-accent-neon/40 transition-all min-w-[180px]">
        <option value="">Todos los cursos</option>
        <option v-for="curso in cursosUnicos" :key="curso" :value="curso">
          {{ curso }}
        </option>
      </select>
    </div>

    <!-- Table -->
    <div class="glass-card-premium rounded-[20px] overflow-hidden shadow-2xl relative min-h-[400px] !border-none">
      <div v-if="loading"
        class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
        <div
          class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4">
        </div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">
          Cargando calificaciones...
        </p>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full min-w-[900px] text-left border-separate border-spacing-0">
          <thead>
            <tr class="border-b border-on-surface/5">
              <th class="px-8 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">
                Estudiante
              </th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">
                Evaluación / Curso
              </th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">
                Nota
              </th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">
                Estado
              </th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">
                Fecha
              </th>
              <th class="px-6 pb-5 pt-8 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-right">
                Detalle
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="intento in intentosFiltrados" :key="intento.id"
              class="group border-b border-on-surface/5 hover:bg-on-surface/[0.03] transition-colors">
              <!-- Estudiante -->
              <td class="px-8 py-5">
                <div class="flex items-center gap-3">
                  <div
                    class="h-9 w-9 rounded-xl bg-gradient-to-br from-accent-neon/20 to-accent-solar/20 flex items-center justify-center text-xs font-black text-accent-neon shrink-0">
                    {{ initials(intento.usuario) }}
                  </div>
                  <div>
                    <p class="text-xs font-black text-on-surface group-hover:text-accent-neon transition-colors">
                      {{ intento.usuario?.nombres }}
                      {{ intento.usuario?.apellidos }}
                    </p>
                    <p class="text-[10px] text-on-surface/40 font-bold">
                      {{ intento.usuario?.correo }}
                    </p>
                  </div>
                </div>
              </td>
              <!-- Evaluación -->
              <td class="px-6 py-5">
                <p class="text-xs font-black text-on-surface">
                  {{ intento.evaluacion?.titulo }}
                </p>
                <p class="text-[10px] text-on-surface/40 font-bold mt-0.5">
                  {{ intento.evaluacion?.curso?.titulo || "—" }}
                </p>
              </td>
              <!-- Nota -->
              <td class="px-6 py-5">
                <span :class="[
                  'text-sm font-black',
                  intento.aprobado ? 'text-green-500' : 'text-red-500',
                ]">
                  {{ Math.round(intento.nota || 0) }}%
                </span>
              </td>
              <!-- Estado -->
              <td class="px-6 py-5">
                <span :class="[
                  'px-3 py-1 text-[9px] font-black rounded-full uppercase tracking-widest',
                  intento.aprobado
                    ? 'bg-green-500/10 text-green-500'
                    : 'bg-red-500/10 text-red-500',
                ]">
                  {{ intento.aprobado ? "Aprobado" : "Reprobado" }}
                </span>
              </td>
              <!-- Fecha -->
              <td class="px-6 py-5 text-[10px] text-on-surface/40 font-bold uppercase">
                {{ formatDate(intento.fecha_fin || intento.fecha_inicio) }}
              </td>
              <!-- Detalle -->
              <td class="px-6 py-5 text-right">
                <button @click="openDetail(intento)"
                  class="px-3 py-1.5 bg-accent-neon/10 text-accent-neon text-[9px] font-black rounded-lg hover:bg-accent-neon hover:text-primary transition-all uppercase tracking-wider">
                  Ver Respuestas
                </button>
              </td>
            </tr>
            <tr v-if="!intentosFiltrados.length">
              <td colspan="6" class="px-8 py-20 text-center text-on-surface/20">
                <span class="material-symbols-outlined text-4xl mb-3 block">search_off</span>
                <p class="text-[10px] font-black uppercase tracking-widest">
                  Sin resultados
                </p>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- ===================== DETAIL MODAL (TELEPORTED TO BODY) ===================== -->
    <Teleport to="body">
      <div v-if="showModal && selectedIntento"
        class="fixed inset-0 bg-background/90 backdrop-blur-xl z-[9999] flex items-center justify-center p-4">
        <div
          class="bg-surface-container max-w-4xl w-full max-h-[90vh] flex flex-col rounded-[32px] overflow-hidden shadow-2xl relative border border-white/5 bg-opacity-95">
          
          <!-- Modal Header -->
          <div class="px-6 py-4 md:px-8 md:py-5 flex items-center justify-between shrink-0 bg-transparent border-b border-white/5">
            <div>
              <h3 class="text-lg md:text-xl font-black text-on-surface font-lexend tracking-tight">
                {{ selectedIntento.usuario?.nombres }}
                {{ selectedIntento.usuario?.apellidos }}
                <span class="text-gradient-neon">
                  — {{ selectedIntento.evaluacion?.titulo }}</span>
              </h3>
              <p class="text-[11px] text-on-surface/50 mt-0.5 uppercase font-bold tracking-wider">
                {{
                  formatDate(
                    selectedIntento.fecha_fin || selectedIntento.fecha_inicio,
                  )
                }}
                · Duración:
                {{
                  calcDuration(
                    selectedIntento.fecha_inicio,
                    selectedIntento.fecha_fin,
                  )
                }}
              </p>
            </div>
            <button @click="showModal = false"
              class="w-9 h-9 rounded-xl bg-white/5 flex items-center justify-center text-on-surface/60 hover:bg-red-500/20 hover:text-red-400 transition-all border border-white/5">
              <span class="material-symbols-outlined text-sm">close</span>
            </button>
          </div>

          <!-- Summary badges (Optimizado y Compacto) -->
          <div class="px-6 py-3.5 md:px-8 grid grid-cols-2 sm:grid-cols-4 gap-3 shrink-0 bg-transparent border-b border-white/5">
            <div class="bg-background/40 rounded-xl p-3 border border-white/5 shadow-inner">
              <p class="text-[8px] font-black text-on-surface/40 uppercase tracking-widest">
                Nota
              </p>
              <p :class="[
                'text-xl font-black mt-0.5',
                selectedIntento.aprobado ? 'text-green-400' : 'text-red-400',
              ]">
                {{ Math.round(selectedIntento.nota || 0) }}%
              </p>
            </div>
            <div class="bg-background/40 rounded-xl p-3 border border-white/5 shadow-inner">
              <p class="text-[8px] font-black text-on-surface/40 uppercase tracking-widest">
                Aprobación mín.
              </p>
              <p class="text-xl font-black text-on-surface mt-0.5">
                {{
                  Math.round(selectedIntento.evaluacion?.nota_aprobacion || 0)
                }}%
              </p>
            </div>
            <div class="bg-background/40 rounded-xl p-3 border border-white/5 shadow-inner flex flex-col justify-center">
              <p class="text-[8px] font-black text-on-surface/40 uppercase tracking-widest">
                Estado
              </p>
              <div>
                <span :class="[
                  'inline-block mt-1 px-2.5 py-0.5 text-[8px] font-black rounded-full uppercase tracking-widest',
                  selectedIntento.aprobado
                    ? 'bg-green-500/10 text-green-400 border border-green-500/20'
                    : 'bg-red-500/10 text-red-400 border border-red-500/20',
                ]">
                  {{ selectedIntento.aprobado ? "Aprobado" : "Reprobado" }}
                </span>
              </div>
            </div>
            <div class="bg-background/40 rounded-xl p-3 border border-white/5 shadow-inner">
              <p class="text-[8px] font-black text-on-surface/40 uppercase tracking-widest">
                Correctas
              </p>
              <p class="text-xl font-black text-accent-neon mt-0.5">
                {{ correctCount }}/{{
                  selectedIntento.evaluacion?.preguntas?.length || 0
                }}
              </p>
            </div>
          </div>

          <!-- Questions breakdown -->
          <div class="flex-1 overflow-y-auto p-6 md:p-8 space-y-5 custom-scrollbar bg-background/20">
            <!-- No answers stored -->
            <div v-if="!selectedIntento.respuestas_seleccionadas"
              class="text-center py-14 bg-yellow-500/5 rounded-2xl border border-yellow-500/10">
              <span class="material-symbols-outlined text-yellow-500 text-4xl mb-3">warning</span>
              <p class="text-xs font-black text-yellow-500 uppercase tracking-widest">
                Detalle no disponible
              </p>
              <p class="text-xs text-on-surface/40 mt-2 max-w-md mx-auto">
                Este intento fue realizado antes de la actualización que guarda
                las respuestas del estudiante.
              </p>
            </div>

            <template v-else>
              <h4 class="text-xs font-black text-on-surface uppercase tracking-widest opacity-80">
                Desglose de preguntas
              </h4>

              <div v-for="(pregunta, qIdx) in selectedIntento.evaluacion?.preguntas" :key="pregunta.id"
                class="p-5 rounded-[20px] bg-surface-container border border-white/5 space-y-3 shadow-lg">
                <div class="flex items-start justify-between gap-4">
                  <div class="flex-1">
                    <span class="text-[10px] font-black text-accent-neon uppercase tracking-wider">
                      Pregunta {{ qIdx + 1 }} ({{ pregunta.puntos }} pts)
                    </span>
                    <h5 class="text-xs md:text-sm font-bold text-on-surface mt-0.5 leading-relaxed">
                      {{ pregunta.pregunta }}
                    </h5>
                  </div>
                  <!-- Correct / Incorrect / No answer badge -->
                  <span v-if="
                    selectedIntento.respuestas_seleccionadas[pregunta.id] ===
                    undefined
                  "
                    class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-white/5 text-on-surface/50 shrink-0 border border-white/5">
                    Sin responder
                  </span>
                  <span v-else-if="
                    isCorrect(
                      pregunta,
                      selectedIntento.respuestas_seleccionadas,
                    )
                  "
                    class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-green-500/10 text-green-400 flex items-center gap-1 shrink-0 border border-green-500/20">
                    <span class="material-symbols-outlined text-[10px] font-black">check</span>
                    Correcto
                  </span>
                  <span v-else
                    class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-red-500/10 text-red-400 flex items-center gap-1 shrink-0 border border-red-500/20">
                    <span class="material-symbols-outlined text-[10px] font-black">close</span>
                    Incorrecto
                  </span>
                </div>

                <!-- Options -->
                <div class="grid grid-cols-1 gap-2">
                  <div v-for="resp in pregunta.respuestas" :key="resp.id" :class="[
                    'flex items-center gap-3 p-3 rounded-xl text-xs transition-all border',
                    resp.es_correcta === true || resp.es_correcta == 1
                      ? 'bg-green-500/10 border-green-500/20 text-green-300 font-bold'
                      : Number(
                          selectedIntento.respuestas_seleccionadas[
                          pregunta.id
                          ],
                        ) === Number(resp.id)
                        ? 'bg-red-500/10 border-red-500/20 text-red-300 font-bold'
                        : 'bg-background/40 border-white/5 text-on-surface/50',
                  ]">
                    <span class="material-symbols-outlined text-sm font-black shrink-0" :class="[
                      resp.es_correcta === true || resp.es_correcta == 1
                        ? 'text-green-400'
                        : Number(
                            selectedIntento.respuestas_seleccionadas[
                            pregunta.id
                            ],
                          ) === Number(resp.id)
                          ? 'text-red-400'
                          : 'text-on-surface/30',
                    ]">
                      {{
                        resp.es_correcta === true || resp.es_correcta == 1
                          ? "check_circle"
                          : Number(
                              selectedIntento.respuestas_seleccionadas[
                              pregunta.id
                              ],
                            ) === Number(resp.id)
                            ? "cancel"
                            : "radio_button_unchecked"
                      }}
                    </span>
                    <span class="flex-1 min-w-0">{{ resp.respuesta }}</span>
                    <span v-if="
                      Number(
                        selectedIntento.respuestas_seleccionadas[pregunta.id],
                      ) === Number(resp.id)
                    "
                      class="text-[8px] font-black uppercase tracking-wider bg-white/10 px-2 py-0.5 rounded text-on-surface/80 shrink-0 border border-white/5">
                      Elección del estudiante
                    </span>
                  </div>
                </div>
              </div>
            </template>
          </div>

          <!-- Modal Footer -->
          <div class="p-4 md:p-5 bg-transparent border-t border-white/5 flex justify-between items-center shrink-0">
            <div
              class="flex items-center gap-2 bg-background/40 p-1 rounded-xl border border-white/5 shadow-inner">
              <button @click="exportIndividualPDF" :disabled="exportStatus.individualPdf !== 'idle'"
                class="relative h-9 px-3 rounded-lg hover:bg-rose-500/15 text-on-surface/80 hover:text-rose-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] tracking-wider transition-all flex items-center justify-center min-w-[70px] overflow-hidden border border-white/5"
                title="Exportar PDF Individual">
                <div v-if="exportStatus.individualPdf === 'idle'" class="flex items-center gap-1.5 transition-all">
                  <span class="material-symbols-outlined text-[16px]">picture_as_pdf</span>
                  <span class="hidden sm:inline">PDF</span>
                </div>
                <span v-else-if="exportStatus.individualPdf === 'loading'"
                  class="material-symbols-outlined text-[16px] animate-spin text-rose-400">sync</span>
                <span v-else-if="exportStatus.individualPdf === 'success'"
                  class="material-symbols-outlined text-[18px] text-emerald-400 animate-bounce">check_circle</span>
              </button>
            </div>
            <button @click="showModal = false"
              class="py-2.5 px-5 rounded-xl bg-white/5 hover:bg-white/10 text-on-surface text-xs font-black uppercase tracking-wider border border-white/10 transition-all active:scale-95 shadow-lg">
              Cerrar Detalle
            </button>
          </div>

        </div>
      </div>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, computed, onMounted,watch } from "vue";
import api from "@/services/api";
import ExcelJS from "exceljs";
import { saveAs } from "file-saver";
import pdfMake from "pdfmake/build/pdfmake";
import * as pdfFonts from "pdfmake/build/vfs_fonts";

pdfMake.vfs = pdfFonts.pdfMake ? pdfFonts.pdfMake.vfs : pdfMake.vfs;

const loading = ref(true);
const intentos = ref([]);

// Filters
const filterSearch = ref("");
const filterEstado = ref("");
const filterCurso = ref("");

// Modal
const showModal = ref(false);
const selectedIntento = ref(null);

const exportStatus = ref({
  pdf: "idle",
  excel: "idle",
  individualPdf: 'idle'
});

watch(showModal, (isOpen) => {
  if (isOpen) {
    document.body.classList.add('overflow-hidden');
  } else {
    document.body.classList.remove('overflow-hidden');
  }
});

// ---- fetch ----
const fetchIntentos = async () => {
  loading.value = true;
  try {
    const res = await api.get("/intentos-evaluacion");
    intentos.value = res.data;
  } catch (e) {
    console.error("Error cargando calificaciones:", e);
  } finally {
    loading.value = false;
  }
};

// ---- computed stats ----
const aprobados = computed(
  () => intentos.value.filter((i) => i.aprobado).length,
);
const reprobados = computed(
  () => intentos.value.filter((i) => !i.aprobado).length,
);

const cursosUnicos = computed(() => {
  const set = new Set(
    intentos.value.map((i) => i.evaluacion?.curso?.titulo).filter(Boolean),
  );
  return [...set].sort();
});

const intentosFiltrados = computed(() => {
  return intentos.value.filter((i) => {
    const nombre =
      `${i.usuario?.nombres || ""} ${i.usuario?.apellidos || ""} ${i.evaluacion?.titulo || ""}`.toLowerCase();
    const matchSearch =
      !filterSearch.value || nombre.includes(filterSearch.value.toLowerCase());
    const matchEstado =
      !filterEstado.value ||
      (filterEstado.value === "aprobado" && i.aprobado) ||
      (filterEstado.value === "reprobado" && !i.aprobado);
    const matchCurso =
      !filterCurso.value || i.evaluacion?.curso?.titulo === filterCurso.value;
    return matchSearch && matchEstado && matchCurso;
  });
});

// ---- modal ----
const openDetail = (intento) => {
  selectedIntento.value = intento;
  showModal.value = true;
};

// ---- helpers ----
const initials = (usuario) => {
  if (!usuario) return "??";
  return `${usuario.nombres?.charAt(0) || ""}${usuario.apellidos?.charAt(0) || ""}`;
};

const formatDate = (dt) => {
  if (!dt) return "—";
  return new Date(dt).toLocaleDateString("es-BO", {
    day: "2-digit",
    month: "short",
    year: "numeric",
  });
};

const calcDuration = (start, end) => {
  if (!start || !end) return "N/A";
  const diff = new Date(end) - new Date(start);
  if (isNaN(diff) || diff < 0) return "N/A";
  const mins = Math.floor(diff / 60000);
  const secs = Math.floor((diff % 60000) / 1000);
  return mins > 0 ? `${mins}m ${secs}s` : `${secs}s`;
};

const isCorrect = (pregunta, respuestas) => {
  const sel = respuestas[pregunta.id];
  if (!sel) return false;
  const r = pregunta.respuestas?.find((r) => Number(r.id) === Number(sel));
  return r ? r.es_correcta === true || r.es_correcta == 1 : false;
};

const correctCount = computed(() => {
  if (
    !selectedIntento.value?.respuestas_seleccionadas ||
    !selectedIntento.value?.evaluacion?.preguntas
  )
    return 0;
  return selectedIntento.value.evaluacion.preguntas.filter((p) =>
    isCorrect(p, selectedIntento.value.respuestas_seleccionadas),
  ).length;
});

// Función auxiliar para cargar logos locales y convertirlos a PNG Base64 real
const loadLogoToPngBase64 = (url) => {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.crossOrigin = "Anonymous";
    img.onload = () => {
      const canvas = document.createElement("canvas");
      canvas.width = img.width;
      canvas.height = img.height;
      const ctx = canvas.getContext("2d");
      ctx.drawImage(img, 0, 0);
      resolve(canvas.toDataURL("image/png"));
    };
    img.onerror = (e) => reject(e);
    img.src = url;
  });
};

// Helper seguro para convertir SVG a PNG Base64 para el pie de página
const svgToPngBase64 = (svgString, width = 24, height = 24) => {
  return new Promise((resolve) => {
    const encoded = encodeURIComponent(svgString);
    const img = new Image();
    img.crossOrigin = 'Anonymous';
    img.onload = () => {
      const canvas = document.createElement('canvas');
      canvas.width = width;
      canvas.height = height;
      const ctx = canvas.getContext('2d');
      ctx.clearRect(0, 0, width, height);
      ctx.drawImage(img, 0, 0, width, height);
      resolve(canvas.toDataURL('image/png'));
    };
    img.onerror = () => resolve(null);
    img.src = `data:image/svg+xml;charset=utf-8,${encoded}`;
  });
};

const exportIndividualPDF = async () => {
  if (!selectedIntento.value) return;
  if (exportStatus.value.individualPdf !== 'idle') return;

  exportStatus.value.individualPdf = 'loading';
  const pageWidth = 595.28; // Ancho A4 Portrait en puntos
  const usableWidth = pageWidth - 80; // Márgenes de 40 izquierdo y derecho

  try {
    await new Promise(r => setTimeout(r, 600));

    // 1. Cargar logotipo
    let logoDataUrl = null;
    try {
      const logoPath = `${import.meta.env.BASE_URL}logo-dark.webp`.replace(/\/+/g, '/');
      logoDataUrl = await loadLogoToPngBase64(logoPath);
    } catch (e) {
      console.warn("No se pudo cargar logo", e);
    }

    // 2. Cargar íconos institucionales para cabecera y pie
    const [iconLoc, iconPhone, iconWeb, iconRecycle, iconEmail, iconWsp, iconIn] = await Promise.all([
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#7F8C8D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="7 10 12 5 17 10"/><line x1="12" y1="5" x2="12" y2="22"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14.5v-5h2v5h-2zm0-7v-2h2v2h-2z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M.057 24l1.687-6.163c-1.041-1.804-1.588-3.849-1.587-5.946.003-6.556 5.338-11.891 11.893-11.891 3.181.001 6.167 1.24 8.413 3.488 2.245 2.248 3.481 5.236 3.48 8.414-.003 6.557-5.338 11.892-11.893 11.892-1.99-.001-3.951-.5-5.688-1.448l-6.305 1.654zm6.597-3.807c1.676.995 3.276 1.591 5.392 1.592 5.448 0 9.886-4.434 9.889-9.885.002-5.462-4.415-9.89-9.881-9.892-5.452 0-9.887 4.434-9.889 9.884-.001 2.225.651 3.891 1.746 5.634l-.999 3.648 3.742-.981z"/></svg>'),
      svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/><rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/></svg>')
    ]);

    // 3. Estructura de la Cabecera Institucional
    const contactInfo = [
      { text: 'Oficina Central y Centro Demostrativo:', bold: true, fontSize: 7.5, color: '#2C3E50' },
      { text: 'Calle Condorini, N° 118, zona Anari, Marquirivi - GAMEP Achocalla, La Paz, Bolivia', fontSize: 7.5, color: '#2C3E50', margin: [0, 1, 0, 3] },
      { 
        columns: [
          ...(iconPhone ? [{ image: iconPhone, width: 9, height: 9, margin: [0, 1, 3, 0] }] : []),
          { text: '+591 732 36591  |  boris.ardaya@enervida.info', fontSize: 7.5, color: '#2C3E50' }
        ],
        columnGap: 4
      }
    ];

    const headerConfig = {
      columns: [
        {
          columns: [
            ...(iconLoc ? [{ image: iconLoc, width: 10, height: 10, margin: [0, 1, 4, 0] }] : []),
            { stack: contactInfo }
          ],
          width: '65%',
          alignment: 'left'
        },
        ...(logoDataUrl ? [{ image: logoDataUrl, width: 130, alignment: 'right', margin: [0, 5, 0, 0] }] : [])
      ],
      margin: [40, 25, 40, 0]
    };

    const dividerLine = {
      canvas: [{ type: 'line', x1: 0, y1: 0, x2: usableWidth, y2: 0, lineWidth: 1.5, lineColor: '#E67E22' }],
      margin: [40, 8, 40, 15]
    };

    // 4. Pie de página institucional
    const socialIconsRow = [
      ...(iconEmail ? [{ image: iconEmail, width: 13, height: 13, link: 'mailto:boris.ardaya@enervida.info' }] : []),
      { text: '|', color: '#7EA172', fontSize: 10, margin: [2, 0, 2, 0] },
      ...(iconWeb ? [{ image: iconWeb, width: 13, height: 13, link: 'https://www.enervida.info' }] : []),
      { text: '|', color: '#7EA172', fontSize: 10, margin: [2, 0, 2, 0] },
      ...(iconWsp ? [{ image: iconWsp, width: 13, height: 13, link: 'https://wa.me/59173236591' }] : []),
      { text: '|', color: '#7EA172', fontSize: 10, margin: [2, 0, 2, 0] },
      ...(iconIn ? [{ image: iconIn, width: 13, height: 13, link: 'https://linkedin.com/company/enervida' }] : [])
    ];

    const footerConfig = (currentPage, pageCount) => ({
      stack: [
        {
          canvas: [{ type: 'line', x1: 0, y1: 0, x2: usableWidth, y2: 0, lineWidth: 1.5, lineColor: '#E67E22' }],
          margin: [40, 0, 40, 6]
        },
        {
          columns: [
            {
              columns: [
                ...(iconRecycle ? [{ image: iconRecycle, width: 11, height: 11, margin: [0, 0, 4, 0] }] : []),
                { text: 'Utilizamos papel de reciclaje para contribuir a la ODS 13 – Acción por el clima.', fontSize: 7.5, color: '#2C3E50' }
              ],
              width: '*',
              alignment: 'left'
            },
            {
              text: `Página | ${currentPage}`,
              alignment: 'right',
              fontSize: 8,
              bold: true,
              color: '#2C3E50',
              width: 'auto'
            }
          ],
          margin: [40, 0, 40, 4]
        },
        {
          columns: socialIconsRow,
          columnGap: 6,
          alignment: 'center',
          margin: [40, 0, 40, 10]
        }
      ]
    });

    const intento = selectedIntento.value;
    const notaFinal = Math.round(intento.nota || 0) + '%';
    const notaMinima = Math.round(intento.evaluacion?.nota_aprobacion || 0) + '%';
    const estado = intento.aprobado ? 'APROBADO' : 'REPROBADO';
    const colorEstado = intento.aprobado ? '#27AE60' : '#E74C3C';
    const correctas = correctCount.value;
    const totalPreguntas = intento.evaluacion?.preguntas?.length || 0;

    const docDefinition = {
      pageSize: 'A4',
      pageOrientation: 'portrait',
      pageMargins: [40, 105, 40, 75],
      header: headerConfig,
      content: [
        dividerLine,
        { text: 'REPORTE DE CALIFICACIÓN OFICIAL', style: 'pdfTitle', alignment: 'center' },
        { text: `Fecha de emisión: ${new Date().toLocaleDateString('es-BO')}`, style: 'pdfSubtitle', alignment: 'center', margin: [0, 2, 0, 15] },

        // Datos del Estudiante y Curso
        {
          style: 'tableExample',
          table: {
            widths: ['50%', '50%'],
            body: [
              [
                { text: 'Estudiante', style: 'tableHeader' },
                { text: 'Curso / Evaluación', style: 'tableHeader' }
              ],
              [
                {
                  stack: [
                    { text: `${intento.usuario?.nombres || ''} ${intento.usuario?.apellidos || ''}`, bold: true },
                    { text: intento.usuario?.correo || '', color: '#7F8C8D', fontSize: 9.5 }
                  ]
                },
                {
                  stack: [
                    { text: intento.evaluacion?.curso?.titulo || '—', bold: true },
                    { text: intento.evaluacion?.titulo || '', color: '#7F8C8D', fontSize: 9.5 }
                  ]
                }
              ],
              [
                { text: 'Fecha del Intento', style: 'tableHeader' },
                { text: 'Duración', style: 'tableHeader' }
              ],
              [
                { text: formatDate(intento.fecha_fin || intento.fecha_inicio), bold: true },
                { text: calcDuration(intento.fecha_inicio, intento.fecha_fin), bold: true }
              ]
            ]
          },
          layout: 'lightHorizontalLines'
        },
        { text: '', margin: [0, 0, 0, 15] },

        // Resumen de Calificación
        {
          table: {
            widths: ['*', '*', '*'],
            body: [
              [
                { text: 'Nota Final', style: 'metricLabel' },
                { text: 'Nota Mínima', style: 'metricLabel' },
                { text: 'Estado', style: 'metricLabel' }
              ],
              [
                { text: notaFinal, style: 'metricValue', color: colorEstado },
                { text: notaMinima, style: 'metricValue' },
                { text: estado, style: 'metricValue', color: colorEstado }
              ]
            ]
          },
          layout: {
            defaultBorder: false,
            fillColor: (rowIndex) => (rowIndex === 0 ? '#F8F9FA' : null)
          },
          margin: [0, 0, 0, 20]
        },

        // Detalles de la evaluación
        { text: 'Detalles Estadísticos', style: 'sectionTitle' },
        {
          table: {
            widths: ['*', '*'],
            body: [
              [
                { text: 'Métrica', style: 'tableHeader' },
                { text: 'Resultado', style: 'tableHeader', alignment: 'right' }
              ],
              ['Preguntas Correctas', { text: `${correctas} / ${totalPreguntas}`, alignment: 'right', bold: true }],
              ['Porcentaje Obtenido', { text: notaFinal, alignment: 'right', bold: true }],
              ['Resultado Académico', { text: estado, alignment: 'right', bold: true, color: colorEstado }]
            ]
          },
          layout: 'lightHorizontalLines',
          margin: [0, 0, 0, 40]
        },

        // Firmas
        {
          columns: [
            {
              stack: [
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 180, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] },
                { text: 'Firma del Estudiante', bold: true, margin: [0, 5, 0, 0], fontSize: 9 },
                { text: 'CI / Identificación', fontSize: 8, color: '#7F8C8D' }
              ],
              alignment: 'center'
            },
            {
              stack: [
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 180, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] },
                { text: 'Firma Autorizada', bold: true, margin: [0, 5, 0, 0], fontSize: 9 },
                { text: 'Director Académico', fontSize: 8, color: '#7F8C8D' }
              ],
              alignment: 'center'
            }
          ]
        }
      ],
      styles: {
        pdfTitle: { fontSize: 14, bold: true, color: '#2C3E50' },
        pdfSubtitle: { fontSize: 8.5, italics: true, color: '#7F8C8D' },
        tableHeader: { fontSize: 8.5, bold: true, color: '#7F8C8D', margin: [0, 4, 0, 4] },
        metricLabel: { fontSize: 8.5, bold: true, color: '#7F8C8D', alignment: 'center', margin: [0, 8, 0, 4] },
        metricValue: { fontSize: 20, bold: true, color: '#2C3E50', alignment: 'center', margin: [0, 4, 0, 10] },
        sectionTitle: { fontSize: 11, bold: true, color: '#2C3E50', margin: [0, 0, 0, 8] }
      },
      footer: footerConfig
    };

    exportStatus.value.individualPdf = 'success';
    setTimeout(async () => {
      pdfMake.createPdf(docDefinition).download(`Boleta_Calificacion_${intento.usuario?.nombres || 'Estudiante'}.pdf`);
      setTimeout(() => {
        exportStatus.value.individualPdf = 'idle';
      }, 500);
    }, 1200);

  } catch (error) {
    console.error("Error al exportar PDF individual:", error);
    exportStatus.value.individualPdf = 'idle';
  }
};

const exportData = async (format) => {
  if (exportStatus.value[format] !== "idle") return;
  exportStatus.value[format] = "loading";

  try {
    let downloadAction = null;
    await new Promise((r) => setTimeout(r, 600));

    if (format === "excel") {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet("Calificaciones");

      worksheet.columns = [
        { header: "ESTUDIANTE", key: "estudiante", width: 30 },
        { header: "CORREO", key: "correo", width: 25 },
        { header: "CURSO", key: "curso", width: 25 },
        { header: "EVALUACIÓN", key: "evaluacion", width: 25 },
        { header: "NOTA (%)", key: "nota", width: 12 },
        { header: "ESTADO", key: "estado", width: 15 },
        { header: "FECHA", key: "fecha", width: 15 },
      ];

      const headerRow = worksheet.getRow(1);
      headerRow.height = 26;
      headerRow.eachCell((cell) => {
        cell.fill = { type: "pattern", pattern: "solid", fgColor: { argb: "FF2C3E50" } };
        cell.font = { name: "Segoe UI", size: 10, bold: true, color: { argb: "FFFFFFFF" } };
        cell.alignment = { vertical: "middle", horizontal: "center" };
      });

      intentosFiltrados.value.forEach((i) => {
        const isApproved = i.aprobado;
        const row = worksheet.addRow({
          estudiante: `${i.usuario?.nombres || ""} ${i.usuario?.apellidos || ""}`,
          correo: i.usuario?.correo || "",
          curso: i.evaluacion?.curso?.titulo || "—",
          evaluacion: i.evaluacion?.titulo || "",
          nota: Math.round(i.nota || 0),
          estado: isApproved ? "Aprobado" : "Reprobado",
          fecha: formatDate(i.fecha_fin || i.fecha_inicio),
        });

        row.height = 20;
        row.eachCell((cell) => {
          cell.font = { name: "Segoe UI", size: 9 };
          cell.border = { bottom: { style: "thin", color: { argb: "FFE0E0E0" } } };
        });
      });

      downloadAction = async () => {
        const buffer = await workbook.xlsx.writeBuffer();
        const blob = new Blob([buffer], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" });
        saveAs(blob, `Listado_Calificaciones_${Date.now()}.xlsx`);
      };

    } else if (format === "pdf") {
      const pageWidth = 842.89; // Landscape A4
      const usableWidth = pageWidth - 60;

      let logoDataUrl = null;
      try {
        const logoPath = `${import.meta.env.BASE_URL}logo-dark.webp`.replace(/\/+/g, '/');
        logoDataUrl = await loadLogoToPngBase64(logoPath);
      } catch (e) {
        console.warn("No se pudo cargar logo", e);
      }

      const [iconLoc, iconPhone, iconWeb, iconRecycle, iconEmail, iconWsp, iconIn] = await Promise.all([
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#7F8C8D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="7 10 12 5 17 10"/><line x1="12" y1="5" x2="12" y2="22"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14.5v-5h2v5h-2zm0-7v-2h2v2h-2z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M.057 24l1.687-6.163c-1.041-1.804-1.588-3.849-1.587-5.946.003-6.556 5.338-11.891 11.893-11.891 3.181.001 6.167 1.24 8.413 3.488 2.245 2.248 3.481 5.236 3.48 8.414-.003 6.557-5.338 11.892-11.893 11.892-1.99-.001-3.951-.5-5.688-1.448l-6.305 1.654zm6.597-3.807c1.676.995 3.276 1.591 5.392 1.592 5.448 0 9.886-4.434 9.889-9.885.002-5.462-4.415-9.89-9.881-9.892-5.452 0-9.887 4.434-9.889 9.884-.001 2.225.651 3.891 1.746 5.634l-.999 3.648 3.742-.981z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/><rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/></svg>')
      ]);

      const contactInfo = [
        { text: 'Oficina Central y Centro Demostrativo:', bold: true, fontSize: 8, color: '#2C3E50' },
        { text: 'Calle Condorini, N° 118, zona Anari, Marquirivi - GAMEP Achocalla, La Paz, Bolivia', fontSize: 8, color: '#2C3E50', margin: [0, 1, 0, 4] },
        { 
          columns: [
            ...(iconPhone ? [{ image: iconPhone, width: 10, height: 10, margin: [0, 1, 3, 0] }] : []),
            { text: '+591 732 36591  |  boris.ardaya@enervida.info', fontSize: 8, color: '#2C3E50' }
          ],
          columnGap: 4
        }
      ];

      const headerConfig = {
        columns: [
          {
            columns: [
              ...(iconLoc ? [{ image: iconLoc, width: 11, height: 11, margin: [0, 1, 4, 0] }] : []),
              { stack: contactInfo }
            ],
            width: '65%',
            alignment: 'left'
          },
          ...(logoDataUrl ? [{ image: logoDataUrl, width: 150, alignment: 'right', margin: [0, 5, 0, 0] }] : [])
        ],
        margin: [30, 25, 30, 0]
      };

      const dividerLine = {
        canvas: [{ type: 'line', x1: 0, y1: 0, x2: usableWidth, y2: 0, lineWidth: 1.5, lineColor: '#E67E22' }],
        margin: [30, 8, 30, 15]
      };

      const socialIconsRow = [
        ...(iconEmail ? [{ image: iconEmail, width: 15, height: 15, link: 'mailto:boris.ardaya@enervida.info' }] : []),
        { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
        ...(iconWeb ? [{ image: iconWeb, width: 15, height: 15, link: 'https://www.enervida.info' }] : []),
        { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
        ...(iconWsp ? [{ image: iconWsp, width: 15, height: 15, link: 'https://wa.me/59173236591' }] : []),
        { text: '|', color: '#7EA172', fontSize: 11, margin: [2, 0, 2, 0] },
        ...(iconIn ? [{ image: iconIn, width: 15, height: 15, link: 'https://linkedin.com/company/enervida' }] : [])
      ];

      const footerConfig = (currentPage, pageCount) => ({
        stack: [
          {
            canvas: [{ type: 'line', x1: 0, y1: 0, x2: usableWidth, y2: 0, lineWidth: 1.5, lineColor: '#E67E22' }],
            margin: [30, 0, 30, 6]
          },
          {
            columns: [
              {
                columns: [
                  ...(iconRecycle ? [{ image: iconRecycle, width: 12, height: 12, margin: [0, 0, 4, 0] }] : []),
                  { text: 'Utilizamos papel de reciclaje para contribuir a la ODS 13 – Acción por el clima.', fontSize: 8, color: '#2C3E50' }
                ],
                width: '*',
                alignment: 'left'
              },
              {
                text: `Página | ${currentPage}`,
                alignment: 'right',
                fontSize: 8.5,
                bold: true,
                color: '#2C3E50',
                width: 'auto'
              }
            ],
            margin: [30, 0, 30, 4]
          },
          {
            columns: socialIconsRow,
            columnGap: 6,
            alignment: 'center',
            margin: [30, 0, 30, 12]
          }
        ]
      });

      const tableBody = [];
      tableBody.push([
        { text: "ESTUDIANTE", style: "tableHeader" },
        { text: "CORREO", style: "tableHeader" },
        { text: "CURSO", style: "tableHeader" },
        { text: "EVALUACIÓN", style: "tableHeader" },
        { text: "NOTA", style: "tableHeader", alignment: "center" },
        { text: "ESTADO", style: "tableHeader", alignment: "center" },
        { text: "FECHA", style: "tableHeader", alignment: "center" },
      ]);

      intentosFiltrados.value.forEach((i) => {
        const isApproved = i.aprobado;
        tableBody.push([
          { text: `${i.usuario?.nombres || ""} ${i.usuario?.apellidos || ""}`, fontSize: 9, bold: true },
          { text: i.usuario?.correo || "", fontSize: 9, color: "#7F8C8D" },
          { text: i.evaluacion?.curso?.titulo || "—", fontSize: 9 },
          { text: i.evaluacion?.titulo || "", fontSize: 9 },
          { text: Math.round(i.nota || 0) + "%", fontSize: 9, bold: true, alignment: "center", color: isApproved ? "#27AE60" : "#E74C3C" },
          { text: isApproved ? "Aprobado" : "Reprobado", fontSize: 9, bold: true, alignment: "center", color: isApproved ? "#27AE60" : "#E74C3C" },
          { text: formatDate(i.fecha_fin || i.fecha_inicio), fontSize: 9, alignment: "center" },
        ]);
      });

      const docDefinition = {
        pageSize: "A4",
        pageOrientation: "landscape",
        pageMargins: [30, 105, 30, 80],
        header: headerConfig,
        content: [
          dividerLine,
          { text: 'REPORTE GENERAL DE CALIFICACIONES', style: 'pdfTitle', alignment: 'center' },
          { text: `Total Registros: ${intentosFiltrados.value.length}  |  Fecha de emisión: ${new Date().toLocaleDateString("es-BO")}`, style: 'pdfSubtitle', alignment: 'center', margin: [0, 2, 0, 15] },
          {
            table: {
              headerRows: 1,
              widths: ["15%", "17%", "18%", "22%", "8%", "10%", "10%"],
              body: tableBody,
            },
            layout: {
              hLineColor: (i) => (i === 0 || i === 1) ? '#2C3E50' : '#E0E0E0',
              vLineColor: () => '#E0E0E0',
              hLineWidth: (i) => (i === 0 || i === 1) ? 1.5 : 0.5,
              vLineWidth: () => 0.5,
              paddingTop: () => 5,
              paddingBottom: () => 5,
            },
          },
        ],
        styles: {
          pdfTitle: { fontSize: 15, bold: true, color: '#2C3E50' },
          pdfSubtitle: { fontSize: 8.5, italics: true, color: '#95A5A6' },
          tableHeader: { bold: true, fontSize: 9, color: 'white', fillColor: '#2C3E50', alignment: 'center', margin: [0, 4, 0, 4] }
        },
        footer: footerConfig
      };

      downloadAction = async () => {
        pdfMake.createPdf(docDefinition).download(`Listado_Calificaciones_${Date.now()}.pdf`);
      };
    }

    exportStatus.value[format] = "success";
    setTimeout(async () => {
      if (downloadAction) await downloadAction();
      setTimeout(() => {
        exportStatus.value[format] = "idle";
      }, 500);
    }, 1200);

  } catch (e) {
    console.error("Error crítico durante la exportación:", e);
    exportStatus.value[format] = "idle";
  }
};

onMounted(fetchIntentos);
</script>

<style scoped>
.custom-scrollbar::-webkit-scrollbar {
  width: 4px;
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(var(--accent-neon-rgb, 100 255 218), 0.15);
  border-radius: 10px;
}
</style>
