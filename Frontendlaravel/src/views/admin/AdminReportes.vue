<template>
  <div class="space-y-10 animate-fade-in text-on-surface">
    
    <!-- Header -->
    <div class="panel-hero p-6 sm:p-8">
      <div class="flex flex-col md:flex-row md:items-center justify-between gap-6">
        <div>
          <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">Reportes e <span class="text-accent-neon italic">Indicadores</span></h2>
          <p class="text-on-surface/40 mt-1 text-xs font-bold uppercase tracking-widest">Análisis de rendimiento y crecimiento de la plataforma</p>
        </div>
        <div class="flex gap-4">
          <button @click="fetchData" class="btn-premium btn-secondary-glass !py-4 gap-2">
            <span class="material-symbols-outlined text-sm">refresh</span>
            Actualizar Datos
          </button>
        </div>
      </div>
    </div>

    <!-- Main Stats Grid -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
      <div v-for="stat in mainStats" :key="stat.label" class="glass-card-premium p-8 rounded-[32px] group transition-all relative overflow-hidden">
        <div class="relative z-10">
          <div class="flex items-center gap-4 mb-4">
            <div class="w-12 h-12 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon group-hover:scale-110 transition-transform">
              <span class="material-symbols-outlined">{{ stat.icon }}</span>
            </div>
            <span class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">{{ stat.label }}</span>
          </div>
          <p class="text-4xl font-black text-on-surface">{{ stat.prefix }}{{ stat.value }}{{ stat.suffix }}</p>
        </div>
        <div class="absolute -right-4 -bottom-4 opacity-[0.05] group-hover:opacity-[0.1] transition-opacity">
           <span class="material-symbols-outlined text-8xl">{{ stat.icon }}</span>
        </div>
      </div>
    </div>
    

    <!-- Charts Row -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
      <div class="glass-card-premium p-10 rounded-[40px]">
         <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
        <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando reportes...</p>
      </div>
        <h3 class="text-xl font-black mb-10 font-lexend tracking-tighter italic">Top 5 Cursos <span class="text-accent-neon">Más Populares</span></h3>
        <div class="space-y-8">
          <div v-for="item in enrollmentsByCourse" :key="item.titulo" class="space-y-3">
            <div class="flex justify-between items-end">
              <span class="text-xs font-black text-on-surface uppercase tracking-tight truncate max-w-[70%]">{{ item.titulo }}</span>
              <span class="text-xs font-black text-accent-neon">{{ item.inscripciones ?? item._count?.inscripciones ?? 0 }} Alumnos</span>
            </div>
            <div class="h-2 bg-on-surface/5 rounded-full overflow-hidden p-0.5">
              <div 
                class="h-full bg-accent-neon rounded-full shadow-[0_0_15px_var(--accent-neon)] transition-all duration-1000" 
                :style="{ width: ((item.inscripciones ?? item._count?.inscripciones ?? 0) / maxEnrollments * 100) + '%' }"
              ></div>
            </div>
          </div>
          <div v-if="enrollmentsByCourse.length === 0" class="py-10 text-center text-on-surface/20">
             <span class="material-symbols-outlined text-4xl mb-2">bar_chart_off</span>
             <p class="text-[10px] font-black uppercase tracking-widest">Sin datos suficientes</p>
          </div>
        </div>
        
  
      </div>

      <!-- Growth Summary / Placeholder Chart -->
      <div class="glass-card-premium p-10 rounded-[40px] flex flex-col justify-center items-center text-center">
        <div class="w-20 h-20 rounded-full bg-accent-neon/10 flex items-center justify-center text-accent-neon mb-6">
          <span class="material-symbols-outlined text-4xl">trending_up</span>
        </div>
        <h3 class="text-2xl font-black mb-4 font-lexend tracking-tighter">Análisis de <span class="text-accent-neon italic">Crecimiento</span></h3>
        <p class="text-sm text-on-surface/60 max-w-sm mb-8 font-light">
          El sistema está recopilando datos suficientes para generar proyecciones mensuales automáticas.
        </p>
        <div class="grid grid-cols-2 gap-4 w-full">
           <div class="bg-on-surface/[0.03] p-6 rounded-3xl">
              <p class="text-[9px] font-black text-on-surface/40 uppercase tracking-widest mb-1">Tasa de Conversión</p>
              <p class="text-2xl font-black text-on-surface">12.4%</p>
           </div>
           <div class="bg-on-surface/[0.03] p-6 rounded-3xl">
              <p class="text-[9px] font-black text-on-surface/40 uppercase tracking-widest mb-1">Retención Mensual</p>
              <p class="text-2xl font-black text-on-surface">94.2%</p>
           </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from '@/services/api'

const loading = ref(true)
const dashboardStats = ref({})
const enrollmentsByCourse = ref([])

const mainStats = computed(() => [
  { label: 'Cursos', value: dashboardStats.value.totalCursos || 0, icon: 'auto_stories' },
  { label: 'Estudiantes', value: dashboardStats.value.totalEstudiantes || 0, icon: 'group' },
  { label: 'Inscripciones', value: dashboardStats.value.totalInscripciones || 0, icon: 'confirmation_number' },
  { label: 'Ingresos Totales', value: Number(dashboardStats.value.totalVentas || 0).toFixed(2), prefix: '', suffix: ' Bs', icon: 'payments' },
])

const maxEnrollments = computed(() => {
  if (enrollmentsByCourse.value.length === 0) return 1
  return Math.max(...enrollmentsByCourse.value.map(i => i.inscripciones ?? i._count?.inscripciones ?? 0), 1)
})

const fetchData = async () => {
  loading.value = true
  try {
    const [statsRes, enrollRes] = await Promise.all([
      api.get('/reportes/dashboard'),
      api.get('/reportes/inscripciones-por-curso')
    ])
    dashboardStats.value = statsRes.data
    enrollmentsByCourse.value = enrollRes.data
  } catch (error) {
    console.error('Error fetching report data:', error)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchData()
})
</script>
