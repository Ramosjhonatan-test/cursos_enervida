<template>
  <div class="mx-auto max-w-[1500px] space-y-8 pb-20 text-on-surface">
    <!-- ===== HEADER ===== -->
    <section class="panel-hero relative overflow-hidden rounded-[32px] p-6 sm:p-8">
      <div class="absolute -right-24 -top-24 h-72 w-72 rounded-full bg-cyan-400/10 blur-[100px] dark:bg-cyan-400/15"></div>
      <div class="relative z-10 flex flex-col justify-between gap-6 xl:flex-row xl:items-end">
        <div>
          <p class="mb-3 text-[10px] font-black uppercase tracking-[0.35em] text-accent-neon">Centro de análisis</p>
          <h2 class="font-lexend text-3xl font-black tracking-tight sm:text-4xl">
            Reportes <span class="text-accent-neon">operativos</span>
          </h2>
          <p class="mt-3 max-w-2xl text-sm text-on-surface/50">
            Consulta, filtra y descarga información real de la plataforma desde una sola vista.
          </p>
        </div>
        <div class="flex flex-wrap items-center gap-3">
          <!-- EXPORT BUTTONS (INLINE) -->
          <div class="inline-flex items-center rounded-full border border-slate-300 dark:border-white/10 bg-slate-50 dark:bg-white/5 overflow-hidden divide-x divide-slate-200 dark:divide-white/10 shadow-sm">
            <button
              @click="exportData('excel')"
              :disabled="loading || !rows.length || exportStatus.excel !== 'idle'"
              :title="`Exportar reporte filtrado a Excel`"
              :aria-label="`Exportar a Excel`"
              class="inline-flex items-center gap-2 px-4 py-2.5 text-xs font-black uppercase tracking-wider text-slate-700 dark:text-white/80 transition hover:bg-cyan-500/10 hover:text-cyan-700 dark:hover:text-cyan-300 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              <span v-if="exportStatus.excel === 'idle'" class="material-symbols-outlined text-[18px]">table_view</span>
              <span v-else-if="exportStatus.excel === 'loading'" class="material-symbols-outlined animate-spin text-[18px]">sync</span>
              <span v-else-if="exportStatus.excel === 'success'" class="material-symbols-outlined animate-bounce text-[22px] text-emerald-500">check_circle</span>
              <span v-else class="material-symbols-outlined text-[22px] text-rose-500">error</span>
              <span class="hidden sm:inline">{{ exportLabel('excel') }}</span>
            </button>
            <button
              @click="exportData('pdf')"
              :disabled="loading || !rows.length || exportStatus.pdf !== 'idle'"
              :title="`Exportar reporte filtrado a PDF`"
              :aria-label="`Exportar a PDF`"
              class="inline-flex items-center gap-2 px-4 py-2.5 text-xs font-black uppercase tracking-wider text-slate-700 dark:text-white/80 transition hover:bg-cyan-500/10 hover:text-cyan-700 dark:hover:text-cyan-300 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              <span v-if="exportStatus.pdf === 'idle'" class="material-symbols-outlined text-[18px]">picture_as_pdf</span>
              <span v-else-if="exportStatus.pdf === 'loading'" class="material-symbols-outlined animate-spin text-[18px]">sync</span>
              <span v-else-if="exportStatus.pdf === 'success'" class="material-symbols-outlined animate-bounce text-[22px] text-emerald-500">check_circle</span>
              <span v-else class="material-symbols-outlined text-[22px] text-rose-500">error</span>
              <span class="hidden sm:inline">{{ exportLabel('pdf') }}</span>
            </button>
          </div>
          <button
            @click="fetchReport"
            :disabled="loading || isExporting"
            class="btn-premium btn-secondary-glass flex items-center gap-2 !py-3 shadow-md dark:shadow-xl"
          >
            <span class="material-symbols-outlined text-lg" :class="{ 'animate-spin': loading }">refresh</span>
            Actualizar
          </button>
        </div>
      </div>
    </section>

    <!-- ===== CHIPS DE FILTROS ACTIVOS (INLINE) ===== -->
    <section v-if="activeFiltersList.length" class="flex flex-wrap items-center gap-2">
      <span class="text-[10px] font-black uppercase tracking-widest text-on-surface/40">Filtros:</span>
      <button
        v-for="filter in activeFiltersList"
        :key="filter.key"
        @click="removeFilter(filter.key)"
        type="button"
        class="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-cyan-500/10 border border-cyan-500/30 text-cyan-700 dark:text-cyan-300 text-[11px] font-bold hover:bg-cyan-500/20 hover:border-cyan-500/50 transition cursor-pointer"
      >
        <span>{{ filter.label }}</span>
        <span class="material-symbols-outlined text-sm">close</span>
      </button>
      <button @click="clearFilters" class="text-[10px] font-black uppercase tracking-widest text-rose-500 hover:text-rose-600 ml-2">
        Limpiar todo
      </button>
    </section>

    <!-- ===== FILTROS ===== -->
    <section class="filter-panel glass-card-premium rounded-[32px] p-5 sm:p-7">
      <div class="mb-6 flex flex-col justify-between gap-3 border-b border-white/10 pb-5 md:flex-row md:items-center">
        <div>
          <p class="eyebrow">Consulta personalizada</p>
          <h3 class="mt-1 font-lexend text-xl font-black">Construye tu reporte</h3>
        </div>
        <div class="flex items-center gap-4">
          <span class="filter-status">
            <span class="status-dot"></span>
            {{ activeFilterCount }} filtros activos
          </span>
        </div>
      </div>

      <div class="grid gap-5 lg:grid-cols-2">
        <label class="filter-field">
          <span class="field-label">Fuente del reporte</span>
          <span class="field-control">
            <span class="material-symbols-outlined">dataset</span>
            <VSelect v-model="filters.type" :options="reportOptions" label="label" :reduce="option => option.value" :clearable="false" :searchable="false" class="report-select" />
          </span>
        </label>

        <label class="filter-field">
          <span class="field-label">Buscar en registros</span>
          <span class="field-control">
            <span class="material-symbols-outlined">search</span>
            <input
              v-model="filters.search"
              @input="onSearchInput"
              type="search"
              placeholder="Nombre, correo, curso..."
              aria-label="Buscar"
            />
          </span>
        </label>
      </div>

      <div class="mt-5 grid gap-4 md:grid-cols-3">
        <label v-if="usesStatus" class="filter-field">
          <span class="field-label">Estado</span>
          <span class="field-control">
            <span class="material-symbols-outlined">rule</span>
            <VSelect v-model="filters.status" :options="statusOptions" placeholder="Todos los estados" :clearable="true" :searchable="false" class="report-select" />
          </span>
        </label>

        <label v-if="usesPayment" class="filter-field">
          <span class="field-label">Estado del pago</span>
          <span class="field-control">
            <span class="material-symbols-outlined">payments</span>
            <VSelect v-model="filters.payment_status" :options="paymentStatusOptions" placeholder="Todos los pagos" :clearable="true" :searchable="false" class="report-select" />
          </span>
        </label>

        <label v-if="usesCourse" class="filter-field">
          <span class="field-label">Curso relacionado</span>
          <span class="field-control">
            <span class="material-symbols-outlined">school</span>
            <VSelect v-model="filters.course_id" :options="courses" label="titulo" :reduce="course => course.id" placeholder="Todos los cursos" :clearable="true" class="report-select" />
          </span>
        </label>
      </div>

      <!-- DATE FILTER (INLINE) -->
      <div class="date-filter mt-5 rounded-2xl border border-white/10 bg-slate-50/50 dark:bg-white/[0.02] p-4">
        <div class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <span class="field-label">Periodo del reporte</span>
            <p class="date-filter-summary flex items-center gap-2 text-xs font-bold text-on-surface/80 mt-1">
              <span class="material-symbols-outlined text-cyan-600 dark:text-cyan-400 text-base">date_range</span>
              {{ dateFilterLabel }}
            </p>
          </div>
          <div class="flex items-center gap-2">
            <button
              v-if="hasDateFilter"
              @click="clearDateRange"
              class="px-3 py-2 text-[10px] font-black uppercase tracking-wider text-rose-500 hover:text-rose-600 transition"
            >
              Limpiar fecha
            </button>
            <button
              @click="dateFilterOpen = !dateFilterOpen"
              class="date-filter-toggle flex items-center gap-2 px-4 py-2 rounded-xl border border-slate-300 dark:border-white/10 bg-white dark:bg-white/5 text-xs font-bold transition hover:border-cyan-500"
              :class="{ 'border-cyan-500 text-cyan-600 dark:text-cyan-400 bg-cyan-500/5': dateFilterOpen || hasDateFilter }"
            >
              <span class="material-symbols-outlined text-base">calendar_month</span>
              <span>{{ dateFilterOpen ? 'Ocultar selector' : 'Cambiar periodo' }}</span>
              <span class="material-symbols-outlined text-sm transition-transform duration-200" :class="{ 'rotate-180': dateFilterOpen }">expand_more</span>
            </button>
          </div>
        </div>

        <div v-if="dateFilterOpen" class="date-filter-popover mt-4 rounded-xl border border-white/10 bg-white dark:bg-[#0b1329] p-4 shadow-xl">
          <div class="mb-4 flex flex-wrap gap-1.5 pb-3 border-b border-white/10">
            <button
              v-for="range in dateRanges"
              :key="range.value"
              @click="setDateRange(range.value)"
              class="px-2.5 py-1.5 rounded-lg text-[10px] font-black uppercase tracking-wider transition border"
              :class="selectedRange === range.value
                ? 'border-cyan-500 bg-cyan-500 text-slate-950'
                : 'border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-white/5 text-slate-600 dark:text-white/70'"
            >
              {{ range.label }}
            </button>
            <button
              @click="clearDateRange"
              class="px-2.5 py-1.5 rounded-lg text-[10px] font-black uppercase tracking-wider transition border border-rose-200 dark:border-rose-500/20 bg-rose-50 dark:bg-rose-500/10 text-rose-600 dark:text-rose-400"
            >
              Sin fecha
            </button>
          </div>

          <div class="grid gap-4 md:grid-cols-2 items-center">
            <div class="date-range-fields flex items-center gap-2 p-2.5 rounded-xl bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-white/10">
              <span class="material-symbols-outlined text-cyan-600 dark:text-cyan-400">event</span>
              <div class="flex-1">
                <span class="text-[9px] uppercase tracking-wider block text-on-surface/50 font-bold">Desde</span>
                <strong class="text-xs font-extrabold">{{ datePickerFromLabel || 'Seleccionar fecha' }}</strong>
              </div>
            </div>
            <div class="date-range-fields flex items-center gap-2 p-2.5 rounded-xl bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-white/10">
              <span class="material-symbols-outlined text-cyan-600 dark:text-cyan-400">event_available</span>
              <div class="flex-1">
                <span class="text-[9px] uppercase tracking-wider block text-on-surface/50 font-bold">Hasta</span>
                <strong class="text-xs font-extrabold">{{ datePickerToLabel || 'Seleccionar fecha' }}</strong>
              </div>
            </div>
          </div>

          <div class="mt-4 flex justify-center py-2 bg-slate-50/50 dark:bg-black/20 rounded-xl border border-dashed border-slate-300 dark:border-white/10">
            <DatePicker
              v-model="datePickerValue"
              range
              :dark="isDarkTheme"
              :enable-time-picker="false"
              :auto-apply="false"
              :partial-range="false"
              :month-change-on-scroll="false"
              :teleport="false"
              inline
              format="dd/MM/yyyy"
              :locale="es"
              class="report-date-picker scale-[0.88] origin-center"
            />
          </div>

          <p v-if="dateRangeInvalid" class="date-error mt-2 text-center text-xs font-bold text-rose-500">
            ⚠️ La fecha inicial no puede ser posterior a la final.
          </p>

          <div class="date-filter-actions mt-4 pt-3 border-t border-white/10 flex items-center justify-end gap-2">
            <button @click="dateFilterOpen = false" class="date-cancel px-4 py-2 rounded-xl text-xs font-bold text-on-surface/60 hover:text-on-surface transition">
              Cancelar
            </button>
            <button
              @click="applyDateFilter"
              :disabled="dateRangeInvalid"
              class="filter-submit !w-auto px-5 py-2 rounded-xl bg-cyan-500 hover:bg-cyan-400 text-slate-950 font-black text-xs uppercase tracking-wider transition disabled:opacity-50 disabled:cursor-not-allowed shadow-md"
            >
              Aplicar periodo
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- ===== COLUMNAS ===== -->
    <section class="glass-card-premium rounded-[32px] p-6">
      <div class="mb-4 flex items-center justify-between gap-4 border-b border-white/10 pb-4">
        <div>
          <p class="eyebrow">Columnas visibles</p>
          <h3 class="mt-1 font-lexend text-lg font-black">Selecciona columnas adicionales</h3>
        </div>
        <button
          @click="toggleAllColumns"
          class="text-[10px] font-black uppercase tracking-widest text-cyan-600 hover:text-cyan-500"
          type="button"
        >
          {{ allColumnsSelected ? 'Deseleccionar todo' : 'Seleccionar todo' }}
        </button>
      </div>
      <div class="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
        <label
          v-for="column in currentReport.columns"
          :key="column.key"
          class="inline-flex items-center gap-2.5 border rounded-2xl px-4 py-3 text-sm font-bold transition cursor-pointer"
          :class="column.locked
            ? 'border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-white/5 text-slate-900 dark:text-white opacity-70 cursor-default'
            : (selectedColumnKeys.has(column.key)
              ? 'border-cyan-500 bg-cyan-500/10 text-slate-900 dark:text-white hover:border-cyan-400'
              : 'border-slate-200 dark:border-white/10 bg-slate-50 dark:bg-white/5 text-slate-900 dark:text-white hover:border-cyan-500')"
        >
          <input
            v-if="!column.locked"
            type="checkbox"
            :checked="selectedColumnKeys.has(column.key)"
            @change="toggleColumn(column.key)"
            class="w-4 h-4 rounded accent-cyan-500"
          />
          <span v-else class="inline-flex items-center justify-center w-4 h-4 text-slate-400 dark:text-white/40" title="Columna fija">
            <span class="material-symbols-outlined text-sm">lock</span>
          </span>
          <span class="min-w-0 truncate">{{ column.label }}</span>
        </label>
      </div>
    </section>

    <!-- ===== MÉTRICAS ===== -->
    <section class="grid gap-5 md:grid-cols-3">
      <div
        v-for="metric in metrics"
        :key="metric.label"
        class="metric-card transition-all duration-300 hover:shadow-xl hover:-translate-y-1"
      >
        <div class="flex items-center justify-between">
          <span class="eyebrow !mb-0">{{ metric.label }}</span>
          <span class="material-symbols-outlined text-cyan-600 dark:text-accent-neon">{{ metric.icon }}</span>
        </div>
        <p class="mt-4 font-lexend text-3xl font-black transition-all duration-500" :key="metric.value">
          {{ metric.value }}
        </p>
      </div>
    </section>

    <!-- ===== TABLA ===== -->
    <section class="glass-card-premium overflow-hidden rounded-[32px]">
      <div class="flex flex-col justify-between gap-4 border-b border-white/10 p-6 md:flex-row md:items-center">
        <div>
          <p class="eyebrow">Resultado seleccionado</p>
          <h3 class="mt-1 font-lexend text-xl font-black">{{ currentReport.label }}</h3>
        </div>
        <p class="text-xs font-bold text-on-surface/40">
          {{ rows.length }} registros encontrados
          <span v-if="loading" class="ml-2 inline-block animate-pulse">· cargando...</span>
        </p>
      </div>

      <!-- ESTADO: LOADING -->
      <div v-if="loading" class="flex min-h-[300px] items-center justify-center">
        <span class="material-symbols-outlined animate-spin text-5xl text-cyan-600 dark:text-accent-neon">sync</span>
      </div>

      <!-- ESTADO: ERROR -->
      <div v-else-if="error" class="flex min-h-[300px] flex-col items-center justify-center gap-3 text-rose-500 dark:text-rose-400">
        <span class="material-symbols-outlined text-5xl">error</span>
        <p class="text-xs font-black uppercase tracking-widest">{{ error }}</p>
        <button @click="fetchReport" class="mt-2 text-[10px] font-black uppercase tracking-widest text-cyan-600 hover:text-cyan-500">
          Reintentar
        </button>
      </div>

      <!-- ESTADO: VACÍO -->
      <div v-else-if="!rows.length" class="flex min-h-[300px] flex-col items-center justify-center gap-3 text-on-surface/30">
        <span class="material-symbols-outlined text-5xl">search_off</span>
        <p class="text-xs font-black uppercase tracking-widest">No hay datos para estos filtros</p>
        <button v-if="activeFilterCount" @click="clearFilters" class="mt-2 text-[10px] font-black uppercase tracking-widest text-cyan-600 hover:text-cyan-500">
          Limpiar filtros
        </button>
      </div>

      <!-- TABLA -->
      <div v-else class="overflow-x-auto transition-opacity duration-300">
        <table class="report-table">
          <thead>
            <tr>
              <th v-for="column in columns" :key="column.key">{{ column.label }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="row in pagedRows" :key="row.id" class="transition-colors hover:bg-on-surface/5">
              <td
                v-for="column in columns"
                :key="column.key"
                :class="cellClasses(column.key)"
                :title="String(formatCell(row[column.key], column.key))"
              >
                <!-- Celda especial: Estado (badge con color) -->
                <span v-if="isStatusColumn(column.key)" class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[10px] font-black uppercase tracking-wider whitespace-nowrap" :class="STATUS_PILL_CLASSES[statusClass(row[column.key])]">
                  {{ formatCell(row[column.key], column.key) }}
                </span>

                <!-- Celda especial: Progreso (barra) -->
                <div v-else-if="column.key === 'progreso'" class="flex items-center gap-2 justify-end">
                  <div class="progress-bar">
                    <div class="progress-bar__fill" :style="{ width: `${Math.min(100, Math.max(0, Number(row[column.key] || 0)))}%` }"></div>
                  </div>
                  <span class="text-[11px] font-extrabold text-slate-900 dark:text-white min-w-[32px] text-right">{{ Math.round(Number(row[column.key] || 0)) }}%</span>
                </div>

                <!-- Celda normal -->
                  <span v-else>
                    <template v-if="column.key === 'url_pdf'">
                      <button
                        @click.stop.prevent="downloadCertificate(row.id, row)"
                        class="px-3 py-1 rounded-md bg-cyan-500 text-white text-xs font-bold hover:bg-cyan-400"
                      >
                        Descargar
                      </button>
                    </template>
                    <template v-else>
                      {{ formatCell(row[column.key], column.key) }}
                    </template>
                  </span>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- PAGINACIÓN -->
      <div v-if="rows.length && !loading && !error" class="flex flex-col gap-3 border-t border-white/10 p-5 sm:flex-row sm:items-center sm:justify-between">
        <span class="text-[10px] font-black uppercase tracking-widest text-on-surface/35">
          Página {{ page }} de {{ totalPages }} · {{ rows.length }} registros
        </span>
        <div class="flex items-center gap-2">
          <div class="flex items-center gap-1">
            <span class="text-[10px] font-bold text-on-surface/40 hidden sm:inline">Ir a:</span>
            <input
              type="number"
              :min="1"
              :max="totalPages"
              :value="page"
              @change="goToPage($event.target.value)"
              class="w-14 h-9 text-center border border-slate-200 dark:border-white/10 rounded-xl bg-slate-50 dark:bg-white/5 text-slate-900 dark:text-white text-xs font-bold outline-none focus:border-cyan-500 transition"
            />
          </div>
          <button @click="page--" :disabled="page === 1" class="page-btn" aria-label="Página anterior">
            <span class="material-symbols-outlined">chevron_left</span>
          </button>
          <button @click="page++" :disabled="page >= totalPages" class="page-btn" aria-label="Página siguiente">
            <span class="material-symbols-outlined">chevron_right</span>
          </button>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { computed, onBeforeUnmount, onMounted, reactive, ref, watch } from 'vue'
import api from '@/services/api'
import ExcelJS from 'exceljs'
import { saveAs } from 'file-saver'
import pdfMake from 'pdfmake/build/pdfmake'
import * as pdfFonts from 'pdfmake/build/vfs_fonts'
import { VueDatePicker as DatePicker } from '@vuepic/vue-datepicker'
import '@vuepic/vue-datepicker/dist/main.css'
import VSelect from 'vue-select'
import 'vue-select/dist/vue-select.css'
import { es } from 'date-fns/locale'

pdfMake.vfs = pdfFonts.pdfMake ? pdfFonts.pdfMake.vfs : pdfMake.vfs

// ===== CONSTANTES =====
const PAGE_SIZE = 20
const SEARCH_DEBOUNCE_MS = 400
const EXPORT_FEEDBACK_MS = 1500

const reportOptions = [
  { value: 'inscripciones', label: 'Inscripciones y pagos' },
  { value: 'usuarios', label: 'Usuarios registrados' },
  { value: 'cursos', label: 'Catálogo de cursos' },
  { value: 'certificados', label: 'Certificados emitidos' },
  { value: 'evaluaciones', label: 'Resultados de evaluaciones' }
]

const dateRanges = [
  { value: 'today', label: 'Hoy' },
  { value: 'week', label: '7 días' },
  { value: 'month', label: '30 días' },
  { value: 'quarter', label: '90 días' },
  { value: 'year', label: 'Este año' }
]

const paymentStatusOptions = ['PENDIENTE', 'APROBADO', 'RECHAZADO']
const STATUS_KEYS = ['estado', 'estado_pago', 'estado_validacion']

// Clases Tailwind por variante de estado (para status-pill)
const STATUS_PILL_CLASSES = {
  success: 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-300',
  warning: 'bg-amber-500/15 text-amber-700 dark:text-amber-300',
  danger: 'bg-rose-500/15 text-rose-700 dark:text-rose-300',
  muted: 'bg-slate-500/15 text-slate-600 dark:text-slate-300',
  neutral: 'bg-cyan-500/15 text-cyan-700 dark:text-cyan-300'
}

// ===== DEFINICIONES DE REPORTES =====
const definitions = reactive({
  inscripciones: {
    label: 'Inscripciones y pagos',
    status: ['PENDIENTE', 'ACTIVO', 'COMPLETADO', 'RECHAZADO'],
    payment: true,
    course: true,
    amountKey: 'monto',
    columns: [
      { key: 'id', label: 'ID', visible: true, locked: true },
      { key: 'fecha', label: 'Fecha', visible: true, locked: true },
      { key: 'estudiante', label: 'Estudiante', visible: true, locked: true },
      { key: 'correo', label: 'Correo', visible: true, locked: true },
      { key: 'curso', label: 'Curso', visible: true, locked: true },
      { key: 'estado', label: 'Estado', visible: true, locked: true },
      { key: 'estado_pago', label: 'Pago', visible: true, locked: true },
      { key: 'monto', label: 'Monto', visible: false },
      { key: 'metodo_pago', label: 'Método', visible: false },
      { key: 'fecha_pago', label: 'Fecha pago', visible: false },
      { key: 'comprobante', label: 'Comprobante', visible: false },
      { key: 'progreso', label: 'Progreso', visible: false },
      { key: 'fecha_completado', label: 'Fecha completado', visible: false }
    ]
  },
  usuarios: {
    label: 'Usuarios registrados',
    status: ['ACTIVO', 'INACTIVO', 'BLOQUEADO'],
    columns: [
      { key: 'id', label: 'ID', visible: true, locked: true },
      { key: 'nombre', label: 'Nombre', visible: true, locked: true },
      { key: 'ci', label: 'CI', visible: true, locked: true },
      { key: 'correo', label: 'Correo', visible: true, locked: true },
      { key: 'telefono', label: 'Teléfono', visible: true, locked: true },
      { key: 'estado', label: 'Estado', visible: true, locked: true },
      { key: 'rol', label: 'Rol', visible: false },
      { key: 'verificado', label: 'Verificado', visible: false },
      { key: 'ultimo_acceso', label: 'Último acceso', visible: false },
      { key: 'fecha_registro', label: 'Registro', visible: false },
      { key: 'fecha_actualizacion', label: 'Última actualización', visible: false },
      { key: 'inscripciones', label: 'Inscripciones', visible: false },
      { key: 'completados', label: 'Cursos completados', visible: false },
      { key: 'certificados', label: 'Certificados', visible: false }
    ]
  },
  cursos: {
    label: 'Catálogo de cursos',
    status: ['PUBLICADO', 'BORRADOR'],
    amountKey: 'precio',
    columns: [
      { key: 'id', label: 'ID', visible: true, locked: true },
      { key: 'curso', label: 'Curso', visible: true, locked: true },
      { key: 'categoria', label: 'Categoría', visible: true, locked: true },
      { key: 'instructor', label: 'Instructor', visible: true, locked: true },
      { key: 'estado', label: 'Estado', visible: true, locked: true },
      { key: 'precio', label: 'Precio', visible: true, locked: true },
      { key: 'nivel', label: 'Nivel', visible: false },
      { key: 'tipo', label: 'Tipo', visible: false },
      { key: 'publicado', label: 'Publicado', visible: false },
      { key: 'certificado', label: 'Certificado', visible: false },
      { key: 'fecha_creacion', label: 'Creación', visible: false },
      { key: 'ultima_actualizacion', label: 'Última actualización', visible: false },
      { key: 'inscritos', label: 'Total inscritos', visible: false },
      { key: 'activos', label: 'Inscritos activos', visible: false },
      { key: 'completados', label: 'Inscritos completados', visible: false },
      { key: 'ingresos', label: 'Ingresos', visible: false }
    ]
  },
  certificados: {
    label: 'Certificados emitidos',
    course: true,
    columns: [
      { key: 'id', label: 'ID', visible: true, locked: true },
      { key: 'codigo', label: 'Código', visible: true, locked: true },
      { key: 'estudiante', label: 'Estudiante', visible: true, locked: true },
      { key: 'curso', label: 'Curso', visible: true, locked: true },
      { key: 'fecha', label: 'Fecha emisión', visible: true, locked: true },
      { key: 'pdf', label: 'PDF', visible: true, locked: true },
      { key: 'url_pdf', label: 'URL PDF', visible: false },
      { key: 'estado_validacion', label: 'Estado validación', visible: false }
    ]
  },
  evaluaciones: {
    label: 'Resultados de evaluaciones',
    status: ['APROBADO', 'REPROBADO', 'PENDIENTE'],
    course: true,
    columns: [
      { key: 'id', label: 'ID', visible: true, locked: true },
      { key: 'estudiante', label: 'Estudiante', visible: true, locked: true },
      { key: 'evaluacion', label: 'Evaluación', visible: true, locked: true },
      { key: 'curso', label: 'Curso', visible: true, locked: true },
      { key: 'nota', label: 'Nota', visible: true, locked: true },
      { key: 'estado', label: 'Estado', visible: true, locked: true },
      { key: 'fecha_inicio', label: 'Inicio', visible: false },
      { key: 'fecha_finalizacion', label: 'Finalización', visible: false },
      { key: 'duracion', label: 'Duración', visible: false },
      { key: 'intentos', label: 'Intentos', visible: false }
    ]
  }
})

// ===== ESTADO =====
const loading = ref(true)
const error = ref(null)
const rows = ref([])
const courses = ref([])
const page = ref(1)
const isDarkTheme = ref(false)
let themeObserver = null
let searchDebounce = null

const dateFilterOpen = ref(false)
const datePickerRange = ref(null)
const selectedRange = ref('')

const exportStatus = ref({ excel: 'idle', pdf: 'idle' })

// Trackea visibilidad de columnas con un Set separado (reactividad fiable)
const selectedColumnKeys = ref(new Set())

const filters = reactive({
  type: 'inscripciones',
  from: '',
  to: '',
  status: '',
  payment_status: '',
  course_id: '',
  search: ''
})

// ===== COMPUTADOS =====
const currentReport = computed(() => definitions[filters.type])

const columns = computed(() =>
  currentReport.value.columns
    .filter(column => selectedColumnKeys.value.has(column.key))
    .map(({ key, label }) => ({ key, label }))
)

const statusOptions = computed(() => currentReport.value.status || [])
const usesStatus = computed(() => Boolean(currentReport.value.status))
const usesPayment = computed(() => Boolean(currentReport.value.payment))
const usesCourse = computed(() => Boolean(currentReport.value.course))

const totalPages = computed(() => Math.max(1, Math.ceil(rows.value.length / PAGE_SIZE)))
const pagedRows = computed(() => rows.value.slice((page.value - 1) * PAGE_SIZE, page.value * PAGE_SIZE))

const allColumnsSelected = computed(() =>
  currentReport.value.columns.every(column => column.locked || selectedColumnKeys.value.has(column.key))
)

const hasDateFilter = computed(() => Boolean(filters.from || filters.to))
const dateRangeInvalid = computed(() => Boolean(filters.from && filters.to && filters.from > filters.to))

const activeFilterCount = computed(() =>
  [filters.from, filters.to, filters.status, filters.payment_status, filters.course_id, filters.search]
    .filter(Boolean).length
)

const activeFiltersList = computed(() => {
  const list = []
  if (filters.status) list.push({ key: 'status', label: `Estado: ${filters.status}` })
  if (filters.payment_status) list.push({ key: 'payment_status', label: `Pago: ${filters.payment_status}` })
  if (filters.course_id) {
    const course = courses.value.find(c => c.id === filters.course_id)
    list.push({ key: 'course_id', label: `Curso: ${course?.titulo || 'Seleccionado'}` })
  }
  if (filters.from) list.push({ key: 'from', label: `Desde: ${filters.from}` })
  if (filters.to) list.push({ key: 'to', label: `Hasta: ${filters.to}` })
  if (filters.search) list.push({ key: 'search', label: `Búsqueda: "${filters.search}"` })
  return list
})

const dateFilterLabel = computed(() => {
  if (!hasDateFilter.value) return 'Todas las fechas'
  if (filters.from && filters.to) return `${filters.from}  →  ${filters.to}`
  return filters.from ? `Desde ${filters.from}` : `Hasta ${filters.to}`
})

const datePickerFromLabel = computed(() => filters.from ? formatDisplayDate(filters.from) : 'Seleccionar fecha')
const datePickerToLabel = computed(() => filters.to ? formatDisplayDate(filters.to) : 'Seleccionar fecha')

const isExporting = computed(() => exportStatus.value.excel !== 'idle' || exportStatus.value.pdf !== 'idle')

const totalAmount = computed(() => {
  const key = currentReport.value.amountKey
  if (!key) return 0
  return rows.value.reduce((sum, row) => sum + Number(row?.[key] || 0), 0)
})

const metrics = computed(() => [
  { label: 'Registros', value: rows.value.length, icon: 'dataset' },
  { label: 'Importe asociado', value: `${totalAmount.value.toFixed(2)} Bs`, icon: 'payments' },
  { label: 'Vista', value: `${page.value}/${totalPages.value}`, icon: 'table_rows' }
])

// ===== HELPERS =====
const cellClasses = (key) => {
  const classes = []
  if (['id', 'estudiante', 'nombre', 'curso'].includes(key)) classes.push('font-black')
  if (['monto', 'precio', 'progreso'].includes(key)) classes.push('text-right')
  if (key === 'correo' || key === 'curso') classes.push('text-ellipsis', 'max-w-[200px]')
  return classes
}

const isStatusColumn = (key) => STATUS_KEYS.includes(key)

// Mapeo de status a clase CSS (color del pill)
const statusClass = (status) => {
  if (!status) return 'neutral'
  const s = String(status).toUpperCase()
  if (['APROBADO', 'ACTIVO', 'COMPLETADO', 'PUBLICADO', 'VERIFICADO'].includes(s)) return 'success'
  if (['PENDIENTE'].includes(s)) return 'warning'
  if (['RECHAZADO', 'INACTIVO', 'BLOQUEADO', 'REPROBADO'].includes(s)) return 'danger'
  if (['BORRADOR'].includes(s)) return 'muted'
  return 'neutral'
}

const exportLabel = (format) => {
  const status = exportStatus.value[format]
  if (status === 'loading') return 'Generando...'
  if (status === 'success') return '¡Listo!'
  if (status === 'error') return 'Error'
  return format === 'excel' ? 'XLS' : 'PDF'
}

const datePickerValue = computed({
  get: () => datePickerRange.value,
  set: (value) => {
    datePickerRange.value = value
    if (Array.isArray(value)) {
      filters.from = value[0] ? formatDateInput(value[0]) : ''
      filters.to = value[1] ? formatDateInput(value[1]) : ''
    } else {
      filters.from = ''
      filters.to = ''
    }
  }
})

const formatDateInput = (value) => {
  if (!value) return ''
  const date = value instanceof Date ? value : new Date(value)
  if (Number.isNaN(date.getTime())) return ''
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

const formatDisplayDate = (value) => {
  if (!value) return ''
  return new Intl.DateTimeFormat('es-BO', { day: '2-digit', month: 'short', year: 'numeric' }).format(new Date(`${value}T00:00:00`))
}

const DATE_KEYS = new Set([
  'fecha', 'fecha_completado', 'fecha_registro', 'fecha_actualizacion',
  'ultimo_acceso', 'fecha_inicio', 'fecha_finalizacion', 'fecha_pago', 'fecha_creacion'
])

const formatCell = (value, key) => {
  if (value === null || value === undefined || value === '') return '—'
  if (DATE_KEYS.has(key)) {
    const date = new Date(value)
    return Number.isNaN(date.getTime()) ? '—' : date.toLocaleDateString('es-BO')
  }
  if (['monto', 'precio', 'ingresos'].includes(key)) return `${Number(value).toFixed(2)} Bs`
  if (key === 'progreso') return `${Number(value).toFixed(0)}%`
  if (key === 'nota') return `${Number(value).toFixed(1)}/100`
  return value
}

// Para Excel/PDF: devuelve el valor crudo (no formateado)
const formatCellRaw = (value, key) => {
  if (value === null || value === undefined || value === '') return ''
  if (DATE_KEYS.has(key) && value) {
    const date = new Date(value)
    if (!Number.isNaN(date.getTime())) return date
  }
  if (['monto', 'precio', 'ingresos'].includes(key)) return Number(value)
  if (key === 'progreso') return Number(value) / 100
  if (key === 'nota') return Number(value)
  return value
}

const loadLogoToPngBase64 = (url) =>
  new Promise((resolve, reject) => {
    const image = new Image()
    image.crossOrigin = 'Anonymous'
    image.onload = () => {
      const canvas = document.createElement('canvas')
      canvas.width = image.width
      canvas.height = image.height
      canvas.getContext('2d').drawImage(image, 0, 0)
      resolve(canvas.toDataURL('image/png'))
    }
    image.onerror = reject
    image.src = url
  })

// ===== ACCIONES =====
const fetchReport = async () => {
  loading.value = true
  error.value = null
  page.value = 1

  try {
    const response = await api.get('/reportes/detalle', { params: { ...filters } })
    rows.value = response.data?.rows || []
    sortRowsByIdAsc()
  } catch (err) {
    console.error('Error fetching report:', err)
    error.value = err.response?.data?.message || 'Error al cargar los datos. Intenta de nuevo.'
    rows.value = []
  } finally {
    loading.value = false
  }
}

// Ordena filas por `id` de forma ascendente (numérico)
const sortRowsByIdAsc = () => {
  if (!Array.isArray(rows.value)) return
  rows.value.sort((a, b) => {
    const ai = Number(a?.id ?? 0)
    const bi = Number(b?.id ?? 0)
    return ai - bi
  })
}

// Calcula anchos para pdfMake según la naturaleza de la columna
const computePdfWidths = (cols, dataRows) => {
  return cols.map(col => {
    const key = col.key
    if (key === 'id') return 'auto'
    if (['monto', 'precio', 'ingresos', 'progreso', 'nota'].includes(key)) return 70
    if (['fecha', 'fecha_completado', 'fecha_registro', 'fecha_actualizacion', 'ultimo_acceso', 'fecha_inicio', 'fecha_finalizacion', 'fecha_pago', 'fecha_creacion'].includes(key)) return 80
    if (key === 'url_pdf') return 140
    if (['estudiante', 'nombre', 'curso', 'curso', 'codigo', 'evaluacion'].includes(key)) return '*'
    // fallback: auto for small values
    return 'auto'
  })
}

const onSearchInput = () => {
  if (searchDebounce) clearTimeout(searchDebounce)
  searchDebounce = setTimeout(() => {
    fetchReport()
  }, SEARCH_DEBOUNCE_MS)
}

const initColumnSelection = () => {
  selectedColumnKeys.value = new Set(
    currentReport.value.columns
      .filter(column => column.visible)
      .map(column => column.key)
  )
}

const toggleColumn = (key) => {
  const set = new Set(selectedColumnKeys.value)
  if (set.has(key)) set.delete(key)
  else set.add(key)
  selectedColumnKeys.value = set
}

const toggleAllColumns = () => {
  const shouldSelect = !allColumnsSelected.value
  const set = new Set()
  if (shouldSelect) {
    currentReport.value.columns.forEach(column => set.add(column.key))
  } else {
    currentReport.value.columns.forEach(column => {
      if (column.locked) set.add(column.key)
    })
  }
  selectedColumnKeys.value = set
}

const resetTypeSpecificFilters = () => {
  filters.status = ''
  filters.payment_status = ''
  filters.course_id = ''
  filters.search = ''
  filters.from = ''
  filters.to = ''
  datePickerRange.value = null
  selectedRange.value = ''
  // Reinicializar columnas visibles al cambiar de reporte
  initColumnSelection()
}

const clearFilters = () => {
  resetTypeSpecificFilters()
  error.value = null
  fetchReport()
}

const removeFilter = (key) => {
  if (key === 'from' || key === 'to') {
    clearDateRange()
  } else {
    filters[key] = ''
  }
  fetchReport()
}

const setDateRange = (range) => {
  const end = new Date()
  const start = new Date()
  switch (range) {
    case 'today': break
    case 'week': start.setDate(end.getDate() - 7); break
    case 'month': start.setDate(end.getDate() - 30); break
    case 'quarter': start.setDate(end.getDate() - 90); break
    case 'year': start.setMonth(0, 1); break
    default: return
  }
  filters.from = formatDateInput(start)
  filters.to = formatDateInput(end)
  datePickerRange.value = [start, end]
  selectedRange.value = range
  error.value = null
}

const clearDateRange = () => {
  filters.from = ''
  filters.to = ''
  selectedRange.value = ''
  datePickerRange.value = null
  error.value = null
}

const applyDateFilter = () => {
  if (dateRangeInvalid.value) return
  dateFilterOpen.value = false
  fetchReport()
}

const goToPage = (value) => {
  const num = Number(value)
  if (Number.isNaN(num)) return
  page.value = Math.min(Math.max(1, num), totalPages.value)
}

// ===== EXPORTACIONES =====
const exportData = async (format) => {
  if (exportStatus.value[format] !== 'idle' || !rows.value.length) return
  exportStatus.value[format] = 'loading'
  try {
    if (format === 'excel') await exportExcel()
    else await exportPdf()
    exportStatus.value[format] = 'success'
  } catch (err) {
    console.error(`Error exportando ${format}:`, err)
    exportStatus.value[format] = 'error'
  } finally {
    setTimeout(() => { exportStatus.value[format] = 'idle' }, EXPORT_FEEDBACK_MS)
  }
}

const exportExcel = async () => {
  const workbook = new ExcelJS.Workbook()
  const sheet = workbook.addWorksheet(currentReport.value.label.slice(0, 31))

  sheet.columns = columns.value.map(column => {
    const isNumeric = ['monto', 'precio', 'ingresos', 'progreso', 'nota'].includes(column.key)
    // Ajuste de ancho por tipo/clave
    let width = Math.max(12, Math.min(32, column.label.length + 8))
    if (column.key === 'id') width = 8
    if (['estudiante', 'nombre', 'curso'].includes(column.key)) width = 30
    if (['url_pdf'].includes(column.key)) width = 40
    if (['monto', 'precio', 'ingresos'].includes(column.key)) width = 14
    return {
      header: column.label,
      key: column.key,
      width,
      style: isNumeric ? { numFmt: '#,##0.00' } : undefined
    }
  })

  const headerRow = sheet.getRow(1)
  headerRow.height = 28
  headerRow.eachCell(cell => {
    cell.font = { name: 'Segoe UI', size: 10, bold: true, color: { argb: 'FFFFFFFF' } }
    cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FF0F766E' } }
    cell.alignment = { vertical: 'middle', horizontal: 'center' }
  })

  rows.value.forEach(row => {
    const values = {}
    columns.value.forEach(column => {
      values[column.key] = formatCellRaw(row[column.key], column.key)
    })
    const excelRow = sheet.addRow(values)
    excelRow.eachCell(cell => {
      cell.font = { name: 'Segoe UI', size: 10, color: { argb: 'FF1E293B' } }
      cell.alignment = { vertical: 'middle', wrapText: true }
      cell.border = { bottom: { style: 'thin', color: { argb: 'FFE2E8F0' } } }
    })
  })

  sheet.autoFilter = { from: { row: 1, column: 1 }, to: { row: 1, column: columns.value.length } }

  const buffer = await workbook.xlsx.writeBuffer()
  saveAs(
    new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }),
    `reporte_${filters.type}_${Date.now()}.xlsx`
  )
}

const exportPdf = async () => {
  let logo = null
  try {
    logo = await loadLogoToPngBase64(`${import.meta.env.BASE_URL}logo-dark.webp`)
  } catch (err) {
    console.warn('Logo no disponible', err)
  }

  const headerRow = columns.value.map(column => ({ text: column.label, style: 'tableHeader' }))
  const dataRows = rows.value.map(row =>
    columns.value.map(column => ({
      text: String(formatCell(row[column.key], column.key)),
      style: ['monto', 'precio', 'ingresos'].includes(column.key) ? 'numeric' : 'cell'
    }))
  )

  const body = [headerRow, ...dataRows]

  const widths = computePdfWidths(columns.value, rows.value)

  pdfMake.createPdf({
    pageSize: 'A4',
    pageOrientation: 'landscape',
    pageMargins: [30, 100, 30, 55],
    header: () => ({
      columns: [
        logo
          ? { image: logo, width: 125 }
          : { text: 'ENERVIDA', bold: true, color: '#0F766E' },
        {
          stack: [
            { text: currentReport.value.label.toUpperCase(), style: 'pdfTitle' },
            { text: `Generado: ${new Date().toLocaleString('es-BO')}`, style: 'pdfSubtitle' }
          ],
          alignment: 'right',
          margin: [0, 8, 0, 0]
        }
      ],
      margin: [30, 25, 30, 0]
    }),
    content: [
      {
        canvas: [{ type: 'line', x1: 0, y1: 0, x2: 782, y2: 0, lineWidth: 1.5, lineColor: '#0F766E' }],
        margin: [0, 0, 0, 16]
      },
      { text: 'RESUMEN DEL REPORTE', style: 'sectionTitle' },
      {
        text: `${rows.value.length} registros · Filtros aplicados: ${activeFilterCount.value}`,
        style: 'pdfSubtitle',
        margin: [0, 3, 0, 12]
      },
      {
        table: {
          headerRows: 1,
          widths,
          body
        },
        layout: {
          hLineColor: () => '#CBD5E1',
          vLineColor: () => '#E2E8F0',
          hLineWidth: () => 0.6,
          vLineWidth: () => 0.4
        }
      }
    ],
    styles: {
      pdfTitle: { fontSize: 15, bold: true, color: '#0F172A' },
      sectionTitle: { fontSize: 10, bold: true, color: '#0F766E', margin: [0, 0, 0, 2] },
      pdfSubtitle: { fontSize: 8, color: '#64748B' },
      tableHeader: {
        bold: true,
        color: 'white',
        fillColor: '#0F766E',
        fontSize: 8,
        alignment: 'center',
        margin: [0, 4, 0, 4]
      },
      cell: { fontSize: 8, color: '#1E293B' },
      numeric: { fontSize: 8, color: '#1E293B', alignment: 'right' },
      pdfLink: { fontSize: 8, color: '#1E40AF', decoration: 'underline', alignment: 'center' }
    },
    footer: (currentPage, pageCount) => ({
      columns: [
        { text: 'Enervida · Reporte operativo', fontSize: 8, color: '#64748B' },
        { text: `Página ${currentPage} de ${pageCount}`, alignment: 'right', fontSize: 8, color: '#64748B' }
      ],
      margin: [30, 0, 30, 0]
    })
  }).download(`reporte_${filters.type}_${Date.now()}.pdf`)
}

const downloadCertificate = async (id, row = {}) => {
  try {
    const response = await api.get(`/certificados/${id}/download`, { responseType: 'blob' })
    const blob = new Blob([response.data], { type: 'application/pdf' })
    const filename = row.codigo || row.codigo_certificado || `certificado_${id}`
    saveAs(blob, `${filename}.pdf`)
  } catch (err) {
    console.error('Error descargando certificado:', err)
    alert('No se pudo descargar el PDF del certificado. Revisa la consola para más detalles.')
  }
}

// ===== WATCHERS =====
watch(() => filters.type, () => {
  resetTypeSpecificFilters()
  fetchReport()
})

// ===== MONTAJE =====
onMounted(async () => {
  const updateTheme = () => {
    isDarkTheme.value = document.documentElement.classList.contains('dark')
  }
  updateTheme()
  themeObserver = new MutationObserver(updateTheme)
  themeObserver.observe(document.documentElement, { attributes: true, attributeFilter: ['class'] })

  initColumnSelection()

  try {
    courses.value = (await api.get('/cursos')).data || []
  } catch (err) {
    console.error('Error cargando cursos:', err)
    courses.value = []
  }
  await fetchReport()
})

onBeforeUnmount(() => {
  themeObserver?.disconnect()
  if (searchDebounce) clearTimeout(searchDebounce)
})
</script>

<style scoped>
.eyebrow, .field-label {
  display: block;
  font-size: 10px;
  font-weight: 900;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: #64748b;
}
.dark .eyebrow, .dark .field-label { color: rgba(255, 255, 255, 0.42); }

.filter-panel { color: #0f172a; }
.dark .filter-panel { color: #fff; }

.field-label { margin-bottom: 8px; }
.filter-field { display: block; min-width: 0; }

.field-control, .date-control {
  display: flex;
  align-items: center;
  gap: 10px;
  min-height: 48px;
  border: 1px solid #cbd5e1;
  border-radius: 14px;
  background: #f8fafc;
  padding: 0 14px;
  color: #64748b;
  transition: 0.25s;
}
.dark .field-control, .dark .date-control {
  border-color: rgba(255, 255, 255, 0.1);
  background: rgba(255, 255, 255, 0.05);
  color: rgba(255, 255, 255, 0.55);
}
.field-control:focus-within, .date-control:focus-within {
  border-color: #06b6d4;
  box-shadow: 0 0 0 3px rgba(6, 182, 212, 0.12);
}
.field-control input, .field-control select, .date-control input {
  width: 100%;
  border: 0;
  background: transparent;
  outline: 0;
  color: #0f172a;
  font-size: 13px;
  font-weight: 700;
}
.dark .field-control input, .dark .field-control select, .dark .date-control input { color: #fff; }

.filter-status {
  display: flex;
  align-items: center;
  gap: 8px;
  border-radius: 999px;
  background: rgba(6, 182, 212, 0.1);
  padding: 8px 12px;
  color: #0e7490;
  font-size: 10px;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.08em;
}
.dark .filter-status { color: #67e8f9; }
.status-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: currentColor;
  box-shadow: 0 0 8px currentColor;
  animation: status-pulse 2s ease-in-out infinite;
}
@keyframes status-pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

/* ===== Progress bar (requiere CSS por el gradiente) ===== */
.progress-bar {
  width: 80px;
  height: 6px;
  border-radius: 999px;
  background: rgba(148, 163, 184, 0.2);
  overflow: hidden;
  position: relative;
}
.progress-bar__fill {
  height: 100%;
  background: linear-gradient(90deg, #06b6d4, #14b8a6);
  border-radius: 999px;
  transition: width 0.4s ease;
}

/* ===== Resto del CSS (idéntico al original) ===== */
.filter-submit {
  display: flex;
  width: 100%;
  min-height: 48px;
  align-items: center;
  justify-content: center;
  gap: 8px;
  border-radius: 14px;
  background: #06b6d4;
  color: #07111f;
  font-size: 11px;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.12em;
  transition: 0.25s;
}
.filter-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(6, 182, 212, 0.25); }

.metric-card {
  position: relative;
  border-radius: 24px;
  background: var(--surface-container, #fff);
  border: 1px solid var(--admin-border, #e2e8f0);
  padding: 24px;
  box-shadow: var(--shadow-premium, 0 1px 3px rgba(0,0,0,0.05));
}
.dark .metric-card { border-color: rgba(255, 255, 255, 0.08); }

.report-table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  font-size: 13px;
}
.report-table thead th {
  position: sticky;
  top: 0;
  background: rgba(15, 23, 42, 0.04);
  color: #64748b;
  font-size: 10px;
  font-weight: 900;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  text-align: left;
  padding: 14px 18px;
  border-bottom: 1px solid #e2e8f0;
  white-space: nowrap;
}
.dark .report-table thead th {
  background: rgba(255, 255, 255, 0.04);
  color: rgba(255, 255, 255, 0.5);
  border-bottom-color: rgba(255, 255, 255, 0.08);
}
.report-table tbody td {
  padding: 14px 18px;
  border-bottom: 1px solid rgba(226, 232, 240, 0.6);
  color: #0f172a;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.dark .report-table tbody td {
  border-bottom-color: rgba(255, 255, 255, 0.05);
  color: #fff;
}

.page-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border-radius: 10px;
  border: 1px solid #e2e8f0;
  background: #f8fafc;
  color: #475569;
  transition: 0.2s;
}
.page-btn:hover:not(:disabled) { border-color: #06b6d4; color: #06b6d4; }
.page-btn:disabled { opacity: 0.4; cursor: not-allowed; }
.dark .page-btn {
  border-color: rgba(255, 255, 255, 0.1);
  background: rgba(255, 255, 255, 0.04);
  color: rgba(255, 255, 255, 0.6);
}

.date-filter {
  position: relative;
  border: 1px solid var(--input-border);
  border-radius: 18px;
  background: var(--admin-soft);
  padding: 16px;
}
.date-filter-summary {
  display: flex;
  align-items: center;
  gap: 8px;
  color: var(--on-surface);
  font-size: 13px;
  font-weight: 800;
}
.date-filter-popover {
  margin-top: 16px;
  border: 1px solid var(--admin-border-strong);
  border-radius: 16px;
  background: var(--surface-container);
  padding: 16px;
  box-shadow: var(--shadow-premium);
}
.date-filter-toggle {
  display: flex;
  align-items: center;
  gap: 8px;
  border: 1px solid var(--input-border);
  border-radius: 12px;
  background: var(--input-bg);
  padding: 11px 14px;
  color: var(--on-surface);
  font-size: 10px;
  font-weight: 900;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  transition: 0.25s;
}
.date-filter-toggle:hover, .date-filter-toggle.active {
  border-color: var(--accent-neon);
  background: rgba(52, 211, 153, 0.1);
  color: var(--accent-neon);
}
.date-cancel {
  border: 1px solid var(--input-border);
  border-radius: 12px;
  padding: 0 16px;
  color: var(--on-surface-variant);
  font-size: 10px;
  font-weight: 900;
  text-transform: uppercase;
}
.date-cancel:hover { background: var(--admin-soft-hover); color: var(--on-surface); }
.date-error { margin-top: 10px; color: var(--accent-red); font-size: 11px; font-weight: 700; }

.field-control :deep(.v-select) { flex: 1; min-width: 0; }
.field-control :deep(.vs__dropdown-toggle) { border: 0; padding: 0; background: transparent; }
.field-control :deep(.vs__selected), .field-control :deep(.vs__search), .field-control :deep(.vs__dropdown-menu) { font-size: 13px; font-weight: 700; }
.field-control :deep(.vs__selected), .field-control :deep(.vs__search) { color: var(--on-surface); margin: 0; padding: 0; }
.field-control :deep(.vs__search::placeholder), .field-control :deep(.vs__placeholder) { color: var(--on-surface-variant); opacity: 1; }
.field-control :deep(.vs__actions) { padding: 0; }
.field-control :deep(.vs__clear), .field-control :deep(.vs__open-indicator) { fill: var(--on-surface-variant); }
.field-control :deep(.vs__dropdown-menu) {
  border: 1px solid var(--input-border);
  background: var(--surface-container);
  color: var(--on-surface);
  margin-top: 10px;
  border-radius: 12px;
  overflow: hidden;
}
.field-control :deep(.vs__dropdown-option) { padding: 10px 12px; }
.field-control :deep(.vs__dropdown-option--highlight) { background: var(--accent-neon); color: #07111f; }

.report-date-picker { display: block; width: 100%; margin: 16px auto 0; max-width: 100%; }
.report-date-picker :deep(.dp__main) { width: 100%; }
.report-date-picker :deep(.dp__menu_inline) {
  width: 100%;
  border: 1px solid var(--input-border);
  border-radius: 14px;
  background: var(--surface-container);
  padding: 8px;
}
.report-date-picker :deep(.dp__calendar_header_item), .report-date-picker :deep(.dp__month_year_select) { color: var(--on-surface-variant); font-weight: 800; }
.report-date-picker :deep(.dp__cell_inner) { border-radius: 9px; }
.report-date-picker :deep(.dp__range_start), .report-date-picker :deep(.dp__range_end) { background: var(--accent-neon); color: #07111f; }
.report-date-picker :deep(.dp__range_between) { background: rgba(52, 211, 153, 0.16); color: var(--on-surface); }
.report-date-picker :deep(.dp__theme_dark) {
  --dp-background-color: var(--surface-container);
  --dp-text-color: var(--on-surface);
  --dp-hover-color: var(--admin-soft-hover);
  --dp-hover-text-color: var(--on-surface);
  --dp-hover-icon-color: var(--accent-neon);
  --dp-primary-color: var(--accent-neon);
  --dp-primary-text-color: #07111f;
  --dp-secondary-color: var(--on-surface-variant);
  --dp-border-color: var(--input-border);
  --dp-menu-border-color: var(--input-border);
  --dp-icon-color: var(--on-surface-variant);
  --dp-border-radius: 14px;
}
</style>
