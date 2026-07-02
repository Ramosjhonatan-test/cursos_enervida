<template>
  <div class="relative min-h-screen">
    <!-- Orbes decorativos de fondo -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[500px] w-[500px] rounded-full bg-accent-neon/5 blur-[120px]"></div>
      <div class="absolute -right-[5%] top-[20%] h-[400px] w-[400px] rounded-full bg-accent-solar/5 blur-[100px]"></div>
    </div>

    <div class="relative z-10 space-y-12">
      <EstudiantePageHeader
        eyebrow="Panel de estudio"
        title="Mis"
        highlight="Cursos"
        description="Retoma lo pendiente, revisa el avance y entra al curso correcto sin perder tiempo."
      />

      <div v-if="loading" class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        <div v-for="i in 3" :key="i" class="h-96 course-card-premium loading-pulse"></div>
      </div>

      <div v-else-if="inscripciones.length === 0" class="student-empty flex flex-col items-center justify-center p-8 sm:p-16 text-center">
        <div class="mb-6 flex h-24 w-24 items-center justify-center rounded-full bg-accent-neon/10 text-accent-neon">
          <span class="material-symbols-outlined text-5xl">school</span>
        </div>
        <h2 class="font-lexend text-3xl font-black">Sin cursos activos</h2>
        <p class="mt-4 max-w-md text-on-surface/50">
          Explora el catálogo y suma una nueva ruta. Cuando tengas inscripciones activas, esta pantalla quedará mucho más útil para seguir tu progreso.
        </p>
        <router-link to="/student/catalog" class="btn-premium btn-primary-neon mt-10 !px-12">Ir al catálogo</router-link>
      </div>

      <div v-else class="grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-3">
        <article
          v-for="ins in inscripciones"
          :key="ins.id"
          class="course-card-premium group"
        >
          <div class="relative aspect-video overflow-hidden">
            <img :src="getFileUrl(ins.curso?.miniatura_url)" class="h-full w-full object-cover transition-transform duration-1000 group-hover:scale-110" />
            <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent"></div>
            <div class="absolute bottom-4 left-4 sm:bottom-6 sm:left-6 flex flex-wrap gap-2">
              <span
                :class="[
                  'rounded-full px-3 py-1 sm:px-4 sm:py-1.5 text-[8px] sm:text-[9px] font-black uppercase tracking-widest shadow-xl',
                  ins.estado === 'COMPLETADO' ? 'bg-emerald-500 text-white' :
                  ins.estado === 'ACTIVO' ? 'bg-accent-neon text-primary' :
                  'bg-accent-solar text-primary'
                ]"
              >
                {{ ins.estado === 'COMPLETADO' ? '✓ Completado' : ins.estado }}
              </span>
              <span class="rounded-full !border-none bg-on-surface/5 backdrop-blur-md px-3 py-1 sm:px-4 sm:py-1.5 text-[8px] sm:text-[9px] font-black uppercase tracking-widest text-on-surface/80">
                {{ ins.curso?.nivel || 'Ruta guiada' }}
              </span>
            </div>
          </div>

          <div class="flex flex-1 flex-col p-5 sm:p-6 md:p-8">
            <div class="flex items-start justify-between gap-4">
              <h3 class="font-lexend text-lg sm:text-xl md:text-2xl font-black leading-tight text-on-surface group-hover:text-accent-neon transition-colors">
                {{ ins.curso?.titulo }}
              </h3>
              <span :class="[
                'rounded-full !border-none px-2 py-1 sm:px-3 sm:py-1 text-[8px] sm:text-[9px] font-black uppercase tracking-[0.2em] whitespace-nowrap shrink-0',
                ins.estado === 'COMPLETADO' ? 'bg-emerald-500/10 text-emerald-400' : 'bg-accent-neon/10 text-accent-neon'
              ]">
                {{ ins.estado === 'COMPLETADO' ? '100%' : Math.round(ins.porcentaje_progreso || 0) + '%' }}
              </span>
            </div>

            <div class="mt-6 sm:mt-8 flex flex-col gap-3">
              <div class="flex justify-between text-[9px] sm:text-[10px] font-black uppercase tracking-widest text-on-surface/30">
                <span>Progreso actual</span>
                <span :class="ins.estado === 'COMPLETADO' ? 'text-emerald-400' : 'text-accent-neon'">
                  {{ ins.estado === 'COMPLETADO' ? 'Finalizado' : Math.round(ins.porcentaje_progreso || 0) + '%' }}
                </span>
              </div>
              <div class="glass-progress-bar">
                <div
                  :class="[
                    'glass-progress-fill transition-all duration-1000',
                    ins.estado === 'COMPLETADO' ? '!bg-emerald-500 shadow-[0_0_15px_rgba(16,185,129,0.5)]' : ''
                  ]"
                  :style="{ width: ins.estado === 'COMPLETADO' ? '100%' : `${ins.porcentaje_progreso || 0}%` }"
                ></div>
              </div>
            </div>

            <p class="mt-4 sm:mt-6 text-xs sm:text-sm leading-relaxed text-on-surface/50">
              {{ ins.estado === 'COMPLETADO' ? 'Has finalizado este curso exitosamente. Tu certificado ya está disponible para descarga.' :
                 ins.estado === 'ACTIVO' ? 'Listo para continuar donde lo dejaste desde cualquier dispositivo.' :
                 'Tu solicitud sigue en revisión y quedará habilitada cuando sea aprobada por administración.' }}
            </p>

            <div class="mt-6 sm:mt-auto pt-6">
              <!-- COMPLETADO: mostrar estado y link a certificados -->
              <div v-if="ins.estado === 'COMPLETADO'" class="flex flex-col gap-4">
                <router-link to="/student/certificates" class="btn-premium btn-secondary-glass !w-full !py-3 sm:!py-4 !text-[10px] sm:!text-[11px] gap-2">
                  <span class="material-symbols-outlined text-base sm:text-lg">workspace_premium</span>
                  Ver certificado
                </router-link>
              </div>

              <!-- ACTIVO: continuar curso -->
              <router-link
                v-else-if="ins.estado === 'ACTIVO'"
                :to="'/student/course/' + ins.curso_id"
                class="btn-premium btn-primary-neon !w-full !py-3 sm:!py-4 !text-[10px] sm:!text-[11px] flex justify-center items-center gap-2"
              >
                {{ (ins.porcentaje_progreso || 0) > 0 ? 'Continuar curso' : 'Empezar curso' }}
                <span class="material-symbols-outlined text-base sm:text-lg">play_arrow</span>
              </router-link>

              <!-- PENDIENTE: esperando aprobación -->
              <div v-else class="rounded-2xl !border-none bg-on-surface/5 p-4 sm:p-6 text-center">
                <span class="text-[9px] sm:text-[10px] font-black uppercase tracking-widest text-on-surface/30">Esperando aprobación</span>
              </div>
            </div>
          </div>
        </article>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import EstudiantePageHeader from '@/components/estudiante/EstudiantePageHeader.vue'
import { getFileUrl } from '@/config'

const props = defineProps({
  inscripciones: {
    type: Array,
    default: () => [],
  },
  loading: {
    type: Boolean,
    default: false,
  },
})

const headerStats = computed(() => {
  const active = props.inscripciones.filter((item) => item.estado === 'ACTIVO').length
  const avg = props.inscripciones.length
    ? Math.round(props.inscripciones.reduce((acc, item) => acc + Number(item.porcentaje_progreso || 0), 0) / props.inscripciones.length)
    : 0

  return [
    {
      label: 'Activos',
      value: props.loading ? '...' : active,
      help: 'Cursos listos para retomar',
      icon: 'play_circle',
    },
    {
      label: 'Avance medio',
      value: `${avg}%`,
      help: 'Promedio general del campus',
      icon: 'trending_up',
    },
  ]
})

</script>
