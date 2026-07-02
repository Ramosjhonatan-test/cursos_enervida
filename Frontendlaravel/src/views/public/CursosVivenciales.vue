<template>
  <div class="mesh-gradient min-h-screen w-full overflow-x-hidden">
    <Navbar />
    <main class="pt-28 sm:pt-32 md:pt-40 pb-20 relative">
      <!-- Background decorations -->
      <div class="absolute top-0 left-1/4 w-[600px] h-[600px] bg-accent-neon/5 rounded-full blur-[150px] pointer-events-none"></div>
      <div class="absolute bottom-0 right-1/4 w-[500px] h-[500px] bg-accent-solar/5 rounded-full blur-[120px] pointer-events-none"></div>

      <div class="max-w-[1400px] mx-auto px-4 md:px-6 lg:px-8 relative z-10">

        <!-- Top Navigation Bar (centered) -->
        <div class="flex justify-center mb-8 md:mb-12 animate-in fade-in duration-500">
          <div class="glass-topbar rounded-2xl sm:rounded-full px-4 sm:px-6 md:px-8 py-3 sm:py-3 flex flex-wrap sm:flex-nowrap items-center justify-center gap-2 sm:gap-3 md:gap-4">
            <router-link to="/cursos/vivenciales" class="nav-pill nav-pill-active">
              <span class="material-symbols-outlined text-base sm:text-lg">sunny</span>
              <span class="hidden sm:inline">Vivenciales</span>
            </router-link>
            <router-link to="/cursos/online" class="nav-pill">
              <span class="material-symbols-outlined text-base sm:text-lg">laptop_mac</span>
              <span class="hidden sm:inline">Online</span>
            </router-link>
            <router-link to="/cursos/tecnicos" class="nav-pill">
              <span class="material-symbols-outlined text-base sm:text-lg">engineering</span>
              <span class="hidden sm:inline">Técnicos</span>
            </router-link>
            <div class="hidden md:block w-px h-6 bg-on-surface/10 mx-1"></div>
            <router-link to="/" class="nav-pill nav-pill-back">
              <span class="material-symbols-outlined text-base sm:text-lg">arrow_back</span>
              <span class="hidden sm:inline">Inicio</span>
            </router-link>
          </div>
        </div>

        <!-- Page Header (centered) -->
        <div class="text-center mb-12 md:mb-16 animate-in fade-in slide-in-from-top duration-700">
          <div class="flex items-center justify-center gap-3 mb-4">
            <span class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-accent-neon/10 border border-accent-neon/20">
              <span class="material-symbols-outlined text-accent-neon text-base">sunny</span>
              <span class="text-[10px] font-black tracking-[0.3em] uppercase text-accent-neon">Presencial</span>
            </span>
          </div>
          <h1 class="font-lexend text-3xl sm:text-4xl md:text-5xl lg:text-6xl font-black text-on-surface leading-[1.1] tracking-tight mb-4">
            Cursos <span class="text-gradient-neon">Vivenciales</span>
          </h1>
          <p class="text-on-surface-variant text-sm sm:text-base md:text-lg lg:text-xl max-w-2xl mx-auto font-medium leading-relaxed">
            Experiencias presenciales en La Casa Solar de ENERVIDA. Aprende tocando, viendo y experimentando la energía solar en acción.
          </p>
        </div>

        <!-- Course Cards -->
        <div class="grid gap-6 md:gap-8">
          <div 
            v-for="(course, index) in vivenciales" 
            :key="index"
            class="group animate-in fade-in slide-in-from-bottom duration-700"
            :style="{ 'animation-delay': `${index * 200}ms` }"
          >
            <div class="glass-card rounded-2xl sm:rounded-[2rem] overflow-hidden border border-on-surface/5 hover:border-accent-neon/20 transition-all duration-500 hover:shadow-[0_20px_60px_rgba(0,0,0,0.15)]">
              <div class="flex flex-col md:flex-row">
                <!-- Image -->
                <div class="md:w-[45%] lg:w-[40%] relative overflow-hidden">
                  <div class="aspect-[16/9] md:aspect-auto md:h-full min-h-[200px] md:min-h-[320px]">
                    <img 
                      :src="course.image" 
                      :alt="course.title"
                      loading="lazy"
                      decoding="async"
                      class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700 ease-out"
                    />
                    <div class="absolute inset-0 bg-gradient-to-r from-transparent via-transparent to-background/90 hidden md:block"></div>
                    <div class="absolute inset-0 bg-gradient-to-t from-background/60 to-transparent md:hidden"></div>
                  </div>
                  <div class="absolute top-3 left-3 sm:top-4 sm:left-4 glass-premium rounded-full px-3 py-1.5 sm:px-4 sm:py-2 text-[9px] font-black uppercase tracking-[0.2em] text-accent-neon border border-accent-neon/20 shadow-lg">
                    {{ course.badge }}
                  </div>
                </div>

                <!-- Content -->
                <div class="flex-1 p-5 sm:p-6 md:p-8 lg:p-10 xl:p-12 flex flex-col justify-center">
                  <div class="flex items-center gap-2 mb-2 sm:mb-3">
                    <span class="material-symbols-outlined text-accent-neon text-lg sm:text-xl">{{ course.icon }}</span>
                    <span class="text-[9px] sm:text-[10px] font-black uppercase tracking-[0.2em] text-accent-neon">{{ course.schedule }}</span>
                  </div>

                  <h2 class="font-lexend text-xl sm:text-2xl md:text-3xl lg:text-4xl font-black text-on-surface mb-3 sm:mb-4 leading-tight tracking-tight">
                    {{ course.title }}
                  </h2>

                  <p class="text-on-surface-variant text-xs sm:text-sm md:text-base lg:text-lg leading-relaxed mb-4 sm:mb-6 max-w-2xl">
                    {{ course.description }}
                  </p>

                  <div class="flex flex-wrap gap-1.5 sm:gap-2 mb-6 sm:mb-8" v-if="course.features">
                    <span 
                      v-for="(feat, fi) in course.features" 
                      :key="fi"
                      class="inline-flex items-center gap-1 sm:gap-1.5 px-2.5 py-1 sm:px-3 sm:py-1.5 rounded-full bg-accent-neon/5 border border-accent-neon/10 text-[10px] sm:text-[11px] font-semibold text-on-surface"
                    >
                      <span class="material-symbols-outlined text-accent-neon text-xs sm:text-sm">check_circle</span>
                      {{ feat }}
                    </span>
                  </div>

                  <div class="flex flex-col sm:flex-row items-start sm:items-center gap-3 sm:gap-4">
                    <!--al hacer click en el boton se deve redirigir al login-->
                    <router-link :to="course.link" class="btn-premium btn-primary-neon !px-6 sm:!px-8 !py-3 sm:!py-3.5 !text-[10px] sm:!text-[11px] shadow-neon-sm group/btn w-full sm:w-auto text-center">
                      <span>{{ course.cta }}</span>
                      <span class="material-symbols-outlined text-sm ml-2 group-hover/btn:translate-x-1 transition-transform">arrow_forward</span>
                    </router-link>
                    <span class="text-[11px] text-on-surface-variant font-medium hidden sm:block">
                      {{ course.ctaHint }}
                    </span>
                  </div>

                  <div class="w-16 h-1 rounded-full bg-accent-neon mt-6 sm:mt-8 group-hover:w-full transition-all duration-700 ease-out opacity-40"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
    <Footer />
  </div>
</template>

<script setup>
import { ref } from 'vue'
import Navbar from '@/components/public/Navbar.vue'
import Footer from '@/components/public/Footer.vue'

const vivenciales = ref([
  {
    title: 'Domingos de Familia',
    description: 'Disfruta tu domingo conociendo TODAS las aplicaciones reales de la energía solar, en La Casa Solar de ENERVIDA.',
    image: '/images/domingos-familia.webp',
    icon: 'family_restroom',
    badge: 'Familiar',
    schedule: 'Todos los Domingos',
    cta: 'Reserva tu espacio',
    ctaHint: 'Chatea con NOSOTROS',
    features: ['Experiencia práctica', 'Toda la familia', 'Casa Solar ENERVIDA', 'Sin requisitos previos'],
    link: '/login'
  },
  {
    title: 'Lun-Vie de Estudiantes',
    description: 'Vive la experiencia solar en compañía de tus compañeros y profesores, y encamina tu futuro profesional en La Casa Solar de ENERVIDA.',
    image: '/images/lun-vie-estudiantes.webp',
    icon: 'school',
    badge: 'Institucional',
    schedule: 'Lunes a Viernes',
    cta: 'Inscribe tu Institución',
    ctaHint: 'Inscripción institucional',
    features: ['Visita grupal', 'Guía especializada', 'Certificado de asistencia', 'Material didáctico'],
    link: '/login'
  },
  {
    title: 'Sábados de Técnicos',
    description: 'Sé un profesional convencido del poder de la energía solar con esta capacitación práctica e intensiva para técnicos de combate.',
    image: '/images/sabados-tecnicos.webp',
    icon: 'construction',
    badge: 'Técnico',
    schedule: 'Todos los Sábados',
    cta: 'Asegura tu espacio ¡AHORA!',
    ctaHint: 'Cupos limitados',
    features: ['Capacitación intensiva', 'Práctica en campo', 'Herramientas reales', 'Certificación técnica'],
    link: '/login'
  }
])
</script>

<style scoped>
.glass-topbar {
  background: color-mix(in srgb, var(--surface-container, #1a1a2e) 90%, transparent);
  backdrop-filter: blur(30px) saturate(180%);
  border: 1px solid var(--glass-border);
  box-shadow: var(--shadow-premium);
}

.nav-pill {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.5rem 1rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 700;
  color: var(--on-surface-variant);
  transition: all 0.3s ease;
  text-decoration: none;
  white-space: nowrap;
}

.nav-pill:hover {
  background: rgba(46, 204, 113, 0.08);
  color: var(--on-surface);
}

.nav-pill-active {
  background: rgba(46, 204, 113, 0.15) !important;
  color: var(--accent-neon) !important;
  font-weight: 800;
}

.nav-pill-back {
  opacity: 0.6;
}

.nav-pill-back:hover {
  opacity: 1;
}

.glass-card {
  background: var(--glass-bg);
  backdrop-filter: blur(20px) saturate(160%);
}

.glass-premium {
  background: var(--glass-bg);
  backdrop-filter: blur(24px) saturate(180%);
  border: 1px solid var(--glass-border);
  box-shadow: var(--shadow-premium);
}

.text-gradient-neon {
  background: linear-gradient(135deg, var(--accent-neon) 0%, var(--accent-solar) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  display: inline-block;
}

@keyframes fade-in {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes slide-in-from-bottom {
  from { transform: translateY(30px); }
  to { transform: translateY(0); }
}

@keyframes slide-in-from-top {
  from { transform: translateY(-20px); }
  to { transform: translateY(0); }
}

.animate-in {
  animation: fade-in 0.7s ease-out both, slide-in-from-bottom 0.7s ease-out both;
}

.animate-in.slide-in-from-top {
  animation: fade-in 0.7s ease-out both, slide-in-from-top 0.7s ease-out both;
}
</style>
