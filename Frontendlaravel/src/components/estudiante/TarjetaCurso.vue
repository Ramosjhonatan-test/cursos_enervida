<template>
  <div class="course-card-premium group relative flex flex-col overflow-hidden rounded-[32px] bg-surface-card/30 backdrop-blur-xl transition-all duration-700 hover:-translate-y-4 hover:shadow-[0_40px_80px_-20px_rgba(6,182,212,0.3)] !border-none">
    <!-- Super Glass Glow (Dynamic effect on hover) -->
    <div class="absolute inset-0 pointer-events-none transition-opacity duration-700 opacity-0 group-hover:opacity-100">
      <div class="absolute -left-20 -top-20 h-64 w-64 rounded-full bg-accent-neon/15 blur-[100px] animate-pulse"></div>
      <div class="absolute -right-20 -bottom-20 h-64 w-64 rounded-full bg-accent-solar/10 blur-[100px]"></div>
    </div>
    
    <!-- Miniatura con Overlay Super Premium -->
    <div class="relative aspect-[16/10] overflow-hidden">
      <img 
        :src="getFileUrl(course?.miniatura_url)" 
        :alt="course?.titulo"
        class="h-full w-full object-cover transition-transform duration-1000 group-hover:scale-110" 
      />
      
      <!-- Gradient Overlays -->
      <div class="absolute inset-0 bg-gradient-to-t from-surface-card via-transparent to-transparent opacity-90"></div>
      <div class="absolute inset-0 bg-gradient-to-tr from-accent-neon/10 via-transparent to-accent-solar/10 opacity-0 transition-opacity duration-500 group-hover:opacity-100"></div>
      
      <!-- Premium Badge -->
      <div class="absolute top-4 right-4 z-10 opacity-0 translate-y-2 transition-all duration-500 group-hover:opacity-100 group-hover:translate-y-0">
        <div class="flex items-center gap-1.5 rounded-xl bg-white/10 backdrop-blur-2xl px-3 py-1.5 shadow-xl !border-none">
          <span class="material-symbols-outlined text-accent-neon text-sm">workspace_premium</span>
          <span class="text-[8px] font-black uppercase tracking-[0.2em] text-white">Certificado</span>
        </div>
      </div>

      <!-- Nivel Tag -->
      <div class="absolute bottom-4 left-4 z-10">
        <div class="flex items-center gap-2 rounded-full bg-surface-card/60 backdrop-blur-2xl px-4 py-1.5 shadow-2xl !border-none">
          <span class="relative flex h-1.5 w-1.5">
            <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
            <span class="relative inline-flex rounded-full h-1.5 w-1.5 bg-accent-neon"></span>
          </span>
          <span class="text-[9px] font-black uppercase tracking-widest text-white/90">
            {{ course?.nivel || 'Fundamental' }}
          </span>
        </div>
      </div>

      <!-- Play Icon Overlay -->
      <div class="absolute inset-0 z-20 flex items-center justify-center opacity-0 transition-all duration-500 group-hover:opacity-100 scale-75 group-hover:scale-100">
        <div class="h-20 w-20 rounded-full bg-accent-neon/30 backdrop-blur-xl flex items-center justify-center shadow-[0_0_50px_rgba(6,182,212,0.4)] !border-none">
          <span class="material-symbols-outlined text-white text-5xl">play_circle</span>
        </div>
      </div>
    </div>

    <!-- Contenido con jerarquía mejorada -->
    <div class="relative z-10 flex flex-1 flex-col p-6 lg:p-9">
      <!-- Categoría y Rating -->
      <div class="mb-5 flex items-center justify-between">
        <span class="inline-flex items-center rounded-xl bg-accent-neon/10 px-3 py-1.5 text-[8px] font-black uppercase tracking-[0.25em] text-accent-neon shadow-sm !border-none">
          {{ course?.categoria?.nombre || 'Especialidad' }}
        </span>
        <div class="flex items-center gap-1 text-accent-solar">
          <span class="material-symbols-outlined text-xs">star</span>
          <span class="text-[10px] font-black">4.9</span>
        </div>
      </div>

      <!-- Título Impactante -->
      <h3 class="font-lexend text-xl lg:text-2xl font-black leading-tight tracking-tight text-on-surface line-clamp-2 min-h-[3.5rem] transition-all duration-500 group-hover:text-accent-neon group-hover:translate-x-1">
        {{ course?.titulo }}
      </h3>

      <!-- Descripción Elegante -->
      <p class="mt-4 line-clamp-2 text-xs leading-relaxed text-on-surface/40 font-medium">
        {{ course?.descripcion_corta || 'Formación técnica avanzada diseñada para liderar la transición energética global.' }}
      </p>

      <!-- Stats Grid Premium -->
      <div class="mt-8 grid grid-cols-2 gap-4 pt-6 !border-none">
        <div class="flex items-center gap-3">
          <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-white/5 transition-colors !border-none">
            <span class="material-symbols-outlined text-accent-neon text-lg">auto_stories</span>
          </div>
          <div class="flex flex-col">
            <span class="text-xs font-black text-on-surface leading-none">{{ course?.modulos?.length || course?.clases_count || '--' }}</span>
            <span class="text-[8px] font-bold uppercase tracking-widest text-on-surface/20">Módulos</span>
          </div>
        </div>
        <div class="flex items-center gap-3">
          <div class="flex h-9 w-9 items-center justify-center rounded-xl bg-white/5 transition-colors !border-none">
            <span class="material-symbols-outlined text-accent-solar text-lg">schedule</span>
          </div>
          <div class="flex flex-col">
            <span class="text-xs font-black text-on-surface leading-none">{{ course?.duracion || '--' }}</span>
            <span class="text-[8px] font-bold uppercase tracking-widest text-on-surface/20">Duración</span>
          </div>
        </div>
      </div>

      <!-- Progreso (si aplica) -->
      <div v-if="inscription" class="mt-8 space-y-4">
        <div class="flex justify-between items-end">
          <span class="text-[10px] font-black uppercase tracking-[0.2em] text-on-surface/30">Progreso actual</span>
          <span class="text-lg font-lexend font-black text-accent-neon">{{ Math.round(inscription.porcentaje_progreso || 0) }}%</span>
        </div>
        <div class="glass-progress-bar h-2.5">
          <div 
            class="glass-progress-fill relative" 
            :style="{ width: `${inscription.porcentaje_progreso || 0}%` }"
          >
            <div class="absolute inset-0 bg-white/20 animate-pulse"></div>
          </div>
        </div>
      </div>

      <!-- Acciones de Alto Impacto -->
      <div class="mt-auto pt-8 flex flex-col gap-6">
        <div v-if="!inscription && type === 'catalog'" class="flex items-center justify-between px-2">
          <div class="flex flex-col">
            <p class="text-[9px] font-black uppercase tracking-[0.2em] text-on-surface/30">Inversión</p>
            <div class="flex items-baseline gap-1.5">
              <span class="text-3xl font-black text-on-surface tracking-tighter">{{ course?.precio || '0' }}</span>
              <span class="text-[11px] font-black text-accent-neon uppercase">BS</span>
            </div>
          </div>
          
          <div class="flex flex-col items-end">
            <div class="flex -space-x-3">
              <div v-for="i in 3" :key="i" class="h-8 w-8 rounded-full border-2 border-surface-card bg-surface-card overflow-hidden">
                <img :src="`https://i.pravatar.cc/100?img=${i+10}`" class="h-full w-full object-cover" />
              </div>
              <div class="h-8 w-8 rounded-full border-2 border-surface-card bg-accent-neon/20 flex items-center justify-center text-[10px] font-black text-accent-neon">
                +80
              </div>
            </div>
            <span class="mt-1 text-[8px] font-bold text-on-surface/30 uppercase tracking-widest">Alumnos inscritos</span>
          </div>
        </div>
        
        <div class="flex items-center gap-3">
          <!-- Botón Ver Detalles (Now more prominent) -->
          <button 
            @click.stop="$emit('view-details', course)"
            class="group/btn relative flex-1 h-14 overflow-hidden rounded-2xl bg-white/5 transition-all hover:bg-white/10 hover:shadow-[0_0_15px_rgba(6,182,212,0.3)] !border-none"
          >
            <div class="absolute inset-0 bg-gradient-to-r from-accent-neon/0 via-accent-neon/10 to-accent-neon/0 -translate-x-full group-hover/btn:animate-shimmer"></div>
            <span class="relative z-10 flex items-center justify-center gap-2 text-[10px] font-black uppercase tracking-[0.2em] text-white group-hover/btn:text-accent-neon transition-colors">
              <span class="material-symbols-outlined text-xl">visibility</span>
              VER MÁS
            </span>
          </button>

          <!-- Botón Principal dinámico -->
          <button 
            v-if="!inscription && type === 'catalog'"
            @click.stop="$emit('action', course)"
            class="flex-[1.5] btn-premium btn-primary-neon !h-14 !rounded-2xl !px-6 !text-[11px] !tracking-[0.2em] shadow-neon-sm overflow-hidden relative group/action"
          >
            <span class="relative z-10 flex items-center justify-center gap-3">
              SOLICITAR ACCESO
              <span class="material-symbols-outlined text-lg transition-transform group-hover/action:translate-x-2">arrow_right_alt</span>
            </span>
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent -translate-x-full group-hover/action:animate-shimmer"></div>
          </button>

          <router-link
            v-else-if="inscription && inscription.estado === 'ACTIVO'"
            :to="'/student/course/' + course.id"
            class="flex-[1.5] btn-premium btn-primary-neon !h-14 !rounded-2xl !px-6 !text-[11px] !tracking-[0.2em] shadow-neon-sm text-center flex items-center justify-center overflow-hidden relative group/action"
          >
             <span class="relative z-10 flex items-center justify-center gap-3">
              CONTINUAR
              <span class="material-symbols-outlined text-lg transition-transform group-hover/action:translate-x-2">bolt</span>
            </span>
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-white/30 to-transparent -translate-x-full group-hover/action:animate-shimmer"></div>
          </router-link>

          <div 
            v-else-if="inscription && inscription.estado === 'PENDIENTE'"
            class="flex-[1.5] h-14 rounded-2xl bg-accent-solar/5 px-6 text-[10px] font-black uppercase tracking-[0.25em] text-accent-solar text-center flex items-center justify-center gap-3 !border-none"
          >
            <span class="material-symbols-outlined text-lg animate-spin">history</span>
            EN ESPERA
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { getFileUrl } from '@/config'

defineProps({
  course: {
    type: Object,
    required: true
  },
  inscription: {
    type: Object,
    default: null
  },
  type: {
    type: String,
    default: 'catalog' // 'catalog', 'my-courses'
  }
})

defineEmits(['action', 'view-details'])
</script>

<style scoped>
.course-card-premium {
  box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.5);
  position: relative;
}

.course-card-premium::before {
  content: '';
  position: absolute;
  inset: 0;
  border-radius: 32px;
  padding: 2px; /* Border thickness */
  background: linear-gradient(135deg, rgba(255,255,255,0.1), transparent, rgba(6,182,212,0.1));
  -webkit-mask: 
     linear-gradient(#fff 0 0) content-box, 
     linear-gradient(#fff 0 0);
  -webkit-mask-composite: xor;
          mask-composite: exclude;
  pointer-events: none;
  transition: all 0.7s ease;
}

.course-card-premium:hover::before {
  background: linear-gradient(135deg, var(--accent-neon), transparent, var(--accent-solar));
  opacity: 0.6;
}

@keyframes shimmer {
  0% { transform: translateX(-100%); }
  100% { transform: translateX(100%); }
}

.animate-shimmer {
  animation: shimmer 2s infinite;
}

.shadow-neon-sm {
  box-shadow: 0 0 25px -5px var(--accent-neon), inset 0 0 10px rgba(255,255,255,0.1);
}

.glass-progress-bar {
  @apply w-full overflow-hidden rounded-full bg-white/5 shadow-inner !border-none;
}

.glass-progress-fill {
  @apply h-full bg-gradient-to-r from-accent-neon via-accent-neon to-accent-solar transition-all duration-1000 ease-out;
  box-shadow: 0 0 15px rgba(6,182,212,0.4);
}
</style>

