<template>
  <Transition name="fade">
    <div v-if="isOpen" class="fixed inset-0 z-[200] flex items-center justify-center p-4 md:p-8">
      <!-- Backdrop with premium blur and dark overlay to prevent background bleed -->
      <div class="absolute inset-0 bg-[#030712]/90 backdrop-blur-xl transition-opacity duration-700" @click="close"></div>

      <!-- Modal Content -->
      <Transition name="scale" appear>
        <div 
          v-show="isOpen"
          class="relative w-full max-w-6xl h-auto max-h-[85vh] md:max-h-[92vh] overflow-y-auto md:overflow-hidden rounded-[32px] md:rounded-[48px] !border-none bg-surface-glass/95 backdrop-blur-3xl shadow-2xl flex flex-col md:flex-row custom-scrollbar"
        >
          <!-- Decoration Orbs -->
          <div class="pointer-events-none absolute -left-20 -top-20 h-64 w-64 rounded-full bg-accent-neon/10 blur-[100px]"></div>
          <div class="pointer-events-none absolute -right-20 -bottom-20 h-64 w-64 rounded-full bg-accent-solar/5 blur-[100px]"></div>

          <!-- Close Button -->
          <button 
            @click="close"
            class="absolute top-4 right-4 md:top-8 md:right-8 z-50 h-10 w-10 md:h-12 md:w-12 rounded-2xl bg-on-surface/5 text-on-surface/60 hover:bg-accent-neon hover:text-primary transition-all duration-300 backdrop-blur-md !border-none flex items-center justify-center group"
          >
            <span class="material-symbols-outlined transition-transform group-hover:rotate-90">close</span>
          </button>

          <!-- Left Side: Premium Sidebar (Image + Header Info) -->
          <div class="w-full md:w-[40%] flex flex-col shrink-0 bg-on-surface/[0.02] !border-none">
            <!-- Image Container -->
            <div class="relative w-full p-6 md:p-8 pb-3 md:pb-4">
              <div class="aspect-video w-full overflow-hidden rounded-[24px] !border-none shadow-2xl relative group/img">
                <img 
                  :src="getFileUrl(course?.miniatura_url)" 
                  class="h-full w-full object-cover transition-transform duration-700 group-hover/img:scale-105" 
                  :alt="course?.titulo"
                />
                <!-- Subtle gradient overlay to add depth to image bottom -->
                <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
              </div>
            </div>

            <!-- Main Course Details Header (Un-obscured below the image) -->
            <div class="p-6 md:p-8 pt-0 space-y-4 md:space-y-6 flex-1 flex flex-col justify-between">
              <div class="space-y-3 md:space-y-4">
                <!-- Badges -->
                <div class="flex flex-wrap gap-2">
                  <span class="inline-flex items-center rounded-full bg-accent-neon/10 !border-none px-3 py-1 text-[8px] md:text-[9px] font-black uppercase tracking-[0.15em] text-accent-neon shadow-neon-sm">
                    {{ course?.categoria?.nombre || 'Especialidad' }}
                  </span>
                  <span class="inline-flex items-center rounded-full bg-on-surface/5 !border-none px-3 py-1 text-[8px] md:text-[9px] font-black uppercase tracking-[0.15em] text-on-surface/60">
                    {{ course?.nivel }}
                  </span>
                </div>

                <!-- Title -->
                <h2 class="font-lexend text-xl md:text-2xl lg:text-3xl font-black leading-tight text-on-surface">
                  {{ course?.titulo }}
                </h2>
              </div>

              <!-- Price Container -->
              <div class="pt-4 flex items-center justify-between !border-none">
                <div class="flex flex-col">
                  <span class="text-[8px] md:text-[9px] font-black uppercase tracking-widest text-on-surface/40">Inversión del Curso</span>
                  <div class="flex items-baseline gap-1 mt-1">
                    <span class="text-2xl md:text-[28px] lg:text-4xl font-black text-accent-neon tracking-tighter">{{ course?.precio || '0' }}</span>
                    <span class="text-[10px] md:text-xs font-black text-accent-neon uppercase">BS</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Right Side: Structured Information -->
          <div class="flex-1 flex flex-col min-w-0 bg-background/50 relative">
            <div class="flex-1 overflow-y-visible md:overflow-y-auto custom-scrollbar p-6 md:p-10 lg:p-12 space-y-8">
              <!-- Navigation Tabs -->
              <div class="flex items-center gap-4 sm:gap-8 pb-2 shrink-0 overflow-x-auto hide-scrollbar !border-none">
                <button 
                  @click="activeTab = 'general'"
                  :class="[
                    'relative pb-4 text-[10px] whitespace-nowrap font-black uppercase tracking-[0.2em] transition-all duration-300',
                    activeTab === 'general' ? 'text-accent-neon' : 'text-on-surface/40 hover:text-on-surface/80'
                  ]"
                >
                  General
                  <div v-if="activeTab === 'general'" class="absolute bottom-0 left-0 right-0 h-0.5 bg-accent-neon shadow-[0_0_10px_#059669]"></div>
                </button>
                <button 
                  @click="activeTab = 'contenido'"
                  :class="[
                    'relative pb-4 text-[10px] whitespace-nowrap font-black uppercase tracking-[0.2em] transition-all duration-300',
                    activeTab === 'contenido' ? 'text-accent-neon' : 'text-on-surface/40 hover:text-on-surface/80'
                  ]"
                >
                  Contenido
                  <div v-if="activeTab === 'contenido'" class="absolute bottom-0 left-0 right-0 h-0.5 bg-accent-neon shadow-[0_0_10px_#059669]"></div>
                </button>
              </div>

              <!-- Tab Content Area -->
              <div class="min-h-0">
                <!-- General Tab -->
                <div v-if="activeTab === 'general'" class="space-y-12 animate-in fade-in slide-in-from-bottom-4 duration-500">
                  <!-- Detailed Description Section -->
                  <section class="space-y-6">
                    <div class="flex items-center gap-4">
                      <div class="flex h-10 w-10 md:h-12 md:w-12 items-center justify-center rounded-2xl bg-accent-neon/10 !border-none">
                        <span class="material-symbols-outlined text-accent-neon">subject</span>
                      </div>
                      <div>
                        <h3 class="font-lexend text-xl md:text-2xl font-black text-on-surface">Descripción <span class="text-accent-neon">General</span></h3>
                        <p class="text-[9px] font-bold uppercase tracking-widest text-on-surface/40">Todo lo que necesitas saber sobre el programa</p>
                      </div>
                    </div>
                    
                    <div class="prose prose-invert max-w-none">
                      <div v-if="course?.descripcion_corta" class="text-accent-neon font-medium text-base md:text-lg leading-relaxed mb-4">
                        {{ course?.descripcion_corta }}
                      </div>
                      <p class="text-on-surface/70 text-sm md:text-base leading-relaxed whitespace-pre-line font-medium">
                        {{ course?.descripcion || 'Sin descripción detallada disponible.' }}
                      </p>
                    </div>
                  </section>

                  <!-- Key Features / What's Included -->
                  <section class="grid grid-cols-1 sm:grid-cols-3 gap-4 md:gap-6">
                    <div v-if="course?.certificado_habilitado" class="flex flex-col gap-4 rounded-[24px] md:rounded-[32px] bg-on-surface/[0.03] !border-none p-6 md:p-8 group hover:bg-on-surface/[0.05] transition-all duration-500">
                      <div class="h-12 w-12 md:h-14 md:w-14 rounded-2xl bg-accent-neon/10 flex items-center justify-center !border-none group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-accent-neon text-2xl md:text-3xl">verified</span>
                      </div>
                      <div>
                        <h4 class="text-[11px] md:text-xs font-black text-on-surface uppercase tracking-widest">Certificación</h4>
                        <p class="mt-2 text-[10px] leading-relaxed text-on-surface/40">Otorga certificado al finalizar el curso.</p>
                      </div>
                    </div>
                    
                    <div class="flex flex-col gap-4 rounded-[24px] md:rounded-[32px] bg-on-surface/[0.03] !border-none p-6 md:p-8 group hover:bg-on-surface/[0.05] transition-all duration-500">
                      <div class="h-12 w-12 md:h-14 md:w-14 rounded-2xl bg-accent-solar/10 flex items-center justify-center !border-none group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-accent-solar text-2xl md:text-3xl">all_inclusive</span>
                      </div>
                      <div>
                        <h4 class="text-[11px] md:text-xs font-black text-on-surface uppercase tracking-widest">Acceso Vitalicio</h4>
                        <p class="mt-2 text-[10px] leading-relaxed text-on-surface/40">Consulta el material en cualquier momento.</p>
                      </div>
                    </div>

                    <div class="flex flex-col gap-4 rounded-[24px] md:rounded-[32px] bg-on-surface/[0.03] !border-none p-6 md:p-8 group hover:bg-on-surface/[0.05] transition-all duration-500">
                      <div class="h-12 w-12 md:h-14 md:w-14 rounded-2xl bg-accent-neon/10 flex items-center justify-center !border-none group-hover:scale-110 transition-transform">
                        <span class="material-symbols-outlined text-accent-neon text-2xl md:text-3xl">devices</span>
                      </div>
                      <div>
                        <h4 class="text-[11px] md:text-xs font-black text-on-surface uppercase tracking-widest">Multiplataforma</h4>
                        <p class="mt-2 text-[10px] leading-relaxed text-on-surface/40">Aprende desde tu PC, Tablet o Smartphone.</p>
                      </div>
                    </div>
                  </section>
                </div>

                <!-- Contenido Tab -->
                <div v-if="activeTab === 'contenido'" class="space-y-8 animate-in fade-in slide-in-from-bottom-4 duration-500">
                  <div class="space-y-2">
                    <h3 class="font-lexend text-xl md:text-2xl font-black text-on-surface">¿Qué <span class="text-accent-solar">aprenderás</span>?</h3>
                    <p class="text-[9px] font-bold uppercase tracking-widest text-on-surface/40">Módulos de aprendizaje</p>
                  </div>

                  <div class="grid grid-cols-1 gap-4">
                    <template v-if="course?.modulos?.length">
                      <div v-for="(modulo, index) in course.modulos" :key="modulo.id || index" class="flex flex-col sm:flex-row sm:items-center gap-4 sm:gap-5 p-5 md:p-6 rounded-[24px] bg-on-surface/[0.02] !border-none group hover:bg-on-surface/[0.04] transition-all">
                        <div class="flex items-center gap-4 sm:gap-5">
                          <div class="h-10 w-10 md:h-12 md:w-12 shrink-0 rounded-xl bg-accent-solar/10 flex items-center justify-center text-accent-solar font-black text-base md:text-lg group-hover:bg-accent-solar group-hover:text-primary transition-all">
                            {{ index + 1 }}
                          </div>
                          <div>
                            <h5 class="text-xs md:text-sm font-black text-on-surface uppercase tracking-wider">{{ modulo.titulo }}</h5>
                            <p v-if="modulo.descripcion" class="text-[11px] font-medium text-on-surface/50 mt-1">{{ modulo.descripcion }}</p>
                          </div>
                        </div>
                        <div class="sm:ml-auto shrink-0 pl-14 sm:pl-0">
                          <span class="inline-block px-3 py-1 rounded-full bg-on-surface/5 text-[9px] text-on-surface/50 font-bold uppercase !border-none">Módulo</span>
                        </div>
                      </div>
                    </template>
                    <div v-else class="flex flex-col items-center justify-center p-12 text-center !border-none rounded-[24px] bg-on-surface/[0.02]">
                      <span class="material-symbols-outlined text-4xl text-on-surface/20 mb-3">auto_stories</span>
                      <p class="text-sm font-medium text-on-surface/40">Aún no hay módulos publicados para este curso.</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Fixed CTA Footer at the bottom of Right Side (Sticky on Mobile, Relative on Desktop) -->
            <div class="sticky md:relative bottom-0 p-6 md:p-8 flex justify-center md:justify-end shrink-0 z-20 bg-surface-glass/95 backdrop-blur-md shadow-[0_-10px_20px_rgba(0,0,0,0.3)] !border-none">
              <button 
                v-if="!isEnrolled"
                @click="$emit('enroll', course)"
                class="btn-premium btn-primary-neon w-full md:w-auto !h-14 md:!h-16 !px-8 md:!px-16 !rounded-2xl shadow-neon transition-transform hover:scale-105 active:scale-95 group/cta"
              >
                <span class="flex items-center justify-center gap-2 md:gap-3 text-[11px] md:text-xs">
                  INSCRIBIRME AHORA
                  <span class="material-symbols-outlined transition-transform group-hover/cta:translate-x-2">arrow_forward</span>
                </span>
              </button>
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
  isEnrolled: Boolean
})

const activeTab = ref('general')

const emit = defineEmits(['close', 'enroll'])

function close() {
  emit('close')
}

// Lock scroll when open
watch(() => props.isOpen, (newVal) => {
  if (newVal) {
    document.body.style.overflow = 'hidden'
  } else {
    document.body.style.overflow = ''
  }
})

onUnmounted(() => {
  document.body.style.overflow = ''
})
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.5s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

.scale-enter-active, .scale-leave-active { transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1); }
.scale-enter-from { opacity: 0; transform: scale(0.9) translateY(20px); }
.scale-leave-to { opacity: 0; transform: scale(0.95); }

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
  background: rgba(255, 255, 255, 0.05);
  border-radius: 10px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: rgba(255, 255, 255, 0.1);
}

.hide-scrollbar::-webkit-scrollbar {
  display: none;
}
.hide-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
