<template>
  <div class="mx-auto max-w-[1400px] space-y-8 text-on-surface pb-20">
    <!-- Hero Section - Ultra Compact -->
    <section 
      class="panel-hero overflow-hidden rounded-[24px] px-6 py-5 relative group flex items-center justify-between"
      :class="{ 'animate-slide-up': mounted }"
    >
      <div class="absolute -right-20 -top-20 w-72 h-72 bg-accent-neon/10 rounded-full blur-[120px]"></div>
      
      <!-- Left: Title -->
      <div class="relative z-10 flex items-center gap-4">
        <div class="w-12 h-12 rounded-full bg-accent-neon/20 flex items-center justify-center">
          <span class="material-symbols-outlined text-accent-neon text-2xl">dashboard</span>
        </div>
        <div>
          <h2 class="font-lexend text-2xl md:text-3xl font-black tracking-tighter text-on-surface leading-none">
            Panel de <span class="text-accent-neon">Control</span>
          </h2>
          <p class="text-xs text-on-surface/50 font-medium mt-1">Visión general del sistema</p>
        </div>
      </div>
      

      <!-- Right: Date/Time (Redesigned) -->
      <div class="relative z-10 flex items-center gap-4 bg-surface/40 backdrop-blur-md !border-none rounded-[20px] px-5 py-3 shadow-sm">
        <div class="text-right">
          <p class="text-[9px] font-black uppercase tracking-[0.2em] text-cyan-400 mb-0.5">{{ currentDate }}</p>
          <p class="text-xl font-black font-lexend tracking-tighter text-on-surface leading-none">{{ currentHour }}</p>
        </div>
        <div class="w-10 h-10 rounded-full bg-gradient-to-br from-cyan-500/20 to-violet-500/20 flex items-center justify-center">
          <span class="material-symbols-outlined text-cyan-400 text-lg">schedule</span>
        </div>
      
      </div>
    </section>

    <!-- Metrics Grid - 4 cards -->
    <section class="grid grid-cols-2 gap-5 xl:grid-cols-4">
      <article 
        v-for="(stat, i) in metricCards" :key="stat.title" 
        class="glass-card rounded-[24px] p-5 transition-all duration-500 hover:-translate-y-1 group shadow-lg !border-none relative overflow-hidden"
        :class="{ 'animate-slide-up': mounted }"
        :style="{ animationDelay: `${(i + 1) * 100}ms` }"
      >
        <div class="absolute -right-8 -bottom-8 w-24 h-24 rounded-full blur-3xl transition-colors" :class="stat.glow"></div>
        <div class="flex items-center justify-between mb-4 relative z-10">
          <div class="grid h-10 w-10 place-items-center rounded-xl transition-all duration-500" :class="stat.iconBg">
            <span class="material-symbols-outlined text-lg">{{ stat.icon }}</span>
          </div>
          <span class="px-2 py-1 rounded-full text-[8px] font-black uppercase tracking-[0.15em]" :class="stat.badgeBg">
            {{ stat.badge }}
          </span>
        </div>
        <p class="text-[9px] font-black uppercase tracking-[0.25em] text-on-surface/35 mb-1 relative z-10">{{ stat.title }}</p>
        <h3 class="font-lexend font-black tracking-tighter transition-colors relative z-10 text-2xl" :class="stat.valueColor">
          {{ loading ? '...' : stat.value }}
        </h3>
      </article>
    </section>

    <!-- Charts Row -->
    <section 
      class="grid gap-8 xl:grid-cols-[1.2fr_0.8fr]"
      :class="{ 'animate-slide-up': mounted }"
      :style="{ animationDelay: '500ms' }"
    >
      <!-- Bar Chart - Inscripciones por Mes -->
      <article class="glass-card-premium rounded-[40px] p-8 !border-none shadow-xl group/card relative">
        <div class="mb-8 flex items-center justify-between">
          <div>
            <p class="text-[10px] font-black uppercase tracking-[0.3em] text-cyan-400 italic">Tendencia</p>
            <h3 class="mt-2 font-lexend text-2xl font-black tracking-tight">Inscripciones por Mes</h3>
          </div>
          <div class="flex items-center gap-3">
            <button @click="expandChart({
              type: Bar, data: barChartData, expandedOptions: barChartExpandedOptions, options: barChartOptions,
              title: 'Inscripciones por Mes', subtitle: 'Tendencia',
              icon: 'bar_chart', iconBg: 'bg-cyan-500/10', iconColor: 'text-cyan-400', textColor: 'text-cyan-400'
            })" 
            class="opacity-0 group-hover/card:opacity-100 w-10 h-10 rounded-xl bg-white/5 hover:bg-white/10 flex items-center justify-center text-white/70 hover:text-white transition-all" title="Agrandar gráfico">
              <span class="material-symbols-outlined text-lg">open_in_full</span>
            </button>
            <div class="w-12 h-12 rounded-xl bg-cyan-500/10 flex items-center justify-center text-cyan-400">
              <span class="material-symbols-outlined">bar_chart</span>
            </div>
          </div>
        </div>
        <div class="h-[280px] relative">
          <Bar v-if="barChartData" :data="barChartData" :options="barChartOptions" />
          <div v-else class="h-full flex items-center justify-center text-on-surface/20">
            <span class="material-symbols-outlined text-5xl animate-pulse">hourglass_empty</span>
          </div>
        </div>
      </article>

      <!-- Doughnut Chart - Top Courses -->
      <article class="glass-card-premium rounded-[40px] p-8 !border-none shadow-xl group/card relative">
        <div class="mb-8 flex items-center justify-between">
          <div>
            <p class="text-[10px] font-black uppercase tracking-[0.3em] text-violet-400 italic">Popularidad</p>
            <h3 class="mt-2 font-lexend text-2xl font-black tracking-tight">Top Cursos</h3>
          </div>
          <div class="flex items-center gap-3">
            <button @click="expandChart({
              type: Doughnut, data: doughnutChartData, expandedData: doughnutChartDataExpanded, expandedOptions: doughnutExpandedOptions, options: doughnutOptions,
              title: 'Top Cursos', subtitle: 'Popularidad',
              icon: 'donut_large', iconBg: 'bg-violet-500/10', iconColor: 'text-violet-400', textColor: 'text-violet-400'
            })" 
            class="opacity-0 group-hover/card:opacity-100 w-10 h-10 rounded-xl bg-white/5 hover:bg-white/10 flex items-center justify-center text-white/70 hover:text-white transition-all" title="Agrandar gráfico">
              <span class="material-symbols-outlined text-lg">open_in_full</span>
            </button>
            <div class="w-12 h-12 rounded-xl bg-violet-500/10 flex items-center justify-center text-violet-400">
              <span class="material-symbols-outlined">donut_large</span>
            </div>
          </div>
        </div>
        <div class="h-[280px] flex items-center justify-center">
          <Doughnut v-if="doughnutChartData" :data="doughnutChartData" :options="doughnutOptions" />
          <div v-else class="flex flex-col items-center justify-center text-on-surface/20 gap-3">
            <span class="material-symbols-outlined text-5xl">donut_large</span>
            <p class="text-xs font-medium italic">Sin datos de cursos</p>
          </div>
        </div>
      </article>
    </section>

    <!-- Additional Charts Row -->
    <section 
      class="grid gap-6 xl:grid-cols-3"
      :class="{ 'animate-slide-up': mounted }"
      :style="{ animationDelay: '600ms' }"
    >
      <!-- Users by Month -->
      <article class="glass-card-premium rounded-[32px] p-6 !border-none shadow-lg group/card relative">
        <div class="mb-6 flex items-center justify-between">
          <div>
            <p class="text-[9px] font-black uppercase tracking-[0.3em] text-emerald-400 italic">Crecimiento</p>
            <h3 class="mt-1 font-lexend text-lg font-black tracking-tight">Nuevos Usuarios</h3>
          </div>
          <div class="flex items-center gap-2">
            <button @click="expandChart({
              type: Line, data: usersChartData, expandedOptions: lineExpandedOptions, options: lineOptions,
              title: 'Nuevos Usuarios', subtitle: 'Crecimiento',
              icon: 'group_add', iconBg: 'bg-emerald-500/10', iconColor: 'text-emerald-400', textColor: 'text-emerald-400'
            })" 
            class="opacity-0 group-hover/card:opacity-100 w-8 h-8 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center text-white/70 hover:text-white transition-all" title="Agrandar gráfico">
              <span class="material-symbols-outlined text-base">open_in_full</span>
            </button>
            <div class="w-10 h-10 rounded-xl bg-emerald-500/10 flex items-center justify-center text-emerald-400">
              <span class="material-symbols-outlined text-lg">group_add</span>
            </div>
          </div>
        </div>
        <div class="h-[200px]">
          <Line v-if="usersChartData" :data="usersChartData" :options="lineOptions" />
          <div v-else class="h-full flex items-center justify-center"><span class="material-symbols-outlined animate-spin text-on-surface/20">sync</span></div>
        </div>
      </article>

      <!-- Courses by Category -->
      <article class="glass-card-premium rounded-[32px] p-6 !border-none shadow-lg group/card relative">
        <div class="mb-6 flex items-center justify-between">
          <div>
            <p class="text-[9px] font-black uppercase tracking-[0.3em] text-amber-400 italic">Distribución</p>
            <h3 class="mt-1 font-lexend text-lg font-black tracking-tight">Cursos por Categoría</h3>
          </div>
          <div class="flex items-center gap-2">
            <button @click="expandChart({
              type: Bar, data: categoryChartData, expandedData: categoryChartDataExpanded, expandedOptions: horizontalBarExpandedOptions, options: horizontalBarOptions,
              title: 'Cursos por Categoría', subtitle: 'Distribución',
              icon: 'category', iconBg: 'bg-amber-500/10', iconColor: 'text-amber-400', textColor: 'text-amber-400'
            })" 
            class="opacity-0 group-hover/card:opacity-100 w-8 h-8 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center text-white/70 hover:text-white transition-all" title="Agrandar gráfico">
              <span class="material-symbols-outlined text-base">open_in_full</span>
            </button>
            <div class="w-10 h-10 rounded-xl bg-amber-500/10 flex items-center justify-center text-amber-400">
              <span class="material-symbols-outlined text-lg">category</span>
            </div>
          </div>
        </div>
        <div class="h-[200px]">
          <Bar v-if="categoryChartData" :data="categoryChartData" :options="horizontalBarOptions" />
          <div v-else class="h-full flex items-center justify-center"><span class="material-symbols-outlined animate-spin text-on-surface/20">sync</span></div>
        </div>
      </article>

      <!-- Eval Results -->
      <article class="glass-card-premium rounded-[32px] p-6 !border-none shadow-lg group/card relative">
        <div class="mb-6 flex items-center justify-between">
          <div>
            <p class="text-[9px] font-black uppercase tracking-[0.3em] text-rose-400 italic">Rendimiento</p>
            <h3 class="mt-1 font-lexend text-lg font-black tracking-tight">Evaluaciones</h3>
          </div>
          <div class="flex items-center gap-2">
            <button @click="expandChart({
              type: Doughnut, data: evalChartData, expandedOptions: evalDoughnutExpandedOptions, options: evalDoughnutOptions,
              title: 'Evaluaciones', subtitle: 'Rendimiento',
              icon: 'quiz', iconBg: 'bg-rose-500/10', iconColor: 'text-rose-400', textColor: 'text-rose-400'
            })" 
            class="opacity-0 group-hover/card:opacity-100 w-8 h-8 rounded-lg bg-white/5 hover:bg-white/10 flex items-center justify-center text-white/70 hover:text-white transition-all" title="Agrandar gráfico">
              <span class="material-symbols-outlined text-base">open_in_full</span>
            </button>
            <div class="w-10 h-10 rounded-xl bg-rose-500/10 flex items-center justify-center text-rose-400">
              <span class="material-symbols-outlined text-lg">quiz</span>
            </div>
          </div>
        </div>
        <div class="h-[200px] flex justify-center">
          <Doughnut v-if="evalChartData" :data="evalChartData" :options="evalDoughnutOptions" />
          <div v-else class="h-full flex items-center justify-center"><span class="material-symbols-outlined animate-spin text-on-surface/20">sync</span></div>
        </div>
      </article>
    </section>

    <!-- Bottom Row: Status + Activity Feed -->
    <section 
      class="grid gap-8 xl:grid-cols-[0.9fr_1.1fr]"
      :class="{ 'animate-slide-up': mounted }"
      :style="{ animationDelay: '650ms' }"
    >
      <!-- System Status -->
      <article class="glass-card-premium rounded-[40px] p-8 flex flex-col h-full !border-none shadow-xl">
        <div class="mb-8 flex items-center justify-between gap-4">
          <div>
            <p class="text-[10px] font-black uppercase tracking-[0.3em] text-amber-400">Resumen</p>
            <h3 class="mt-2 font-lexend text-2xl font-black tracking-tight">Estado del Sistema</h3>
          </div>
          <div class="w-12 h-12 rounded-xl bg-amber-500/10 flex items-center justify-center text-amber-400">
            <span class="material-symbols-outlined">dashboard_customize</span>
          </div>
        </div>

        <div class="space-y-3 flex-1">
          <div v-for="item in systemStatus" :key="item.title" class="group/item relative overflow-hidden rounded-[18px] bg-on-surface/[0.02] p-4 hover:bg-on-surface/[0.04] transition-all duration-300">
            <div class="absolute left-0 top-0 bottom-0 w-1 transition-all" :class="item.barColor"></div>
            <div class="flex items-center justify-between gap-4 relative z-10">
              <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-xl flex items-center justify-center" :class="item.iconBg">
                  <span class="material-symbols-outlined text-lg">{{ item.icon }}</span>
                </div>
                <div>
                  <p class="font-bold text-on-surface text-sm tracking-tight leading-none mb-0.5">{{ item.title }}</p>
                  <p class="text-[11px] text-on-surface/35 font-medium">{{ item.detail }}</p>
                </div>
              </div>
              <span class="font-lexend text-lg font-black tracking-tighter" :class="item.valueColor">
                {{ loading ? '...' : item.value }}
              </span>
            </div>
          </div>
        </div>
      </article>

      <!-- Activity Feed -->
      <article class="glass-card-premium rounded-[40px] p-8 !border-none shadow-xl">
        <div class="mb-8 flex flex-col justify-between gap-4 sm:flex-row sm:items-center">
          <div>
            <p class="text-[10px] font-black uppercase tracking-[0.3em] text-emerald-400 italic">En Vivo</p>
            <h3 class="mt-2 font-lexend text-2xl font-black tracking-tight leading-none">Actividad Reciente</h3>
          </div>
          <div class="w-12 h-12 rounded-xl bg-emerald-500/10 flex items-center justify-center text-emerald-400">
            <span class="material-symbols-outlined">bolt</span>
          </div>
        </div>

        <div class="space-y-1.5 max-h-[380px] overflow-y-auto pr-2 custom-scroll">
          <div v-if="loading" class="flex items-center justify-center py-10 text-on-surface/20">
            <span class="material-symbols-outlined text-4xl animate-pulse">hourglass_empty</span>
          </div>
          <div 
            v-else
            v-for="(activity, i) in (stats.activities || [])" :key="i" 
            class="group/act flex items-center gap-3 p-3.5 rounded-[16px] hover:bg-on-surface/[0.03] transition-all duration-300"
          >
            <div class="shrink-0 w-9 h-9 rounded-xl flex items-center justify-center transition-all duration-500" :class="getActivityStyle(activity.type).bg">
              <span class="material-symbols-outlined text-lg" :class="getActivityStyle(activity.type).text">{{ activity.icon }}</span>
            </div>
            <div class="flex-1 min-w-0">
              <p class="font-bold text-on-surface text-sm tracking-tight truncate">{{ activity.title }}</p>
              <p class="text-[11px] text-on-surface/35 font-medium truncate">{{ activity.detail }}</p>
            </div>
            <div class="shrink-0 text-[9px] font-bold text-on-surface/25 uppercase tracking-wider flex items-center gap-1.5">
              <span class="w-1.5 h-1.5 rounded-full animate-pulse" :class="getActivityStyle(activity.type).dot"></span>
              {{ timeAgo(activity.time) }}
            </div>
          </div>
          <div v-if="!loading && (!stats.activities || stats.activities.length === 0)" class="text-center py-10 text-on-surface/30 text-sm italic">
            Sin actividad reciente
          </div>
        </div>
      </article>
    </section>

    <!-- Expand Chart Modal -->
    <Teleport to="body">
      <Transition name="fade">
        <div v-if="expandedChart" class="fixed inset-0 z-[100] flex items-center justify-center bg-[#09090b]/80 backdrop-blur-md p-4 sm:p-8" @click.self="expandedChart = null">
          <div class="glass-card-premium w-full max-w-6xl h-[85vh] flex flex-col rounded-[32px] overflow-hidden shadow-2xl relative !border-none animate-scale-up">
            <!-- Header -->
            <div class="px-8 py-6 !border-none flex items-center justify-between bg-white/[0.02] shadow-sm">
              <div class="flex items-center gap-4">
                <div class="w-14 h-14 rounded-2xl flex items-center justify-center shadow-inner" :class="expandedChart.iconBg">
                  <span class="material-symbols-outlined text-3xl" :class="expandedChart.iconColor">{{ expandedChart.icon }}</span>
                </div>
                <div>
                  <p class="text-[11px] font-black uppercase tracking-[0.3em] italic" :class="expandedChart.textColor">{{ expandedChart.subtitle }}</p>
                  <h3 class="mt-1 font-lexend text-3xl font-black tracking-tight text-white">{{ expandedChart.title }}</h3>
                </div>
              </div>
              <div class="flex items-center gap-2 sm:gap-4">
                <div class="flex items-center gap-2 bg-white/5 p-1 rounded-2xl !border-none shadow-inner">
                  <button @click="exportChart('pdf')" :disabled="exportStatus.pdf !== 'idle'" class="relative h-10 px-3 sm:px-4 rounded-xl hover:bg-rose-500/20 text-white/70 hover:text-rose-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] sm:text-xs tracking-wider transition-all flex items-center justify-center min-w-[70px] sm:min-w-[85px] overflow-hidden" title="Exportar a PDF">
                    <div v-if="exportStatus.pdf === 'idle'" class="flex items-center gap-1.5 transition-all">
                      <span class="material-symbols-outlined text-[18px]">picture_as_pdf</span>
                      <span class="hidden sm:inline">PDF</span>
                    </div>
                    <span v-else-if="exportStatus.pdf === 'loading'" class="material-symbols-outlined text-[18px] animate-spin text-rose-400">sync</span>
                    <span v-else-if="exportStatus.pdf === 'success'" class="material-symbols-outlined text-[22px] text-emerald-400 animate-bounce">check_circle</span>
                  </button>
                  <button @click="exportChart('image')" :disabled="exportStatus.image !== 'idle'" class="relative h-10 px-3 sm:px-4 rounded-xl hover:bg-emerald-500/20 text-white/70 hover:text-emerald-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] sm:text-xs tracking-wider transition-all flex items-center justify-center min-w-[70px] sm:min-w-[85px] overflow-hidden" title="Exportar a Imagen">
                    <div v-if="exportStatus.image === 'idle'" class="flex items-center gap-1.5 transition-all">
                      <span class="material-symbols-outlined text-[18px]">image</span>
                      <span class="hidden sm:inline">IMG</span>
                    </div>
                    <span v-else-if="exportStatus.image === 'loading'" class="material-symbols-outlined text-[18px] animate-spin text-emerald-400">sync</span>
                    <span v-else-if="exportStatus.image === 'success'" class="material-symbols-outlined text-[22px] text-emerald-400 animate-bounce">check_circle</span>
                  </button>
                  <button @click="exportChart('excel')" :disabled="exportStatus.excel !== 'idle'" class="relative h-10 px-3 sm:px-4 rounded-xl hover:bg-amber-500/20 text-white/70 hover:text-amber-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] sm:text-xs tracking-wider transition-all flex items-center justify-center min-w-[70px] sm:min-w-[85px] overflow-hidden" title="Exportar a Excel">
                    <div v-if="exportStatus.excel === 'idle'" class="flex items-center gap-1.5 transition-all">
                      <span class="material-symbols-outlined text-[18px]">table_view</span>
                      <span class="hidden sm:inline">XLS</span>
                    </div>
                    <span v-else-if="exportStatus.excel === 'loading'" class="material-symbols-outlined text-[18px] animate-spin text-amber-400">sync</span>
                    <span v-else-if="exportStatus.excel === 'success'" class="material-symbols-outlined text-[22px] text-emerald-400 animate-bounce">check_circle</span>
                  </button>
                </div>
                <div class="w-px h-8 bg-white/10"></div>
                <button @click="expandedChart = null" class="w-12 h-12 rounded-full bg-white/5 hover:bg-white/10 hover:text-rose-400 flex items-center justify-center transition-all">
                  <span class="material-symbols-outlined text-2xl">close</span>
                </button>
              </div>
            </div>
            
            <!-- Body -->
            <div class="flex-1 p-8 relative flex items-center justify-center min-h-0 bg-gradient-to-b from-white/[0.02] to-transparent">
               <div class="w-full h-full relative flex items-center justify-center">
                 <component 
                   :is="expandedChart.type" 
                   ref="chartRef"
                   v-if="expandedChart.data"
                   :data="expandedChart.expandedData || expandedChart.data" 
                   :options="{ ...(expandedChart.expandedOptions || expandedChart.options), maintainAspectRatio: false }" 
                   class="max-h-full max-w-full"
                 />
               </div>
            </div>
          </div>
        </div>
      </Transition>
    </Teleport>
  </div>
</template>

<script setup>
import { ref, shallowRef, onMounted, computed, onUnmounted, watch } from 'vue'
import { Bar, Doughnut, Line } from 'vue-chartjs'
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, ArcElement, LineElement, PointElement, Filler, Tooltip, Legend } from 'chart.js'
import api from '@/services/api'
import { useAuthStore } from '@/stores/auth'
import jsPDF from 'jspdf'
import * as XLSX from 'xlsx'

import ExcelJS from 'exceljs';
import { saveAs } from 'file-saver';
import pdfMake from 'pdfmake/build/pdfmake';
import * as pdfFonts from 'pdfmake/build/vfs_fonts';

pdfMake.vfs = pdfFonts.pdfMake ? pdfFonts.pdfMake.vfs : pdfMake.vfs;

ChartJS.register(CategoryScale, LinearScale, BarElement, ArcElement, LineElement, PointElement, Filler, Tooltip, Legend)

const expandedChart = shallowRef(null)
const chartRef = ref(null)

const exportStatus = ref({
  pdf: 'idle',
  image: 'idle',
  excel: 'idle'
})

const expandChart = (config) => {
  expandedChart.value = config
}


// Función auxiliar para cargar logos locales y convertirlos a PNG Base64 real
const loadLogoToPngBase64 = (url) => {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.crossOrigin = 'Anonymous';
    img.onload = () => {
      const canvas = document.createElement('canvas');
      canvas.width = img.width;
      canvas.height = img.height;
      const ctx = canvas.getContext('2d');
      ctx.drawImage(img, 0, 0);
      resolve(canvas.toDataURL('image/png'));
    };
    img.onerror = (e) => reject(e);
    img.src = url;
  });
};

// Helper seguro para convertir los SVG en imágenes PNG Base64 incrustables en pdfmake
const svgToPngBase64 = (svgString, width = 48, height = 48) => {
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

const exportChart = async (format) => {
  if (!expandedChart.value) return;
  if (exportStatus.value[format] !== 'idle') return;
  
  const titleSlug = expandedChart.value.title.replace(/\s+/g, '_').toLowerCase();
  const originalTitle = expandedChart.value.title;
  exportStatus.value[format] = 'loading';
  
  const pageWidth = 842.89; // Ancho A4 Landscape en puntos
  const usableWidth = pageWidth - 80; // Margen izquierdo y derecho de 40

  try {
    let downloadAction = null;
    
    await new Promise(r => setTimeout(r, 600));

    // ==========================================
    // 1. EXPORTAR A EXCEL
    // ==========================================
    if (format === 'excel') {
      const data = expandedChart.value.data;
      const labels = data.labels;
      const dataset = data.datasets[0];

      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Datos Estadísticos');

      worksheet.columns = [
        { header: 'CONCEPTO / ETIQUETA', key: 'label', width: 35 },
        { header: 'VALOR NUMÉRICO', key: 'value', width: 20 }
      ];

      const headerRow = worksheet.getRow(1);
      headerRow.height = 26;
      headerRow.eachCell((cell) => {
        cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FF2C3E50' } };
        cell.font = { name: 'Segoe UI', size: 11, bold: true, color: { argb: 'FFFFFFFF' } };
        cell.alignment = { vertical: 'middle', horizontal: 'center' };
      });

      labels.forEach((label, index) => {
        const row = worksheet.addRow({ label: label, value: dataset.data[index] });
        row.height = 20;
        row.getCell(1).font = { name: 'Segoe UI', size: 10 };
        row.getCell(1).alignment = { vertical: 'middle', horizontal: 'left' };
        row.getCell(2).font = { name: 'Segoe UI', size: 10, bold: true };
        row.getCell(2).alignment = { vertical: 'middle', horizontal: 'right' };
        row.getCell(2).numFmt = '#,##0.00'; 
        row.eachCell(cell => {
          cell.border = { bottom: { style: 'thin', color: { argb: 'FFE0E0E0' } } };
        });
      });

      downloadAction = async () => {
        const buffer = await workbook.xlsx.writeBuffer();
        const blob = new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
        saveAs(blob, `${titleSlug}_data_${Date.now()}.xlsx`);
      };

    // ==========================================
    // 2. EXPORTAR COMO IMAGEN PNG
    // ==========================================
    } else if (format === 'image') {
      const chartInstance = chartRef.value?.chart;
      if (!chartInstance) throw new Error("Chart not ready");
      const base64Image = chartInstance.toBase64Image();

      const a = document.createElement('a');
      a.href = base64Image;
      a.download = `${titleSlug}_graphic_${Date.now()}.png`;
      downloadAction = () => a.click();

    // ==========================================
    // 3. EXPORTAR A PDF (CON MEMBRETE Y PIE INSTITUCIONAL)
    // ==========================================
    } else if (format === 'pdf') {
      const chartInstance = chartRef.value?.chart;
      if (!chartInstance) throw new Error("Chart not ready");

      const originalXColor = chartInstance.options.scales?.x?.ticks?.color;
      const originalYColor = chartInstance.options.scales?.y?.ticks?.color;
      const originalGridXColor = chartInstance.options.scales?.x?.grid?.color;
      const originalGridYColor = chartInstance.options.scales?.y?.grid?.color;
      const originalLegendColor = chartInstance.options.plugins?.legend?.labels?.color;

      if (chartInstance.options.scales?.x?.ticks) chartInstance.options.scales.x.ticks.color = '#2C3E50';
      if (chartInstance.options.scales?.y?.ticks) chartInstance.options.scales.y.ticks.color = '#2C3E50';
      if (chartInstance.options.plugins?.legend?.labels) chartInstance.options.plugins.legend.labels.color = '#2C3E50';
      if (chartInstance.options.scales?.x?.grid) chartInstance.options.scales.x.grid.color = '#E2E8F0';
      if (chartInstance.options.scales?.y?.grid) chartInstance.options.scales.y.grid.color = '#E2E8F0';

      chartInstance.update('none'); 
      const base64Image = chartInstance.toBase64Image();

      if (chartInstance.options.scales?.x?.ticks) chartInstance.options.scales.x.ticks.color = originalXColor;
      if (chartInstance.options.scales?.y?.ticks) chartInstance.options.scales.y.ticks.color = originalYColor;
      if (chartInstance.options.plugins?.legend?.labels) chartInstance.options.plugins.legend.labels.color = originalLegendColor;
      if (chartInstance.options.scales?.x?.grid) chartInstance.options.scales.x.grid.color = originalGridXColor;
      if (chartInstance.options.scales?.y?.grid) chartInstance.options.scales.y.grid.color = originalGridYColor;
      
      chartInstance.update('none'); 

      // Cargar logo principal
      let logoDataUrl = null;
      try {
        const logoPath = `${import.meta.env.BASE_URL}logo-dark.webp`.replace(/\/+/g, '/');
        logoDataUrl = await loadLogoToPngBase64(logoPath);
      } catch (e) {
        console.warn("No se pudo procesar el logotipo", e);
      }

      // Cargar íconos corporativos y de redes sociales en paralelo
      const [iconLoc, iconPhone, iconWeb, iconRecycle, iconEmail, iconFb, iconTikTok, iconIn, iconYT, iconWsp] = await Promise.all([
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#E67E22" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="2" y1="12" x2="22" y2="12"/><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#7F8C8D" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="7 10 12 5 17 10"/><line x1="12" y1="5" x2="12" y2="22"/></svg>'), // Simulación icono reciclaje / o usa tu SVG de reciclaje
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14.5v-5h2v5h-2zm0-7v-2h2v2h-2z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M19.59 6.69a4.83 4.83 0 0 1-3.77-4.25V2h-3.45v13.67a2.89 2.89 0 0 1-5.2 1.74 2.89 2.89 0 0 1 2.31-4.64 2.93 2.93 0 0 1 .88.13V9.4a6.84 6.84 0 0 0-1-.05A6.33 6.33 0 0 0 5 20.1a6.34 6.34 0 0 0 10.86-4.43v-7a8.16 8.16 0 0 0 4.77 1.52v-3.4a4.85 4.85 0 0 1-1-.1z"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/><rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M22.54 6.42a2.78 2.78 0 0 0-1.95-1.96C18.88 4 12 4 12 4s-6.88 0-8.59.46a2.78 2.78 0 0 0-1.95 1.96A29 29 0 0 0 1 12a29 29 0 0 0 .46 5.58 2.78 2.78 0 0 0 1.95 1.96C5.12 20 12 20 12 20s6.88 0 8.59-.46a2.78 2.78 0 0 0 1.95-1.96A29 29 0 0 0 23 12a29 29 0 0 0-.46-5.58z"/><polygon points="9.75 15.02 15.5 12 9.75 8.98 9.75 15.02" fill="#fff"/></svg>'),
        svgToPngBase64('<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#E67E22"><path d="M.057 24l1.687-6.163c-1.041-1.804-1.588-3.849-1.587-5.946.003-6.556 5.338-11.891 11.893-11.891 3.181.001 6.167 1.24 8.413 3.488 2.245 2.248 3.481 5.236 3.48 8.414-.003 6.557-5.338 11.892-11.893 11.892-1.99-.001-3.951-.5-5.688-1.448l-6.305 1.654zm6.597-3.807c1.676.995 3.276 1.591 5.392 1.592 5.448 0 9.886-4.434 9.889-9.885.002-5.462-4.415-9.89-9.881-9.892-5.452 0-9.887 4.434-9.889 9.884-.001 2.225.651 3.891 1.746 5.634l-.999 3.648 3.742-.981z"/></svg>')
      ]);

      // Estructura de cabecera idéntica a tu imagen de referencia
      const contactInfo = [
        { text: 'Oficina Central y Centro Demostrativo:', bold: true, fontSize: 8, color: '#2C3E50' },
        { text: 'Calle Condorini, N° 118, zona Anari, Marquirivi\nGAMEP Achocalla, La Paz, Bolivia', fontSize: 8, color: '#2C3E50', margin: [0, 1, 0, 4] },
        { 
          columns: [
            ...(iconPhone ? [{ image: iconPhone, width: 10, height: 10, margin: [0, 1, 3, 0] }] : []),
            { text: '+591 732 36591  |  boris.ardaya@enervida.info', fontSize: 8, color: '#2C3E50' }
          ],
          columnGap: 4
        },
        { 
          columns: [
            ...(iconWeb ? [{ image: iconWeb, width: 10, height: 10, margin: [0, 1, 3, 0] }] : []),
            { text: 'www.enervida.info', fontSize: 8, color: '#2C3E50' }
          ],
          columnGap: 4,
          margin: [0, 2, 0, 0]
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
        margin: [40, 30, 40, 0]
      };

      const dividerLine = {
        canvas: [{ type: 'line', x1: 0, y1: 0, x2: usableWidth, y2: 0, lineWidth: 1.5, lineColor: '#E67E22' }],
        margin: [40, 8, 40, 20]
      };

      // Barra de redes sociales para el pie de página
      const socialIconsRow = [
        ...(iconEmail ? [{ image: iconEmail, width: 16, height: 16, link: 'mailto:boris.ardaya@enervida.info' }] : []),
        { text: '|', color: '#E67E22', fontSize: 12, margin: [2, 1, 2, 0] },
        ...(iconWeb ? [{ image: iconWeb, width: 16, height: 16, link: 'https://www.enervida.info' }] : []),
        { text: '|', color: '#E67E22', fontSize: 12, margin: [2, 1, 2, 0] },
        ...(iconFb ? [{ image: iconFb, width: 16, height: 16, link: 'http://www.facebook.com/Enervida.bo' }] : []),
        { text: '|', color: '#E67E22', fontSize: 12, margin: [2, 1, 2, 0] },
        ...(iconTikTok ? [{ image: iconTikTok, width: 16, height: 16, link: 'https://www.tiktok.com/@enervida.bo' }] : []),
        { text: '|', color: '#E67E22', fontSize: 12, margin: [2, 1, 2, 0] },
        ...(iconIn ? [{ image: iconIn, width: 16, height: 16, link: 'http://www.linkedin.com/in/enervida-73236591' }] : []),
        { text: '|', color: '#E67E22', fontSize: 12, margin: [2, 1, 2, 0] },
        ...(iconYT ? [{ image: iconYT, width: 16, height: 16, link: 'http://www.youtube.com/channel/UC1Otrq7UZlZrxEpRuQgz9Cg' }] : []),
        { text: '|', color: '#E67E22', fontSize: 12, margin: [2, 1, 2, 0] },
        ...(iconWsp ? [{ image: iconWsp, width: 16, height: 16, link: 'https://api.whatsapp.com/send?phone=59173236591&text=Hola!%20Estoy%20interesado%20en%20coordinar%20con%20ENERVIDA!' }] : [])
      ];

      const footerConfig = (currentPage, pageCount) => {
        return {
          stack: [
            {
              canvas: [{ type: 'line', x1: 0, y1: 0, x2: usableWidth, y2: 0, lineWidth: 1.5, lineColor: '#E67E22' }],
              margin: [40, 0, 40, 8]
            },
            {
              columns: [
                {
                  columns: [
                    ...(iconRecycle ? [{ image: iconRecycle, width: 12, height: 12, margin: [0, 0, 4, 0] }] : []),
                    { text: 'Utilizamos papel de reciclaje para contribuir a la ODS 13 – Acción por el clima.', fontSize: 8.5, color: '#2C3E50' }
                  ],
                  width: '*',
                  alignment: 'left'
                },
                {
                  text: `Página | ${currentPage}`,
                  alignment: 'right',
                  fontSize: 9,
                  bold: true,
                  color: '#2C3E50',
                  width: 'auto'
                }
              ],
              margin: [40, 0, 40, 6]
            },
            {
              columns: socialIconsRow,
              columnGap: 8,
              alignment: 'center',
              margin: [40, 0, 40, 15]
            }
          ]
        };
      };

      const docDefinition = {
        pageSize: 'A4',
        pageOrientation: 'landscape',
        pageMargins: [40, 105, 40, 85], // Espacios generosos para que el contenido no se encime con el header/footer
        header: headerConfig,
        content: [
          dividerLine,
          { text: 'REPORTE ESTADÍSTICO', style: 'pdfTitle', alignment: 'center' },
          { text: originalTitle.toUpperCase(), style: 'pdfSubtitle', alignment: 'center', margin: [0, 4, 0, 20] },
          {
            image: base64Image,
            width: 680, 
            alignment: 'center'
          }
        ],
        styles: {
          pdfTitle: { fontSize: 15, bold: true, color: '#2C3E50' },
          pdfSubtitle: { fontSize: 11, bold: true, color: '#E67E22' }
        },
        footer: footerConfig
      };

      downloadAction = () => pdfMake.createPdf(docDefinition).download(`${titleSlug}_report_${Date.now()}.pdf`);
    }

    exportStatus.value[format] = 'success';
    setTimeout(async () => {
      if (downloadAction) await downloadAction();
      setTimeout(() => {
        exportStatus.value[format] = 'idle';
      }, 500);
    }, 1200);

  } catch(e) {
    console.error("Error crítico durante la exportación:", e);
    exportStatus.value[format] = 'idle';
  }
};
const stats = ref({})
const topCourses = ref([])
const usersByMonth = ref([])
const coursesByCategory = ref([])
const evaluationResults = ref(null)

const loading = ref(true)
const mounted = ref(false)
const currentDate = ref('')
const currentHour = ref('')
let timeInterval = null

const updateTime = () => {
  const now = new Date()
  currentDate.value = now.toLocaleDateString('es-BO', { weekday: 'long', day: 'numeric', month: 'long' })
  currentHour.value = now.toLocaleTimeString('es-BO', { hour: '2-digit', minute: '2-digit'})
}

const formatMoney = (val) => `${Number(val || 0).toLocaleString('es-BO', { minimumFractionDigits: 2 })} Bs`

const normalizeReportCollection = (data) => {
  if (Array.isArray(data)) return data
  if (!data || typeof data !== 'object') return []
  if (Array.isArray(data.data)) return data.data
  if (Array.isArray(data.items)) return data.items
  if (Array.isArray(data.results)) return data.results
  return []
}

const safeArray = (value) => Array.isArray(value) ? value : []

const authStore = useAuthStore()

const fetchData = async () => {
  loading.value = true
  try {
    const canDashboard = authStore.canAccess('DASHBOARD')
    const canReportes = authStore.canAccess('REPORTES')
    const requests = []

    if (canDashboard) {
      requests.push(api.get('/reportes/dashboard'))
    }

    if (canReportes) {
      requests.push(api.get('/reportes/inscripciones-por-curso'))
      requests.push(api.get('/reportes/usuarios-por-mes'))
      requests.push(api.get('/reportes/cursos-por-categoria'))
      requests.push(api.get('/reportes/evaluaciones-resultados'))
    }

    const results = await Promise.all(requests.map((req) => req.catch((err) => err)))

    let index = 0
    if (canDashboard) {
      const dashRes = results[index++] || null
      stats.value = dashRes instanceof Error ? {} : dashRes.data
    } else {
      stats.value = {}
    }

    if (canReportes) {
      const coursesRes = results[index++] || null
      const usersRes = results[index++] || null
      const catRes = results[index++] || null
      const evalRes = results[index++] || null
      topCourses.value = coursesRes instanceof Error ? [] : coursesRes.data
      usersByMonth.value = usersRes instanceof Error ? [] : usersRes.data
      coursesByCategory.value = catRes instanceof Error ? [] : catRes.data
      evaluationResults.value = evalRes instanceof Error ? null : evalRes.data
    } else {
      topCourses.value = []
      usersByMonth.value = []
      coursesByCategory.value = []
      evaluationResults.value = null
    }
  } catch (e) {
    console.error('Dashboard error:', e)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  updateTime()
  timeInterval = setInterval(updateTime, 30000)
  fetchData()
  setTimeout(() => { mounted.value = true }, 50)
})

onUnmounted(() => { if (timeInterval) clearInterval(timeInterval) })

// Metric Cards - 4 compact cards (removed Ingresos)
const metricCards = computed(() => [
  {
    title: 'Estudiantes', value: stats.value.totalEstudiantes || 0, icon: 'groups', badge: 'Comunidad',
    iconBg: 'bg-cyan-500/10 text-cyan-400', badgeBg: 'bg-cyan-500/10 text-cyan-400',
    glow: 'bg-cyan-500/5 group-hover:bg-cyan-500/10', valueColor: 'group-hover:text-cyan-400'
  },
  {
    title: 'Cursos', value: stats.value.totalCursos || 0, icon: 'auto_stories', badge: 'Academia',
    iconBg: 'bg-violet-500/10 text-violet-400', badgeBg: 'bg-violet-500/10 text-violet-400',
    glow: 'bg-violet-500/5 group-hover:bg-violet-500/10', valueColor: 'group-hover:text-violet-400'
  },
  {
    title: 'Inscripciones', value: stats.value.totalInscripciones || 0, icon: 'how_to_reg', badge: 'Total',
    iconBg: 'bg-emerald-500/10 text-emerald-400', badgeBg: 'bg-emerald-500/10 text-emerald-400',
    glow: 'bg-emerald-500/5 group-hover:bg-emerald-500/10', valueColor: 'group-hover:text-emerald-400'
  },
  {
    title: 'Pendientes', value: stats.value.pendingInscriptions || 0, icon: 'pending_actions', badge: 'Atención',
    iconBg: 'bg-amber-500/10 text-amber-400', badgeBg: 'bg-amber-500/10 text-amber-400',
    glow: 'bg-amber-500/5 group-hover:bg-amber-500/10', valueColor: 'group-hover:text-amber-400'
  }
])

// Main Bar Chart
const barChartData = computed(() => {
  if (!stats.value.trend) return null
  const labels = stats.value.trend.map(t => t.month)
  const data = stats.value.trend.map(t => t.count)
  const backgrounds = data.map((_, i) => chartColors[i % chartColors.length])
  return {
    labels,
    datasets: [{
      label: 'Inscripciones',
      data,
      backgroundColor: backgrounds,
      borderColor: backgrounds.map(c => c),
      borderWidth: 0,
      borderRadius: 12,
      borderSkipped: false,
      barPercentage: 0.6,
      categoryPercentage: 0.7
    }]
  }
})

const tooltipCallbacks = {
  title: function(context) {
    const item = context[0]
    if (item.dataset.fullLabels) {
      const text = item.dataset.fullLabels[item.dataIndex]
      // Dividir el texto en múltiples líneas si es muy largo para mejor legibilidad
      if (text && text.length > 40) {
         return text.match(/.{1,40}(\s|$)/g) || text
      }
      return text
    }
    return item.label
  },
  label: function(context) {
    let label = context.dataset.label || ''
    if (label) label += ': '
    label += context.formattedValue

    // Cálculo y visualización de porcentajes detallados para gráficos circulares
    if (context.chart.config.type === 'doughnut' || context.chart.config.type === 'pie') {
      const dataArr = context.chart.data.datasets[0].data
      const sum = dataArr.reduce((a, b) => a + b, 0)
      const val = context.raw
      const percentage = sum > 0 ? ((val * 100) / sum).toFixed(1) + '%' : '0%'
      return `${label} (${percentage} del total)`
    }
    return label
  }
}

const barChartOptions = computed(() => ({
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: { display: false },
    tooltip: {
      backgroundColor: palette.value.tooltipBg,
      titleColor: palette.value.tooltipTitle,
      bodyColor: palette.value.tooltipBody,
      borderColor: palette.value.ticks,
      borderWidth: 1,
      cornerRadius: 12,
      padding: 14,
      titleFont: { size: 14, weight: 'bold', family: "'Inter', sans-serif" },
      bodyFont: { size: 13, family: "'Inter', sans-serif" },
      displayColors: true,
      boxPadding: 6,
      usePointStyle: true,
      callbacks: tooltipCallbacks
    }
  },
  scales: {
    x: {
      grid: { display: false },
      ticks: { color: palette.value.ticks, font: { size: 11, weight: 'bold' } }
    },
    y: {
      grid: { color: palette.value.grid, drawBorder: false },
      ticks: { color: palette.value.ticks, font: { size: 11 }, stepSize: 1 },
      beginAtZero: true
    }
  }
}))

const barChartExpandedOptions = computed(() => ({
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: { 
      display: true,
      position: 'top',
      labels: { color: palette.value.ticksStrong, font: { size: 14, weight: 'bold' }, padding: 20 }
    },
    tooltip: {
      backgroundColor: palette.value.tooltipBg,
      titleColor: palette.value.tooltipTitle,
      bodyColor: palette.value.tooltipBody,
      borderColor: palette.value.ticks,
      borderWidth: 1,
      cornerRadius: 12,
      padding: 16,
      titleFont: { size: 16, weight: 'bold', family: "'Inter', sans-serif" },
      bodyFont: { size: 15, family: "'Inter', sans-serif" },
      displayColors: true,
      boxPadding: 8,
      usePointStyle: true,
      callbacks: tooltipCallbacks
    }
  },
  scales: {
    x: {
      grid: { display: false },
      ticks: { color: palette.value.ticksStrong, font: { size: 13, weight: 'bold' } }
    },
    y: {
      grid: { color: palette.value.gridStrong, drawBorder: false },
      ticks: { color: palette.value.ticksStrong, font: { size: 13 }, stepSize: 1 },
      beginAtZero: true
    }
  }
}))

// Theme detection and palette (light/dark)
const isDark = ref(true)
const detectTheme = () => {
  const html = document.documentElement
  if (html.classList.contains('dark')) return true
  if (html.classList.contains('light')) return false
  const dt = html.getAttribute('data-theme')
  if (dt === 'dark') return true
  if (dt === 'light') return false
  // fallback: assume dark if background is very dark
  const bg = getComputedStyle(document.body).backgroundColor
  const m = bg.match(/\d+/g)
  if (m) {
    const [r, g, b] = m.slice(0, 3).map(Number)
    const l = (0.299 * r + 0.587 * g + 0.114 * b) / 255
    return l < 0.5
  }
  return true
}

const palette = computed(() => {
  if (isDark.value) {
    return {
      ticks: 'rgba(255,255,255,0.35)',
      ticksStrong: 'rgba(255,255,255,0.8)',
      grid: 'rgba(255,255,255,0.04)',
      gridStrong: 'rgba(255,255,255,0.1)',
      tooltipBg: 'rgba(15,23,42,0.95)',
      tooltipTitle: '#22d3ee',
      tooltipBody: '#e2e8f0',
      border: 'rgba(15,23,42,0.8)',
      legend: 'rgba(255,255,255,0.5)'
    }
  }
  return {
    ticks: 'rgba(17,24,39,0.75)',
    ticksStrong: 'rgba(17,24,39,0.95)',
    grid: 'rgba(15,23,42,0.04)',
    gridStrong: 'rgba(15,23,42,0.1)',
    tooltipBg: '#ffffff',
    tooltipTitle: '#0f172a',
    tooltipBody: '#0f172a',
    border: '#ffffff',
    legend: 'rgba(17,24,39,0.65)'
  }
})

let themeObserver = null

onMounted(() => {
  // existing onMounted code will run after this block; ensure we set initial theme
  isDark.value = detectTheme()
  themeObserver = new MutationObserver(() => {
    isDark.value = detectTheme()
  })
  themeObserver.observe(document.documentElement, { attributes: true, attributeFilter: ['class', 'data-theme', 'style'] })
})

onUnmounted(() => {
  if (themeObserver) themeObserver.disconnect()
})

// Doughnut Chart
const chartColors = ['#22d3ee', '#a78bfa', '#34d399', '#fbbf24', '#f87171']

const doughnutChartData = computed(() => {
  if (!topCourses.value.length) return null
  return {
    labels: topCourses.value.map(c => c.titulo.length > 18 ? c.titulo.slice(0, 18) + '…' : c.titulo),
    datasets: [{
      label: 'Inscripciones',
      fullLabels: topCourses.value.map(c => c.titulo),
      data: topCourses.value.map(c => c.inscripciones ?? c._count?.inscripciones ?? 0),
      backgroundColor: chartColors,
      borderColor: 'rgba(15,23,42,0.8)',
      borderWidth: 4,
      hoverOffset: 8
    }]
  }
})

const doughnutChartDataExpanded = computed(() => {
  if (!topCourses.value.length) return null
  return {
    labels: topCourses.value.map(c => c.titulo),
    datasets: [{
      label: 'Inscripciones',
      fullLabels: topCourses.value.map(c => c.titulo),
      data: topCourses.value.map(c => c.inscripciones ?? c._count?.inscripciones ?? 0),
      backgroundColor: chartColors,
      borderColor: 'rgba(15,23,42,0.8)',
      borderWidth: 4,
      hoverOffset: 12
    }]
  }
})

const doughnutOptions = computed(() => ({
  responsive: true,
  maintainAspectRatio: false,
  cutout: '65%',
  plugins: {
    legend: {
      position: 'bottom',
      labels: { color: palette.value.legend, font: { size: 10, weight: 'bold' }, padding: 14, usePointStyle: true, pointStyleWidth: 8 }
    },
    tooltip: {
      backgroundColor: palette.value.tooltipBg,
      titleColor: palette.value.tooltipTitle,
      bodyColor: palette.value.tooltipBody,
      borderColor: palette.value.ticks,
      borderWidth: 1,
      cornerRadius: 12,
      padding: 16,
      titleFont: { size: 14, weight: 'bold', family: "'Inter', sans-serif" },
      bodyFont: { size: 13, family: "'Inter', sans-serif" },
      displayColors: true,
      boxPadding: 6,
      usePointStyle: true,
      callbacks: tooltipCallbacks
    }
  }
}))

const doughnutExpandedOptions = computed(() => ({
  responsive: true,
  maintainAspectRatio: false,
  cutout: '50%',
  plugins: {
    legend: {
      position: 'right',
      labels: { color: palette.value.ticksStrong, font: { size: 14, weight: 'bold' }, padding: 24, usePointStyle: true, pointStyleWidth: 12 }
    },
    tooltip: barChartExpandedOptions.value.plugins.tooltip
  }
}))

// Users Line Chart
const usersChartData = computed(() => {
  if (!usersByMonth.value.length) return null
  return {
    labels: usersByMonth.value.map(u => u.month),
    datasets: [{
      label: 'Nuevos Usuarios',
      data: usersByMonth.value.map(u => u.count),
      borderColor: '#34d399',
      backgroundColor: 'rgba(52, 211, 153, 0.1)',
      borderWidth: 3,
      fill: true,
      tension: 0.4,
      pointBackgroundColor: '#0f172a',
      pointBorderColor: '#34d399',
      pointBorderWidth: 2,
      pointRadius: 4
    }]
  }
})

const lineOptions = computed(() => ({
  responsive: true, maintainAspectRatio: false,
  plugins: { legend: { display: false }, tooltip: barChartOptions.value.plugins.tooltip },
  scales: {
    x: { grid: { display: false }, ticks: { color: palette.value.ticks, font: { size: 10 } } },
    y: { grid: { color: palette.value.grid }, ticks: { color: palette.value.ticks, font: { size: 10 }, stepSize: 1 }, beginAtZero: true }
  }
}))

const lineExpandedOptions = computed(() => ({
  responsive: true, maintainAspectRatio: false,
  plugins: { 
    legend: { display: true, position: 'top', labels: { color: palette.value.ticksStrong, font: { size: 14, weight: 'bold' } } }, 
    tooltip: barChartExpandedOptions.value.plugins.tooltip 
  },
  scales: {
    x: { grid: { display: false }, ticks: { color: palette.value.ticksStrong, font: { size: 13, weight: 'bold' } } },
    y: { grid: { color: palette.value.gridStrong }, ticks: { color: palette.value.ticksStrong, font: { size: 13 }, stepSize: 1 }, beginAtZero: true }
  }
}))

// Category Horizontal Bar Chart
const categoryChartData = computed(() => {
  const categories = safeArray(coursesByCategory.value)
  if (!categories.length) return null
  return {
    labels: categories.map(c => {
      const name = c.nombre || ''
      return name.length > 12 ? name.slice(0, 12) + '…' : name
    }),
    datasets: [{
      label: 'Cursos',
      fullLabels: categories.map(c => c.nombre || ''),
      data: categories.map(c => Number(c.count ?? c._count?.cursos ?? 0)),
      backgroundColor: categories.map((_, index) => chartColors[index % chartColors.length]),
      borderColor: categories.map((_, index) => chartColors[index % chartColors.length]),
      borderRadius: 4,
      barPercentage: 0.6
    }]
  }
})

const categoryChartDataExpanded = computed(() => {
  const categories = safeArray(coursesByCategory.value)
  if (!categories.length) return null
  return {
    labels: categories.map(c => c.nombre || ''), // Texto completo
    datasets: [{
      label: 'Cursos',
      fullLabels: categories.map(c => c.nombre || ''),
      data: categories.map(c => Number(c.count ?? c._count?.cursos ?? 0)),
      backgroundColor: categories.map((_, index) => chartColors[index % chartColors.length]),
      borderColor: categories.map((_, index) => chartColors[index % chartColors.length]),
      borderRadius: 6,
      barPercentage: 0.7
    }]
  }
})

const horizontalBarOptions = computed(() => ({
  indexAxis: 'y',
  responsive: true, maintainAspectRatio: false,
  plugins: { legend: { display: false }, tooltip: barChartOptions.value.plugins.tooltip },
  scales: {
    x: { grid: { color: palette.value.grid }, ticks: { color: palette.value.ticks, font: { size: 10 }, stepSize: 1 }, beginAtZero: true },
    y: { grid: { display: false }, ticks: { color: palette.value.legend, font: { size: 10 } } }
  }
}))

const horizontalBarExpandedOptions = computed(() => ({
  indexAxis: 'y',
  responsive: true, maintainAspectRatio: false,
  plugins: { 
    legend: { display: true, position: 'top', labels: { color: palette.value.ticksStrong, font: { size: 14, weight: 'bold' } } }, 
    tooltip: barChartExpandedOptions.value.plugins.tooltip 
  },
  scales: {
    x: { grid: { color: palette.value.gridStrong }, ticks: { color: palette.value.ticksStrong, font: { size: 13 }, stepSize: 1 }, beginAtZero: true },
    y: { grid: { display: false }, ticks: { color: palette.value.ticksStrong, font: { size: 14, weight: 'bold' } } }
  }
}))

// Eval Results Doughnut
const evalChartData = computed(() => {
  if (!evaluationResults.value) return null
  return {
    labels: ['Aprobados', 'Reprobados'],
    datasets: [{
      data: [evaluationResults.value.aprobados, evaluationResults.value.reprobados],
      backgroundColor: ['#34d399', '#f43f5e'],
      borderColor: 'rgba(15,23,42,0.8)',
      borderWidth: 2,
      hoverOffset: 4
    }]
  }
})

const evalDoughnutOptions = computed(() => ({
  responsive: true, maintainAspectRatio: false, cutout: '70%',
  plugins: {
    legend: { position: 'bottom', labels: { color: palette.value.legend, font: { size: 10 }, usePointStyle: true, padding: 10 } },
    tooltip: barChartOptions.value.plugins.tooltip
  }
}))

const evalDoughnutExpandedOptions = computed(() => ({
  responsive: true, maintainAspectRatio: false, cutout: '60%',
  plugins: {
    legend: { position: 'right', labels: { color: palette.value.ticksStrong, font: { size: 14, weight: 'bold' }, usePointStyle: true, padding: 24 } },
    tooltip: barChartExpandedOptions.value.plugins.tooltip
  }
}))

// System Status
const systemStatus = computed(() => [
  { title: 'Cursos Publicados', detail: 'Total en plataforma', value: stats.value.totalCursos || 0, icon: 'school', barColor: 'bg-cyan-400', iconBg: 'bg-cyan-500/10 text-cyan-400', valueColor: 'text-cyan-400' },
  { title: 'Estudiantes', detail: 'Usuarios registrados', value: stats.value.totalEstudiantes || 0, icon: 'groups', barColor: 'bg-violet-400', iconBg: 'bg-violet-500/10 text-violet-400', valueColor: 'text-violet-400' },
  { title: 'Pendientes', detail: 'Requieren aprobación', value: stats.value.pendingInscriptions || 0, icon: 'pending', barColor: 'bg-amber-400', iconBg: 'bg-amber-500/10 text-amber-400', valueColor: 'text-amber-400' },
  { title: 'Ingresos', detail: 'Suma total', value: formatMoney(stats.value.totalVentas), icon: 'account_balance', barColor: 'bg-emerald-400', iconBg: 'bg-emerald-500/10 text-emerald-400', valueColor: 'text-emerald-400' }
])

// Activity helpers
const activityStyles = {
  INSCRIPCION: { bg: 'bg-cyan-500/10', text: 'text-cyan-400', dot: 'bg-cyan-400' },
  REGISTRO: { bg: 'bg-violet-500/10', text: 'text-violet-400', dot: 'bg-violet-400' },
  CURSO_NUEVO: { bg: 'bg-emerald-500/10', text: 'text-emerald-400', dot: 'bg-emerald-400' },
  CERTIFICADO: { bg: 'bg-amber-500/10', text: 'text-amber-400', dot: 'bg-amber-400' },
  EVALUACION: { bg: 'bg-rose-500/10', text: 'text-rose-400', dot: 'bg-rose-400' },
}

const getActivityStyle = (type) => activityStyles[type] || activityStyles.REGISTRO

const timeAgo = (date) => {
  if (!date) return ''
  const diff = Date.now() - new Date(date).getTime()
  const mins = Math.floor(diff / 60000)
  if (mins < 1) return 'Ahora'
  if (mins < 60) return `${mins}m`
  const hrs = Math.floor(mins / 60)
  if (hrs < 24) return `${hrs}h`
  return `${Math.floor(hrs / 24)}d`
}
</script>

<style scoped>
.animate-slide-up {
  animation: slideUp 0.7s cubic-bezier(0.16, 1, 0.3, 1) both;
}

.animate-scale-up {
  animation: scaleUp 0.4s cubic-bezier(0.16, 1, 0.3, 1) both;
}

@keyframes scaleUp {
  from { opacity: 0; transform: scale(0.95) translateY(10px); }
  to { opacity: 1; transform: scale(1) translateY(0); }
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

@keyframes slideUp {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}

.custom-scroll::-webkit-scrollbar { width: 4px; }
.custom-scroll::-webkit-scrollbar-track { background: transparent; }
.custom-scroll::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 10px; }
.custom-scroll::-webkit-scrollbar-thumb:hover { background: rgba(255,255,255,0.2); }
</style>
