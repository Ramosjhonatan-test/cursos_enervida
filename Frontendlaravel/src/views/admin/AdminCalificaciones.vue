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

    <!-- ===================== DETAIL MODAL ===================== -->
    <div v-if="showModal && selectedIntento"
      class="fixed inset-0 bg-background/80 backdrop-blur-xl z-[250] flex items-center justify-center p-4">
      <div
        class="glass-card max-w-4xl w-full max-h-[90vh] flex flex-col rounded-[32px] overflow-hidden shadow-2xl relative border border-on-surface/10 bg-background">
        <!-- Modal Header -->
        <div class="p-6 md:p-8 border-b border-on-surface/5 flex items-center justify-between shrink-0">
          <div>
            <h3 class="text-xl font-black text-on-surface font-lexend tracking-tight">
              {{ selectedIntento.usuario?.nombres }}
              {{ selectedIntento.usuario?.apellidos }}
              <span class="text-accent-neon">
                — {{ selectedIntento.evaluacion?.titulo }}</span>
            </h3>
            <p class="text-xs text-on-surface/40 mt-1 uppercase font-bold tracking-wider">
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
            class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:bg-red-500/10 hover:text-red-500 transition-all">
            <span class="material-symbols-outlined">close</span>
          </button>
        </div>

        <!-- Summary badges -->
        <div class="px-8 py-5 border-b border-on-surface/5 grid grid-cols-2 sm:grid-cols-4 gap-4 shrink-0">
          <div class="bg-on-surface/5 rounded-2xl p-4">
            <p class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">
              Nota
            </p>
            <p :class="[
              'text-2xl font-black mt-1',
              selectedIntento.aprobado ? 'text-green-500' : 'text-red-500',
            ]">
              {{ Math.round(selectedIntento.nota || 0) }}%
            </p>
          </div>
          <div class="bg-on-surface/5 rounded-2xl p-4">
            <p class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">
              Aprobación mín.
            </p>
            <p class="text-2xl font-black text-on-surface mt-1">
              {{
                Math.round(selectedIntento.evaluacion?.nota_aprobacion || 0)
              }}%
            </p>
          </div>
          <div class="bg-on-surface/5 rounded-2xl p-4">
            <p class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">
              Estado
            </p>
            <span :class="[
              'inline-block mt-2 px-3 py-1 text-[9px] font-black rounded-full uppercase tracking-widest',
              selectedIntento.aprobado
                ? 'bg-green-500/10 text-green-500'
                : 'bg-red-500/10 text-red-500',
            ]">
              {{ selectedIntento.aprobado ? "Aprobado" : "Reprobado" }}
            </span>
          </div>
          <div class="bg-on-surface/5 rounded-2xl p-4">
            <p class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">
              Correctas
            </p>
            <p class="text-2xl font-black text-accent-neon mt-1">
              {{ correctCount }}/{{
                selectedIntento.evaluacion?.preguntas?.length || 0
              }}
            </p>
          </div>
        </div>

        <!-- Questions breakdown -->
        <div class="flex-1 overflow-y-auto p-6 md:p-8 space-y-5 custom-scrollbar">
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
            <h4 class="text-sm font-black text-on-surface uppercase tracking-widest">
              Desglose de preguntas
            </h4>

            <div v-for="(pregunta, qIdx) in selectedIntento.evaluacion?.preguntas" :key="pregunta.id"
              class="p-6 rounded-[20px] bg-on-surface/5 border border-on-surface/5 space-y-4">
              <div class="flex items-start justify-between gap-4">
                <div class="flex-1">
                  <span class="text-[10px] font-black text-accent-neon uppercase tracking-wider">
                    Pregunta {{ qIdx + 1 }} ({{ pregunta.puntos }} pts)
                  </span>
                  <h5 class="text-sm font-bold text-on-surface mt-1 leading-relaxed">
                    {{ pregunta.pregunta }}
                  </h5>
                </div>
                <!-- Correct / Incorrect / No answer badge -->
                <span v-if="
                  selectedIntento.respuestas_seleccionadas[pregunta.id] ===
                  undefined
                "
                  class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-on-surface/10 text-on-surface/40 shrink-0">
                  Sin responder
                </span>
                <span v-else-if="
                  isCorrect(
                    pregunta,
                    selectedIntento.respuestas_seleccionadas,
                  )
                "
                  class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-green-500/10 text-green-500 flex items-center gap-1 shrink-0">
                  <span class="material-symbols-outlined text-[10px] font-black">check</span>
                  Correcto
                </span>
                <span v-else
                  class="px-2.5 py-1 text-[9px] font-black rounded-full uppercase tracking-wider bg-red-500/10 text-red-500 flex items-center gap-1 shrink-0">
                  <span class="material-symbols-outlined text-[10px] font-black">close</span>
                  Incorrecto
                </span>
              </div>

              <!-- Options -->
              <div class="grid grid-cols-1 gap-2">
                <div v-for="resp in pregunta.respuestas" :key="resp.id" :class="[
                  'flex items-center gap-3 p-3.5 rounded-xl text-xs transition-all border',
                  resp.es_correcta === true || resp.es_correcta == 1
                    ? 'bg-green-500/5 border-green-500/20 text-green-400 font-bold'
                    : Number(
                      selectedIntento.respuestas_seleccionadas[
                      pregunta.id
                      ],
                    ) === Number(resp.id)
                      ? 'bg-red-500/5 border-red-500/20 text-red-400 font-bold'
                      : 'bg-on-surface/[0.02] border-transparent text-on-surface/50',
                ]">
                  <span class="material-symbols-outlined text-sm font-black shrink-0" :class="[
                    resp.es_correcta === true || resp.es_correcta == 1
                      ? 'text-green-500'
                      : 'text-red-500',
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
                    class="text-[8px] font-black uppercase tracking-wider bg-on-surface/10 px-2 py-0.5 rounded text-on-surface/60 shrink-0">
                    Elección del estudiante
                  </span>
                </div>
              </div>
            </div>
          </template>
        </div>

        <!-- Modal Footer -->
        <div class="p-6 border-t border-slate-200/60 dark:border-white/5 flex justify-between items-center shrink-0">
          <div
            class="flex items-center gap-2 bg-slate-200/50 dark:bg-white/5 p-1 rounded-2xl border border-slate-300/60 dark:border-white/10 shadow-sm dark:shadow-inner transition-colors duration-300">
            <button @click="exportIndividualPDF" :disabled="exportStatus.individualPdf !== 'idle'"
              class="relative h-10 px-3 sm:px-4 rounded-xl hover:bg-rose-500/15 dark:hover:bg-rose-500/20 text-slate-700 dark:text-white/80 hover:text-rose-600 dark:hover:text-rose-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] sm:text-xs tracking-wider transition-all flex items-center justify-center min-w-[70px] sm:min-w-[85px] overflow-hidden"
              title="Exportar PDF Individual">
              <div v-if="exportStatus.individualPdf === 'idle'" class="flex items-center gap-1.5 transition-all">
                <span class="material-symbols-outlined text-[18px]">picture_as_pdf</span>
                <span class="hidden sm:inline">PDF</span>
              </div>
              <span v-else-if="exportStatus.individualPdf === 'loading'"
                class="material-symbols-outlined text-[18px] animate-spin text-rose-600 dark:text-rose-400">sync</span>
              <span v-else-if="exportStatus.individualPdf === 'success'"
                class="material-symbols-outlined text-[22px] text-emerald-500 animate-bounce">check_circle</span>
            </button>
          </div>
          <button @click="showModal = false"
            class="btn-premium btn-secondary-glass !py-2.5 !px-6 transition-transform active:scale-95">
            Cerrar Detalle
          </button>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
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


const exportIndividualPDF = async () => {
  if (!selectedIntento.value) return;
  if (exportStatus.value.individualPdf !== 'idle') return;

  exportStatus.value.individualPdf = 'loading';

  try {
    let logoDataUrl = null;
    try {
      logoDataUrl = await loadLogoToPngBase64('/logo-dark.webp');
    } catch (e) {
      console.warn("No se pudo cargar logo", e);
    }

    const headerColumns = [];
    if (logoDataUrl) {
      headerColumns.push({ image: logoDataUrl, width: 130, alignment: 'left' });
    } else {
      headerColumns.push({ text: 'ENERVIDA', fontSize: 16, bold: true, color: '#2C3E50', alignment: 'left' });
    }

    headerColumns.push({
      width: '*',
      stack: [
        { text: 'REPORTE DE CALIFICACIÓN', style: 'pdfTitle' },
        { text: 'DOCUMENTO ACADÉMICO OFICIAL', style: 'pdfSubtitle' },
        { text: `Fecha de emisión: ${new Date().toLocaleDateString('es-BO')}`, style: 'pdfDate' }
      ],
      alignment: 'right',
      margin: [0, logoDataUrl ? 10 : 0, 0, 0]
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
      pageMargins: [40, 45, 40, 45],
      content: [
        { columns: headerColumns },
        { canvas: [{ type: 'line', x1: 0, y1: 12, x2: 515, y2: 12, lineWidth: 1.5, lineColor: '#2C3E50' }] },
        { text: '', margin: [0, 0, 0, 25] },

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
                    { text: intento.usuario?.correo || '', color: '#7F8C8D', fontSize: 10 }
                  ]
                },
                {
                  stack: [
                    { text: intento.evaluacion?.curso?.titulo || '—', bold: true },
                    { text: intento.evaluacion?.titulo || '', color: '#7F8C8D', fontSize: 10 }
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
        { text: '', margin: [0, 0, 0, 20] },

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
            fillColor: function (rowIndex) {
              return rowIndex === 0 ? '#F8F9FA' : null;
            }
          },
          margin: [0, 0, 0, 30]
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
          margin: [0, 0, 0, 60]
        },

        // Firmas
        {
          columns: [
            {
              stack: [
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] },
                { text: 'Firma del Estudiante', bold: true, margin: [0, 5, 0, 0] },
                { text: 'CI / Identificación', fontSize: 9, color: '#7F8C8D' }
              ],
              alignment: 'center'
            },
            {
              stack: [
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] },
                { text: 'Firma Autorizada', bold: true, margin: [0, 5, 0, 0] },
                { text: 'Director Académico', fontSize: 9, color: '#7F8C8D' }
              ],
              alignment: 'center'
            }
          ]
        }
      ],
      styles: {
        pdfTitle: { fontSize: 16, bold: true, color: '#2C3E50' },
        pdfSubtitle: { fontSize: 11, bold: true, color: '#2980B9', margin: [0, 2, 0, 2] },
        pdfDate: { fontSize: 8.5, italics: true, color: '#7F8C8D' },
        tableHeader: { fontSize: 9, bold: true, color: '#7F8C8D', margin: [0, 5, 0, 5] },
        metricLabel: { fontSize: 9, bold: true, color: '#7F8C8D', alignment: 'center', margin: [0, 10, 0, 5] },
        metricValue: { fontSize: 24, bold: true, color: '#2C3E50', alignment: 'center', margin: [0, 5, 0, 15] },
        sectionTitle: { fontSize: 12, bold: true, color: '#2C3E50', margin: [0, 0, 0, 10] }
      },
      footer: (currentPage, pageCount) => {
        return {
          columns: [
            { text: 'Este documento es un reporte de control académico interno.', alignment: 'left', fontSize: 8, color: '#95A5A6' },
            { text: `Página ${currentPage} de ${pageCount}`, alignment: 'right', fontSize: 8, color: '#95A5A6' }
          ],
          margin: [40, 0, 40, 0]
        };
      }
    };

    // Mismo delay y flujo que la función anterior
    exportStatus.value.individualPdf = 'success';

    setTimeout(() => {
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

  // Cambiar estado a 'loading' para activar el spinner ('sync')
  exportStatus.value[format] = "loading";

  try {
    let downloadAction = null;

    // Simular un sutil tiempo de procesamiento para el spinner de la interfaz
    await new Promise((r) => setTimeout(r, 600));

    // ==========================================
    // 1. EXPORTAR A EXCEL (EXCELJS)
    // ==========================================
    if (format === "excel") {
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet("Calificaciones");

      // Columnas
      worksheet.columns = [
        { header: "ESTUDIANTE", key: "estudiante", width: 30 },
        { header: "CORREO", key: "correo", width: 25 },
        { header: "CURSO", key: "curso", width: 25 },
        { header: "EVALUACIÓN", key: "evaluacion", width: 25 },
        { header: "NOTA (%)", key: "nota", width: 12 },
        { header: "ESTADO", key: "estado", width: 15 },
        { header: "FECHA", key: "fecha", width: 15 },
      ];

      // Cabecera Institucional
      const headerRow = worksheet.getRow(1);
      headerRow.height = 26;
      headerRow.eachCell((cell) => {
        cell.fill = {
          type: "pattern",
          pattern: "solid",
          fgColor: { argb: "FF2C3E50" },
        };
        cell.font = {
          name: "Segoe UI",
          size: 10,
          bold: true,
          color: { argb: "FFFFFFFF" },
        };
        cell.alignment = { vertical: "middle", horizontal: "center" };
      });

      // Filas dinámicas
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
          cell.border = {
            bottom: { style: "thin", color: { argb: "FFE0E0E0" } },
          };
        });
      });

      downloadAction = async () => {
        const buffer = await workbook.xlsx.writeBuffer();
        const blob = new Blob([buffer], {
          type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        });
        saveAs(blob, `Listado_Calificaciones_${Date.now()}.xlsx`);
      };

      // ==========================================
      // 2. EXPORTAR A PDF (PDFMAKE)
      // ==========================================
    } else if (format === "pdf") {
      let logoDataUrl = null;
      try {
        logoDataUrl = await loadLogoToPngBase64("/logo-dark.webp");
      } catch (e) {
        console.warn("No se pudo cargar logo", e);
      }

      const headerColumns = [];
      if (logoDataUrl) {
        headerColumns.push({
          image: logoDataUrl,
          width: 130,
          alignment: "left",
        });
      } else {
        headerColumns.push({
          text: "ENERVIDA",
          fontSize: 16,
          bold: true,
          color: "#2C3E50",
          alignment: "left",
        });
      }

      headerColumns.push({
        width: "*",
        stack: [
          { text: "REPORTE GENERAL DE CALIFICACIONES", style: "pdfTitle" },
          {
            text: `Total Registros: ${intentosFiltrados.value.length}`,
            style: "pdfSubtitle",
          },
          {
            text: `Fecha de emisión: ${new Date().toLocaleDateString("es-BO")}`,
            style: "pdfDate",
          },
        ],
        alignment: "right",
        margin: [0, logoDataUrl ? 10 : 0, 0, 0],
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
          {
            text: `${i.usuario?.nombres || ""} ${i.usuario?.apellidos || ""}`,
            fontSize: 9,
            bold: true,
          },
          { text: i.usuario?.correo || "", fontSize: 9, color: "#7F8C8D" },
          { text: i.evaluacion?.curso?.titulo || "—", fontSize: 9 },
          { text: i.evaluacion?.titulo || "", fontSize: 9 },
          {
            text: Math.round(i.nota || 0) + "%",
            fontSize: 9,
            bold: true,
            alignment: "center",
            color: isApproved ? "#27AE60" : "#E74C3C",
          },
          {
            text: isApproved ? "Aprobado" : "Reprobado",
            fontSize: 9,
            bold: true,
            alignment: "center",
            color: isApproved ? "#27AE60" : "#E74C3C",
          },
          {
            text: formatDate(i.fecha_fin || i.fecha_inicio),
            fontSize: 9,
            alignment: "center",
          },
        ]);
      });

      const docDefinition = {
        pageSize: "A4",
        pageOrientation: "landscape",
        pageMargins: [40, 45, 40, 45],
        content: [
          { columns: headerColumns },
          {
            canvas: [
              {
                type: "line",
                x1: 0,
                y1: 12,
                x2: 762,
                y2: 12,
                lineWidth: 1.5,
                lineColor: "#2C3E50",
              },
            ],
          },
          { text: "", margin: [0, 0, 0, 25] },
          {
            table: {
              headerRows: 1,
              widths: ["auto", "auto", "*", "*", "auto", "auto", "auto"],
              body: tableBody,
            },
            layout: {
              fillColor: (rowIndex) => (rowIndex === 0 ? "#F8F9FA" : null),
              hLineWidth: (i, node) =>
                i === 0 || i === node.table.body.length ? 1 : 0.5,
              vLineWidth: () => 0,
              hLineColor: () => "#E0E0E0",
              paddingTop: () => 5,
              paddingBottom: () => 5,
            },
          },
        ],
        styles: {
          pdfTitle: { fontSize: 16, bold: true, color: "#2C3E50" },
          pdfSubtitle: {
            fontSize: 11,
            bold: true,
            color: "#2980B9",
            margin: [0, 2, 0, 2],
          },
          pdfDate: { fontSize: 8.5, italics: true, color: "#7F8C8D" },
          tableHeader: {
            fontSize: 9,
            bold: true,
            color: "#2C3E50",
            fillColor: "#F8F9FA",
            margin: [0, 5, 0, 5],
          },
        },
        footer: (currentPage, pageCount) => ({
          columns: [
            {
              text: "Generado por Enervida LMS",
              alignment: "left",
              fontSize: 8,
              color: "#95A5A6",
            },
            {
              text: `Página ${currentPage} de ${pageCount}`,
              alignment: "right",
              fontSize: 8,
              color: "#95A5A6",
            },
          ],
          margin: [40, 0, 40, 0],
        }),
      };

      downloadAction = () =>
        pdfMake
          .createPdf(docDefinition)
          .download(`Listado_Calificaciones_${Date.now()}.pdf`);
    }

    // ==========================================
    // CAMBIO DE ESTADO Y DISPARO DE DESCARGA
    // (Mismo comportamiento de sincronización visual)
    // ==========================================
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
