<template>
  <Transition name="fade">
    <div v-if="isOpen" class="fixed inset-0 z-[200] flex items-center justify-center p-4 md:p-8">
      <div class="absolute inset-0 bg-slate-950/35 backdrop-blur-xl transition-opacity duration-700 dark:bg-[#030712]/90" @click="close"></div>

      <Transition name="fade-slide" appear>
        <div
          v-show="isOpen"
          :class="isDark ? 'modal-theme-dark' : 'modal-theme-light'"
          class="relative w-full max-w-6xl h-auto max-h-[85vh] md:max-h-[92vh] overflow-y-auto md:overflow-hidden rounded-[32px] md:rounded-[48px] border border-black/5 dark:border-white/10 bg-white/[0.98] backdrop-blur-2xl shadow-[0_28px_90px_-26px_rgba(15,23,42,0.36)] dark:bg-[#0f172a] dark:shadow-2xl flex flex-col md:flex-row custom-scrollbar transition-colors duration-500"
        >
          <div class="pointer-events-none absolute -left-20 -top-20 h-64 w-64 rounded-full bg-accent-neon/12 blur-[100px]"></div>
          <div class="pointer-events-none absolute -right-20 -bottom-20 h-64 w-64 rounded-full bg-accent-solar/8 blur-[100px]"></div>

          <button
            @click="close"
            class="absolute top-4 right-4 md:top-6 md:right-6 z-50 h-10 w-10 md:h-12 md:w-12 rounded-2xl bg-white/70 text-slate-600 hover:bg-accent-neon hover:text-primary transition-all duration-300 backdrop-blur-md border border-black/5 dark:bg-white/5 dark:text-on-surface/60 dark:border-white/5 flex items-center justify-center group"
          >
            <span class="material-symbols-outlined transition-transform group-hover:rotate-90">close</span>
          </button>

          <div class="w-full md:w-[42%] lg:w-[40%] flex flex-col shrink-0 relative overflow-hidden transition-colors duration-500">
            <div class="relative w-full aspect-[4/3] sm:aspect-[16/10] md:aspect-[4/3] overflow-hidden">
              <img :src="getFileUrl(course?.miniatura_url)" class="absolute inset-0 h-full w-full object-cover" :alt="course?.titulo" />
              <div class="absolute inset-0 bg-gradient-to-br from-accent-neon/20 via-transparent to-accent-solar/15 mix-blend-overlay"></div>
              <div class="absolute inset-0 bg-gradient-to-t from-black/85 via-black/30 to-transparent"></div>
              <div class="absolute -top-16 -left-16 h-56 w-56 rounded-full bg-accent-neon/30 blur-3xl pointer-events-none"></div>
              <div class="absolute top-1/3 -right-20 h-48 w-48 rounded-full bg-accent-solar/20 blur-3xl pointer-events-none"></div>

              <div class="absolute top-4 sm:top-5 md:top-6 left-4 sm:left-5 md:left-6 right-4 sm:right-5 md:right-6 flex items-start justify-between gap-3 z-10">
                <div class="flex flex-wrap gap-2 max-w-[70%]">
                  <span class="inline-flex items-center rounded-full bg-accent-neon px-3 py-1.5 text-[9px] font-black uppercase tracking-widest text-primary shadow-md shadow-accent-neon/30">
                    <span class="h-1.5 w-1.5 rounded-full bg-primary mr-1.5 animate-pulse"></span>
                    {{ course?.categoria?.nombre || 'Especialidad' }}
                  </span>
                  <span v-if="course?.nivel" class="inline-flex items-center rounded-full bg-on-surface/15 backdrop-blur-md px-3 py-1.5 text-[9px] font-black uppercase tracking-widest text-white">
                    {{ course.nivel }}
                  </span>
                </div>

                <button class="shrink-0 h-10 w-10 sm:h-12 sm:w-12 md:h-14 md:w-14 rounded-full bg-on-surface/15 backdrop-blur-md flex items-center justify-center hover:bg-accent-neon hover:scale-110 transition-all duration-300 group/play shadow-lg">
                  <span class="material-symbols-outlined text-white text-xl sm:text-2xl md:text-3xl ml-0.5 group-hover/play:text-primary transition-colors">play_arrow</span>
                </button>
              </div>

              <div class="absolute bottom-16 sm:bottom-20 md:bottom-24 left-4 sm:left-5 md:left-6 z-10 flex items-center gap-2">
                <div class="h-7 w-7 md:h-8 md:w-8 rounded-lg bg-on-surface/15 backdrop-blur-md flex items-center justify-center">
                  <span class="material-symbols-outlined text-white text-sm">school</span>
                </div>
                <span class="text-[9px] font-black uppercase tracking-widest text-white/80">Programa Experto</span>
              </div>

              <div class="absolute bottom-0 left-0 right-0 p-5 sm:p-6 md:p-7 z-10 bg-gradient-to-t from-black/90 via-black/45 to-transparent pt-10 sm:pt-12 md:pt-14">
                <h2 class="font-lexend text-xl sm:text-2xl md:text-3xl lg:text-4xl font-black leading-[1.1] text-white tracking-tight drop-shadow-lg">
                  {{ course?.titulo }}
                </h2>
              </div>
            </div>

            <div class="relative p-5 sm:p-6 md:p-7 bg-white dark:bg-[#0f172a] transition-colors duration-500">
              <div class="space-y-4 sm:space-y-5">
                <div class="flex items-end justify-between gap-3 sm:gap-4">
                  <div>
                    <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/40 dark:text-white/45">Inversión del Curso</span>
                    <div class="flex items-baseline gap-1 mt-1">
                      <span class="text-3xl sm:text-4xl md:text-5xl font-black text-accent-neon tracking-tighter leading-none">{{ course?.precio || '0' }}</span>
                      <span class="text-xs sm:text-sm font-black text-accent-neon uppercase">BS</span>
                    </div>
                  </div>
                  <div class="text-right pb-1">
                    <span class="inline-flex items-center gap-1 text-[9px] font-black uppercase tracking-widest text-accent-solar">
                      <span class="material-symbols-outlined text-sm">workspace_premium</span>
                      Incluye
                    </span>
                    <p class="text-[10px] sm:text-[11px] font-bold text-on-surface/80 dark:text-slate-200 mt-1 leading-tight">Certificado<br>vitalicio</p>
                  </div>
                </div>

                <div class="grid grid-cols-3 gap-2 pt-3 sm:pt-4">
                  <div class="flex flex-col items-center gap-1 py-2 rounded-xl bg-slate-900/[0.04] dark:bg-white/5 dark:border dark:border-white/10">
                    <span class="material-symbols-outlined text-accent-neon text-base sm:text-lg">play_circle</span>
                    <span class="text-[8px] sm:text-[9px] font-black uppercase tracking-widest text-on-surface/60 dark:text-slate-300 text-center leading-tight">Lecciones</span>
                  </div>
                  <div class="flex flex-col items-center gap-1 py-2 rounded-xl bg-slate-900/[0.04] dark:bg-white/5 dark:border dark:border-white/10">
                    <span class="material-symbols-outlined text-accent-solar text-base sm:text-lg">schedule</span>
                    <span class="text-[8px] sm:text-[9px] font-black uppercase tracking-widest text-on-surface/60 dark:text-slate-300 text-center leading-tight">A tu ritmo</span>
                  </div>
                  <div class="flex flex-col items-center gap-1 py-2 rounded-xl bg-slate-900/[0.04] dark:bg-white/5 dark:border dark:border-white/10">
                    <span class="material-symbols-outlined text-accent-neon text-base sm:text-lg">devices</span>
                    <span class="text-[8px] sm:text-[9px] font-black uppercase tracking-widest text-on-surface/60 dark:text-slate-300 text-center leading-tight">Multi-device</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="flex-1 flex flex-col min-w-0 bg-white dark:bg-[#0f172a] relative transition-colors duration-500">
            <div class="flex-1 overflow-y-visible md:overflow-y-auto custom-scrollbar p-6 md:p-10 lg:p-12 space-y-8 transition-colors duration-500">
              <div class="flex items-center gap-4 sm:gap-8 pb-2 shrink-0 overflow-x-auto hide-scrollbar !border-none">
                <button
                  @click="activeTab = 'general'"
                  :class="[
                    'relative pb-4 text-[10px] whitespace-nowrap font-black uppercase tracking-[0.2em] transition-all duration-300',
                    activeTab === 'general' ? 'text-accent-neon' : 'text-slate-500 hover:text-slate-900 dark:text-white/45 dark:hover:text-on-surface/80'
                  ]"
                >
                  General
                  <div v-if="activeTab === 'general'" class="absolute bottom-0 left-0 right-0 h-0.5 bg-accent-neon shadow-[0_0_10px_#059669]"></div>
                </button>
                <button
                  @click="activeTab = 'contenido'"
                  :class="[
                    'relative pb-4 text-[10px] whitespace-nowrap font-black uppercase tracking-[0.2em] transition-all duration-300',
                    activeTab === 'contenido' ? 'text-accent-neon' : 'text-slate-500 hover:text-slate-900 dark:text-white/45 dark:hover:text-on-surface/80'
                  ]"
                >
                  Contenido
                  <div v-if="activeTab === 'contenido'" class="absolute bottom-0 left-0 right-0 h-0.5 bg-accent-neon shadow-[0_0_10px_#059669]"></div>
                </button>
              </div>

              <div class="min-h-0">
                <div v-if="activeTab === 'general'" class="space-y-12 animate-in fade-in slide-in-from-bottom-4 duration-500">
                  <section class="space-y-6">
                    <div class="flex items-center gap-4">
                      <div class="flex h-10 w-10 md:h-12 md:w-12 items-center justify-center rounded-2xl bg-accent-neon/10 border border-black/5 dark:border-white/10">
                        <span class="material-symbols-outlined text-accent-neon">subject</span>
                      </div>
                      <div>
                        <h3 class="font-lexend text-xl md:text-2xl font-black text-on-surface">Descripción <span class="text-accent-neon">General</span></h3>
                        <p class="text-[9px] font-bold uppercase tracking-widest text-on-surface/40 dark:text-white/45">Todo lo que necesitas saber sobre el programa</p>
                      </div>
                    </div>

                    <div class="max-w-none">
                      <div v-if="course?.descripcion_corta" class="text-accent-neon font-medium text-base md:text-lg leading-relaxed mb-4">
                        {{ course?.descripcion_corta }}
                      </div>
                      <p class="text-slate-700 dark:text-slate-200 text-sm md:text-base leading-relaxed whitespace-pre-line font-medium">
                        {{ course?.descripcion || 'Sin descripción detallada disponible.' }}
                      </p>
                    </div>
                  </section>

                  <section class="grid grid-cols-1 sm:grid-cols-3 gap-4 md:gap-6">
                    <div v-if="course?.certificado_habilitado" class="flex flex-col gap-4 rounded-[24px] md:rounded-[32px] bg-slate-50 border border-black/5 p-6 md:p-8 group hover:bg-white dark:bg-white/5 dark:border-white/10 dark:hover:bg-white/10 transition-all duration-500">
                      <div class="h-12 w-12 md:h-14 md:w-14 rounded-2xl bg-accent-neon/10 flex items-center justify-center border border-black/5 dark:border-white/10 group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-accent-neon text-2xl md:text-3xl">verified</span>
                      </div>
                      <div>
                        <h4 class="text-[11px] md:text-xs font-black text-on-surface uppercase tracking-widest">Certificación</h4>
                        <p class="mt-2 text-[10px] leading-relaxed text-on-surface/40 dark:text-white/45">Otorga certificado al finalizar el curso.</p>
                      </div>
                    </div>

                    <div class="flex flex-col gap-4 rounded-[24px] md:rounded-[32px] bg-slate-50 border border-black/5 p-6 md:p-8 group hover:bg-white dark:bg-white/5 dark:border-white/10 dark:hover:bg-white/10 transition-all duration-500">
                      <div class="h-12 w-12 md:h-14 md:w-14 rounded-2xl bg-accent-solar/10 flex items-center justify-center border border-black/5 dark:border-white/10 group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-accent-solar text-2xl md:text-3xl">all_inclusive</span>
                      </div>
                      <div>
                        <h4 class="text-[11px] md:text-xs font-black text-on-surface uppercase tracking-widest">Acceso Vitalicio</h4>
                        <p class="mt-2 text-[10px] leading-relaxed text-on-surface/40 dark:text-white/45">Consulta el material en cualquier momento.</p>
                      </div>
                    </div>

                    <div class="flex flex-col gap-4 rounded-[24px] md:rounded-[32px] bg-slate-50 border border-black/5 p-6 md:p-8 group hover:bg-white dark:bg-white/5 dark:border-white/10 dark:hover:bg-white/10 transition-all duration-500">
                      <div class="h-12 w-12 md:h-14 md:w-14 rounded-2xl bg-accent-neon/10 flex items-center justify-center border border-black/5 dark:border-white/10 group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-accent-neon text-2xl md:text-3xl">devices</span>
                      </div>
                      <div>
                        <h4 class="text-[11px] md:text-xs font-black text-on-surface uppercase tracking-widest">Multiplataforma</h4>
                        <p class="mt-2 text-[10px] leading-relaxed text-on-surface/40 dark:text-white/45">Aprende desde tu PC, Tablet o Smartphone.</p>
                      </div>
                    </div>
                  </section>
                </div>

                <div v-else-if="activeTab === 'contenido'" class="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
                  <div class="space-y-2">
                    <h3 class="font-lexend text-xl md:text-2xl font-black text-on-surface">¿Qué <span class="text-accent-solar">aprenderás</span>?</h3>
                    <p class="text-[9px] font-bold uppercase tracking-widest text-on-surface/40 dark:text-white/45">Estructura del contenido</p>
                  </div>

                  <div class="space-y-4">
                    <template v-if="course?.modulos?.length">
                      <div
                        v-for="(modulo, index) in course.modulos"
                        :key="modulo.id || index"
                        class="rounded-[24px] md:rounded-[28px] bg-slate-50 border border-black/5 dark:bg-white/5 dark:border-white/10 overflow-hidden transition-all"
                      >
                        <div class="flex flex-col sm:flex-row sm:items-center gap-4 p-5 md:p-6">
                          <div class="h-10 w-10 md:h-12 md:w-12 shrink-0 rounded-xl bg-accent-solar/10 flex items-center justify-center text-accent-solar font-black text-base md:text-lg">
                            {{ index + 1 }}
                          </div>
                          <div class="min-w-0 w-full">
                            <h5 class="text-sm md:text-sm font-black text-on-surface uppercase tracking-wider whitespace-normal break-words leading-snug">
                              {{ modulo.titulo }}
                            </h5>
                            <p class="text-[10px] md:text-[11px] font-bold uppercase tracking-widest text-on-surface/35 dark:text-white/35 mt-1">
                              {{ modulo.lecciones?.length || 0 }} lecciones
                            </p>
                          </div>
                        </div>

                        <div class="border-t border-black/5 dark:border-white/10 px-5 md:px-6 py-4 space-y-2">
                          <template v-if="modulo.lecciones?.length">
                            <div
                              v-for="(leccion, leccionIndex) in modulo.lecciones"
                              :key="leccion.id || leccionIndex"
                              class="flex items-start gap-3 rounded-xl bg-white/80 dark:bg-[#0b1220]/60 border border-black/5 dark:border-white/10 px-4 py-3"
                            >
                              <div class="h-7 w-7 shrink-0 rounded-lg bg-accent-neon/10 text-accent-neon flex items-center justify-center text-[10px] font-black">
                                {{ leccionIndex + 1 }}
                              </div>
                              <div class="min-w-0 w-full">
                                <p class="text-sm md:text-[15px] font-bold text-on-surface whitespace-normal break-words leading-snug">
                                  {{ leccion.titulo }}
                                </p>
                              </div>
                            </div>
                          </template>
                          <div v-else class="flex items-center gap-2 rounded-xl bg-white/60 dark:bg-white/5 border border-dashed border-black/5 dark:border-white/10 px-4 py-3">
                            <span class="material-symbols-outlined text-sm text-on-surface/30 dark:text-white/35">info</span>
                            <p class="text-[11px] font-medium text-on-surface/40 dark:text-white/35">Aún no hay lecciones publicadas en este módulo.</p>
                          </div>
                        </div>
                      </div>
                    </template>

                    <div v-else class="flex flex-col items-center justify-center p-12 text-center rounded-[24px] bg-slate-50 border border-black/5 dark:bg-white/5 dark:border-white/10">
                      <span class="material-symbols-outlined text-4xl text-on-surface/20 mb-3">auto_stories</span>
                      <p class="text-sm font-medium text-on-surface/40 dark:text-white/35">Aún no hay módulos publicados para este curso.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="sticky md:relative bottom-0 p-5 sm:p-6 md:p-8 flex justify-center md:justify-end shrink-0 z-20 bg-white/[0.98] backdrop-blur-md shadow-[0_-8px_24px_-6px_rgba(15,23,42,0.12)] dark:bg-[#0f172a] dark:shadow-[0_-8px_24px_-6px_rgba(0,0,0,0.15)] border-t border-black/5 dark:border-white/10 transition-colors duration-500">
              <button
                v-if="courseStatus === 'NONE'"
                @click="$emit('enroll', course)"
                class="btn-premium btn-primary-neon w-full md:w-auto !h-14 md:!h-16 !px-8 md:!px-16 !rounded-2xl shadow-neon transition-transform hover:scale-105 active:scale-95 group/cta"
              >
                <span class="flex items-center justify-center gap-2 md:gap-3 text-[11px] md:text-xs">
                  INSCRIBIRME AHORA
                  <span class="material-symbols-outlined transition-transform group-hover/cta:translate-x-2">arrow_forward</span>
                </span>
              </button>
              <div
                v-else-if="courseStatus === 'COMPLETADO'"
                class="h-14 md:h-16 w-full md:w-auto flex items-center justify-center gap-2 px-8 md:px-12 rounded-2xl !border-none bg-accent-neon/10 text-accent-neon text-[9px] md:text-[10px] font-black uppercase tracking-widest"
              >
                <span class="material-symbols-outlined text-[16px]">workspace_premium</span>
                CURSO COMPLETADO
              </div>
              <div
                v-else
                class="h-14 md:h-16 w-full md:w-auto flex items-center justify-center gap-2 px-8 md:px-12 rounded-2xl !border-none bg-accent-neon/10 text-accent-neon text-[9px] md:text-[10px] font-black uppercase tracking-widest"
              >
                <span class="material-symbols-outlined text-[16px]">check_circle</span>
                YA ESTÁS INSCRITO
              </div>
            </div>
          </div>
        </div>
      </Transition>
    </div>
  </Transition>
</template>

<script setup>
import { Transition, onMounted, onUnmounted, ref, watch } from 'vue'
import { getFileUrl } from '@/config'

const props = defineProps({
  isOpen: Boolean,
  course: Object,
  isEnrolled: Boolean,
  courseStatus: {
    type: String,
    default: 'NONE'
  }
})

const isDark = ref(false)
const activeTab = ref('general')
let themeObserver = null

const emit = defineEmits(['close', 'enroll'])

function close() {
  emit('close')
}

function syncTheme() {
  isDark.value = document.documentElement.classList.contains('dark')
}

watch(() => props.isOpen, (newVal) => {
  document.body.style.overflow = newVal ? 'hidden' : ''
})

onMounted(() => {
  syncTheme()
  themeObserver = new MutationObserver(syncTheme)
  themeObserver.observe(document.documentElement, { attributes: true, attributeFilter: ['class'] })
})

onUnmounted(() => {
  themeObserver?.disconnect()
  document.body.style.overflow = ''
})
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.5s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.28s cubic-bezier(0.16, 1, 0.3, 1);
}

.fade-slide-enter-from,
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(14px) scale(0.985);
}

.shadow-neon {
  box-shadow: 0 0 30px -10px var(--accent-neon);
}

.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: color-mix(in srgb, var(--on-surface) 16%, transparent);
  border-radius: 10px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: color-mix(in srgb, var(--on-surface) 28%, transparent);
}

.hide-scrollbar::-webkit-scrollbar {
  display: none;
}
.hide-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
