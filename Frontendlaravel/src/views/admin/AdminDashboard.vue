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
import { ref, shallowRef, onMounted, computed, onUnmounted } from 'vue'
import { Bar, Doughnut, Line } from 'vue-chartjs'
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, ArcElement, LineElement, PointElement, Filler, Tooltip, Legend } from 'chart.js'
import api from '@/services/api'
import jsPDF from 'jspdf'
import * as XLSX from 'xlsx'

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

const exportChart = async (format) => {
  if (!expandedChart.value) return
  if (exportStatus.value[format] !== 'idle') return
  
  const title = expandedChart.value.title.replace(/\s+/g, '_').toLowerCase()
  exportStatus.value[format] = 'loading'
  
  try {
    let downloadAction = null;
    
    // Simular un tiempo de procesamiento para el spinner
    await new Promise(r => setTimeout(r, 600));

    if (format === 'excel') {
      const data = expandedChart.value.data
      const labels = data.labels
      const dataset = data.datasets[0] // Asumimos un solo dataset para estos gráficos

      const rows = labels.map((label, index) => ({
        Etiqueta: label,
        Valor: dataset.data[index]
      }))
      
      const worksheet = XLSX.utils.json_to_sheet(rows)
      const workbook = XLSX.utils.book_new()
      XLSX.utils.book_append_sheet(workbook, worksheet, "Datos")
      
      downloadAction = () => XLSX.writeFile(workbook, `${title}_${Date.now()}.xlsx`)
    } else {
      const chartInstance = chartRef.value?.chart
      if (!chartInstance) throw new Error("Chart not ready")
      const base64Image = chartInstance.toBase64Image()

      if (format === 'image') {
        const a = document.createElement('a')
        a.href = base64Image
        a.download = `${title}_${Date.now()}.png`
        downloadAction = () => a.click()
      } else if (format === 'pdf') {
        const pdf = new jsPDF('landscape')
        
        // Customizing PDF Layout (Professional)
        pdf.setFillColor(15, 23, 42) // Dark slate background for header
        pdf.rect(0, 0, 297, 45, 'F')
        
        const logoUrl = '/logo-light.webp'
        const loadImg = (src) => new Promise((resolve, reject) => {
          const img = new Image()
          img.onload = () => resolve(img)
          img.onerror = reject
          img.src = src
        })
        
        try {
           const img = await loadImg(logoUrl)
           const canvas = document.createElement('canvas')
           canvas.width = img.width
           canvas.height = img.height
           const ctx = canvas.getContext('2d')
           ctx.drawImage(img, 0, 0)
           const logoData = canvas.toDataURL('image/png')
           pdf.addImage(logoData, 'PNG', 15, 10, 35, 25)
        } catch(e) {
           console.warn("Could not load logo", e)
        }

        // Title and Subtitle
        pdf.setTextColor(255, 255, 255)
        pdf.setFontSize(24)
        pdf.setFont('helvetica', 'bold')
        pdf.text("Reporte Estadístico", 60, 22)
        
        pdf.setFontSize(14)
        pdf.setFont('helvetica', 'normal')
        pdf.setTextColor(34, 211, 238) // Cyan-400
        pdf.text(expandedChart.value.title.toUpperCase(), 60, 32)
        
        // Date on the right
        pdf.setTextColor(255, 255, 255)
        pdf.setFontSize(10)
        const dateStr = new Date().toLocaleDateString('es-BO', { year: 'numeric', month: 'long', day: 'numeric' })
        pdf.text(`Fecha: ${dateStr}`, 275, 25, { align: 'right' })

        // Draw chart background
        pdf.setFillColor(248, 250, 252) // slate-50
        pdf.rect(15, 50, 267, 140, 'F')

        // Insert chart
        pdf.addImage(base64Image, 'PNG', 20, 55, 257, 130)
        
        // Footer
        pdf.setFillColor(241, 245, 249) // slate-100
        pdf.rect(0, 195, 297, 15, 'F')
        pdf.setTextColor(100, 116, 139)
        pdf.setFontSize(10)
        pdf.text("Generado por el Sistema de Administración LMS", 15, 204)
        pdf.text("Confidencial - Uso Interno", 282, 204, { align: 'right' })

        downloadAction = () => pdf.save(`${title}_${Date.now()}.pdf`)
      }
    }

    exportStatus.value[format] = 'success'
    setTimeout(() => {
      if (downloadAction) downloadAction()
      setTimeout(() => {
        exportStatus.value[format] = 'idle'
      }, 500)
    }, 1200)

  } catch(e) {
    console.error("Export error:", e)
    exportStatus.value[format] = 'idle'
  }
}

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

const fetchData = async () => {
  loading.value = true
  try {
    const [dashRes, coursesRes, usersRes, catRes, evalRes] = await Promise.all([
      api.get('/reportes/dashboard'),
      api.get('/reportes/inscripciones-por-curso'),
      api.get('/reportes/usuarios-por-mes'),
      api.get('/reportes/cursos-por-categoria'),
      api.get('/reportes/evaluaciones-resultados')
    ])
    stats.value = dashRes.data
    topCourses.value = coursesRes.data
    usersByMonth.value = usersRes.data
    coursesByCategory.value = catRes.data
    evaluationResults.value = evalRes.data
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
  return {
    labels: stats.value.trend.map(t => t.month),
    datasets: [{
      label: 'Inscripciones',
      data: stats.value.trend.map(t => t.count),
      backgroundColor: (ctx) => {
        const g = ctx.chart.ctx.createLinearGradient(0, 0, 0, 280)
        g.addColorStop(0, 'rgba(34, 211, 238, 1)')
        g.addColorStop(1, 'rgba(34, 211, 238, 0.6)')
        return g
      },
      borderColor: '#22d3ee',
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

const barChartOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: { display: false },
    tooltip: {
      backgroundColor: 'rgba(15,23,42,0.95)',
      titleColor: '#22d3ee',
      bodyColor: '#e2e8f0',
      borderColor: 'rgba(34,211,238,0.3)',
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
      ticks: { color: 'rgba(255,255,255,0.35)', font: { size: 11, weight: 'bold' } }
    },
    y: {
      grid: { color: 'rgba(255,255,255,0.04)', drawBorder: false },
      ticks: { color: 'rgba(255,255,255,0.35)', font: { size: 11 }, stepSize: 1 },
      beginAtZero: true
    }
  }
}

const barChartExpandedOptions = {
  responsive: true,
  maintainAspectRatio: false,
  plugins: {
    legend: { 
      display: true, 
      position: 'top',
      labels: { color: 'rgba(255,255,255,0.8)', font: { size: 14, weight: 'bold' }, padding: 20 }
    },
    tooltip: {
      backgroundColor: 'rgba(15,23,42,0.95)',
      titleColor: '#22d3ee',
      bodyColor: '#e2e8f0',
      borderColor: 'rgba(34,211,238,0.3)',
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
      ticks: { color: 'rgba(255,255,255,0.8)', font: { size: 13, weight: 'bold' } }
    },
    y: {
      grid: { color: 'rgba(255,255,255,0.1)', drawBorder: false },
      ticks: { color: 'rgba(255,255,255,0.8)', font: { size: 13 }, stepSize: 1 },
      beginAtZero: true
    }
  }
}

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

const doughnutOptions = {
  responsive: true,
  maintainAspectRatio: false,
  cutout: '65%',
  plugins: {
    legend: {
      position: 'bottom',
      labels: { color: 'rgba(255,255,255,0.5)', font: { size: 10, weight: 'bold' }, padding: 14, usePointStyle: true, pointStyleWidth: 8 }
    },
    tooltip: {
      backgroundColor: 'rgba(15,23,42,0.95)',
      titleColor: '#a78bfa',
      bodyColor: '#e2e8f0',
      borderColor: 'rgba(167,139,250,0.3)',
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
}

const doughnutExpandedOptions = {
  responsive: true,
  maintainAspectRatio: false,
  cutout: '50%',
  plugins: {
    legend: {
      position: 'right',
      labels: { color: 'rgba(255,255,255,0.8)', font: { size: 14, weight: 'bold' }, padding: 24, usePointStyle: true, pointStyleWidth: 12 }
    },
    tooltip: barChartExpandedOptions.plugins.tooltip
  }
}

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

const lineOptions = {
  responsive: true, maintainAspectRatio: false,
  plugins: { legend: { display: false }, tooltip: barChartOptions.plugins.tooltip },
  scales: {
    x: { grid: { display: false }, ticks: { color: 'rgba(255,255,255,0.3)', font: { size: 10 } } },
    y: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: 'rgba(255,255,255,0.3)', font: { size: 10 }, stepSize: 1 }, beginAtZero: true }
  }
}

const lineExpandedOptions = {
  responsive: true, maintainAspectRatio: false,
  plugins: { 
    legend: { display: true, position: 'top', labels: { color: 'rgba(255,255,255,0.8)', font: { size: 14, weight: 'bold' } } }, 
    tooltip: barChartExpandedOptions.plugins.tooltip 
  },
  scales: {
    x: { grid: { display: false }, ticks: { color: 'rgba(255,255,255,0.8)', font: { size: 13, weight: 'bold' } } },
    y: { grid: { color: 'rgba(255,255,255,0.1)' }, ticks: { color: 'rgba(255,255,255,0.8)', font: { size: 13 }, stepSize: 1 }, beginAtZero: true }
  }
}

// Category Horizontal Bar Chart
const categoryChartData = computed(() => {
  if (!coursesByCategory.value.length) return null
  return {
    labels: coursesByCategory.value.map(c => c.nombre.length > 12 ? c.nombre.slice(0, 12) + '…' : c.nombre),
    datasets: [{
      label: 'Cursos',
      fullLabels: coursesByCategory.value.map(c => c.nombre),
      data: coursesByCategory.value.map(c => c.count ?? c._count?.cursos ?? 0),
      backgroundColor: '#fbbf24',
      borderRadius: 4,
      barPercentage: 0.6
    }]
  }
})

const categoryChartDataExpanded = computed(() => {
  if (!coursesByCategory.value.length) return null
  return {
    labels: coursesByCategory.value.map(c => c.nombre), // Texto completo
    datasets: [{
      label: 'Cursos',
      fullLabels: coursesByCategory.value.map(c => c.nombre),
      data: coursesByCategory.value.map(c => c.count ?? c._count?.cursos ?? 0),
      backgroundColor: '#fbbf24',
      borderRadius: 6,
      barPercentage: 0.7
    }]
  }
})

const horizontalBarOptions = {
  indexAxis: 'y',
  responsive: true, maintainAspectRatio: false,
  plugins: { legend: { display: false }, tooltip: barChartOptions.plugins.tooltip },
  scales: {
    x: { grid: { color: 'rgba(255,255,255,0.05)' }, ticks: { color: 'rgba(255,255,255,0.3)', font: { size: 10 }, stepSize: 1 }, beginAtZero: true },
    y: { grid: { display: false }, ticks: { color: 'rgba(255,255,255,0.5)', font: { size: 10 } } }
  }
}

const horizontalBarExpandedOptions = {
  indexAxis: 'y',
  responsive: true, maintainAspectRatio: false,
  plugins: { 
    legend: { display: true, position: 'top', labels: { color: 'rgba(255,255,255,0.8)', font: { size: 14, weight: 'bold' } } }, 
    tooltip: barChartExpandedOptions.plugins.tooltip 
  },
  scales: {
    x: { grid: { color: 'rgba(255,255,255,0.1)' }, ticks: { color: 'rgba(255,255,255,0.8)', font: { size: 13 }, stepSize: 1 }, beginAtZero: true },
    y: { grid: { display: false }, ticks: { color: 'rgba(255,255,255,0.8)', font: { size: 14, weight: 'bold' } } }
  }
}

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

const evalDoughnutOptions = {
  responsive: true, maintainAspectRatio: false, cutout: '70%',
  plugins: {
    legend: { position: 'bottom', labels: { color: 'rgba(255,255,255,0.5)', font: { size: 10 }, usePointStyle: true, padding: 10 } },
    tooltip: barChartOptions.plugins.tooltip
  }
}

const evalDoughnutExpandedOptions = {
  responsive: true, maintainAspectRatio: false, cutout: '60%',
  plugins: {
    legend: { position: 'right', labels: { color: 'rgba(255,255,255,0.8)', font: { size: 14, weight: 'bold' }, usePointStyle: true, padding: 24 } },
    tooltip: barChartExpandedOptions.plugins.tooltip
  }
}

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
