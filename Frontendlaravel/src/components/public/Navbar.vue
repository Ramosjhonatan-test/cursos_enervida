<template>
  <header class="fixed top-0 w-full z-[999] transition-all duration-500" :class="[isScrolled ? 'py-2 px-2 md:py-4 md:px-6' : 'py-4 px-4 md:py-8 md:px-12']">
    <nav class="max-w-7xl mx-auto glass-premium rounded-full h-16 md:h-24 px-4 md:px-10 flex items-center justify-between shadow-2xl relative">
      <!-- Logo -->
      <router-link to="/" class="flex items-center gap-3 z-50 group">
        <AppLogo 
          :img-style="{ height: isScrolled ? '2.5rem' : 'clamp(3.5rem, 8vw, 5rem)' }" 
          img-class="w-auto object-contain drop-shadow-md transition-all duration-500 ease-out origin-left" 
        />
      </router-link>

      <!-- Desktop Menu -->
      <div class="hidden lg:flex gap-5 xl:gap-8 items-center font-lexend text-[10px] xl:text-[13px] font-bold tracking-[0.15em] xl:tracking-[0.2em] uppercase">
        <a @click.prevent="scrollTo('#inicio')" :class="[currentSection === 'inicio' ? 'text-accent-neon scale-110' : 'text-on-surface/60 hover:text-on-surface hover:scale-110', 'transition-all cursor-pointer']">INICIO</a>
        
        <!-- CURSOS with Mega Menu -->
        <div class="relative" @mouseenter="openCoursesMenu" @mouseleave="startCloseTimer">
          <a @click.prevent="toggleCoursesMenu" 
             :class="[currentSection === 'cursos' || isCoursesMenuOpen ? 'text-accent-neon scale-110' : 'text-on-surface/60 hover:text-on-surface hover:scale-110', 'transition-all cursor-pointer flex items-center gap-1']">
            CURSOS
            <span class="material-symbols-outlined text-sm transition-transform duration-300" :class="{ 'rotate-180': isCoursesMenuOpen }">expand_more</span>
          </a>

          <!-- Mega Menu Dropdown -->
          <transition name="mega-menu">
            <div v-if="isCoursesMenuOpen" 
                 @mouseenter="cancelCloseTimer"
                 @mouseleave="startCloseTimer"
                 class="absolute top-[calc(100%+1.5rem)] left-1/2 -translate-x-1/2 w-[720px] glass-mega rounded-[2rem] p-8 shadow-[0_30px_80px_rgba(0,0,0,0.35)] z-[1001] overflow-hidden">
              
              <!-- Decorative glow -->
              <div class="absolute top-0 left-1/4 w-40 h-40 bg-accent-neon/10 rounded-full blur-[80px] pointer-events-none"></div>
              <div class="absolute bottom-0 right-1/4 w-40 h-40 bg-accent-solar/8 rounded-full blur-[60px] pointer-events-none"></div>

              <div class="relative z-10">
                <!-- Header -->
                <div class="flex items-center justify-between mb-6">
                  <div>
                    <h3 class="font-lexend text-lg font-black text-on-surface tracking-tight">Nuestros Cursos</h3>
                    <p class="text-on-surface-variant text-xs font-medium mt-0.5">Elige la formación ideal para ti</p>
                  </div>
                  <a @click.prevent="scrollTo('#cursos'); closeCoursesMenu()" class="text-[10px] font-bold tracking-widest uppercase text-accent-neon hover:underline cursor-pointer flex items-center gap-1">
                    Ver todos
                    <span class="material-symbols-outlined text-sm">arrow_forward</span>
                  </a>
                </div>

                <div class="grid grid-cols-3 gap-5">
                  <!-- Card: Vivenciales -->
                  <router-link to="/cursos/vivenciales" @click="closeCoursesMenu" class="mega-card group">
                    <div class="mega-card-icon bg-accent-neon/10 text-accent-neon">
                      <span class="material-symbols-outlined text-2xl">sunny</span>
                    </div>
                    <h4 class="font-lexend font-black text-on-surface text-sm mb-1 group-hover:text-accent-neon transition-colors">Vivenciales</h4>
                    <p class="text-[11px] text-on-surface-variant leading-snug font-medium">Experiencias presenciales en La Casa Solar</p>
                    <div class="mega-card-items">
                      <span>Domingos de familia</span>
                      <span>Lun-Vie estudiantes</span>
                      <span>Sábados de técnicos</span>
                    </div>
                    <div class="mega-card-badge bg-accent-neon/10 text-accent-neon">
                      <span class="material-symbols-outlined text-xs">location_on</span>
                      Presencial
                    </div>
                  </router-link>

                  <!-- Card: Online -->
                  <router-link to="/cursos/online" @click="closeCoursesMenu" class="mega-card group">
                    <div class="mega-card-icon bg-accent-solar/10 text-accent-solar">
                      <span class="material-symbols-outlined text-2xl">laptop_mac</span>
                    </div>
                    <h4 class="font-lexend font-black text-on-surface text-sm mb-1 group-hover:text-accent-solar transition-colors">Online</h4>
                    <p class="text-[11px] text-on-surface-variant leading-snug font-medium">Energía solar para todos los sectores</p>
                    <div class="mega-card-items">
                      <span>Para TODO</span>
                      <span>CALOR</span>
                      <span>ELECTRICIDAD</span>
                      <span>+4 más</span>
                    </div>
                    <div class="mega-card-badge bg-accent-solar/10 text-accent-solar">
                      <span class="material-symbols-outlined text-xs">wifi</span>
                      Virtual
                    </div>
                  </router-link>

                  <!-- Card: Técnicos -->
                  <router-link to="/cursos/tecnicos" @click="closeCoursesMenu" class="mega-card group">
                    <div class="mega-card-icon bg-blue-500/10 text-blue-400">
                      <span class="material-symbols-outlined text-2xl">engineering</span>
                    </div>
                    <h4 class="font-lexend font-black text-on-surface text-sm mb-1 group-hover:text-blue-400 transition-colors">Para Técnicos</h4>
                    <p class="text-[11px] text-on-surface-variant leading-snug font-medium">Especialización avanzada en diseño solar</p>
                    <div class="mega-card-items">
                      <span>PVSyst</span>
                      <span>Gen. Distribuida</span>
                      <span>Sist. Aislados</span>
                      <span>+4 más</span>
                    </div>
                    <div class="mega-card-badge bg-blue-500/10 text-blue-400">
                      <span class="material-symbols-outlined text-xs">workspace_premium</span>
                      Avanzado
                    </div>
                  </router-link>
                </div>
              </div>
            </div>
          </transition>
        </div>

        <a @click.prevent="scrollTo('#impacto')" :class="[currentSection === 'impacto' ? 'text-accent-neon scale-110' : 'text-on-surface/60 hover:text-on-surface hover:scale-110', 'transition-all cursor-pointer']">IMPACTO</a>
        <a @click.prevent="scrollTo('#socios')" :class="[currentSection === 'socios' ? 'text-accent-neon scale-110' : 'text-on-surface/60 hover:text-on-surface hover:scale-110', 'transition-all cursor-pointer']">SOCIOS</a>
        <a @click.prevent="scrollTo('#nosotros')" :class="[currentSection === 'nosotros' ? 'text-accent-neon scale-110' : 'text-on-surface/60 hover:text-on-surface hover:scale-110', 'transition-all cursor-pointer']">NOSOTROS</a>
        <a @click.prevent="scrollTo('#contacto')" :class="[currentSection === 'contacto' ? 'text-accent-neon scale-110' : 'text-on-surface/60 hover:text-on-surface hover:scale-110', 'transition-all cursor-pointer']">CONTACTO</a>
      </div>

      <!-- Actions -->
      <div class="flex items-center gap-2 md:gap-6">
        <ThemeToggle />
        <button @click="$router.push('/login')" class="btn-premium btn-primary-neon !px-4 md:!px-8 !py-2.5 md:!py-3 !text-[10px] md:!text-[12px] shadow-neon-sm whitespace-nowrap">Iniciar Sesión</button>
        
        <!-- Mobile Toggle -->
        <button @click="isMenuOpen = !isMenuOpen" 
                class="text-on-surface w-10 h-10 lg:hidden flex items-center justify-center rounded-full hover:bg-on-surface/5 transition-colors" 
                aria-label="Toggle Menu">
          <span class="material-symbols-outlined text-2xl md:text-3xl transition-transform duration-300" :class="{'rotate-90': isMenuOpen}">
            {{ isMenuOpen ? 'close' : 'menu' }}
          </span>
        </button>
      </div>

      <!-- Mobile Menu Dropdown -->
      <transition name="mobile-menu">
        <div v-if="isMenuOpen" 
             class="absolute top-[calc(100%+0.75rem)] left-0 w-full glass-premium rounded-[2.5rem] p-8 flex flex-col gap-4 lg:hidden shadow-[0_40px_80px_rgba(0,0,0,0.5)] z-[1000] overflow-hidden transition-all duration-300">
          <div class="absolute inset-0 bg-accent-neon/5 pointer-events-none"></div>
          
          <a @click.prevent="scrollTo('#inicio')" :class="[currentSection === 'inicio' ? 'text-accent-neon' : 'text-on-surface hover:text-accent-neon', 'relative z-10 font-black uppercase tracking-[0.2em] text-sm py-2 cursor-pointer transition-colors']">INICIO</a>
          
          <!-- Mobile Cursos Expandable -->
          <div class="relative z-10">
            <a @click.prevent="isMobileCoursesOpen = !isMobileCoursesOpen" 
               class="font-black uppercase tracking-[0.2em] text-sm py-2 cursor-pointer transition-colors flex items-center justify-between w-full"
               :class="[isMobileCoursesOpen ? 'text-accent-neon' : 'text-on-surface hover:text-accent-neon']">
              CURSOS
              <span class="material-symbols-outlined text-lg transition-transform duration-300" :class="{ 'rotate-180': isMobileCoursesOpen }">expand_more</span>
            </a>
            <transition name="mobile-sub">
              <div v-if="isMobileCoursesOpen" class="pl-4 mt-2 space-y-2 border-l-2 border-accent-neon/20">
                <router-link to="/cursos/vivenciales" @click="isMenuOpen = false" class="flex items-center gap-3 py-2.5 px-3 rounded-xl hover:bg-accent-neon/5 transition-colors">
                  <span class="material-symbols-outlined text-accent-neon text-lg">sunny</span>
                  <div>
                    <span class="text-on-surface font-bold text-xs block">Vivenciales</span>
                    <span class="text-on-surface-variant text-[10px]">Presencial</span>
                  </div>
                </router-link>
                <router-link to="/cursos/online" @click="isMenuOpen = false" class="flex items-center gap-3 py-2.5 px-3 rounded-xl hover:bg-accent-solar/5 transition-colors">
                  <span class="material-symbols-outlined text-accent-solar text-lg">laptop_mac</span>
                  <div>
                    <span class="text-on-surface font-bold text-xs block">Online</span>
                    <span class="text-on-surface-variant text-[10px]">Virtual</span>
                  </div>
                </router-link>
                <router-link to="/cursos/tecnicos" @click="isMenuOpen = false" class="flex items-center gap-3 py-2.5 px-3 rounded-xl hover:bg-blue-500/5 transition-colors">
                  <span class="material-symbols-outlined text-blue-400 text-lg">engineering</span>
                  <div>
                    <span class="text-on-surface font-bold text-xs block">Para Técnicos</span>
                    <span class="text-on-surface-variant text-[10px]">Avanzado</span>
                  </div>
                </router-link>
              </div>
            </transition>
          </div>

          <a @click.prevent="scrollTo('#impacto')" :class="[currentSection === 'impacto' ? 'text-accent-neon' : 'text-on-surface hover:text-accent-neon', 'relative z-10 font-black uppercase tracking-[0.2em] text-sm py-2 cursor-pointer transition-colors']">IMPACTO</a>
          <a @click.prevent="scrollTo('#socios')" :class="[currentSection === 'socios' ? 'text-accent-neon' : 'text-on-surface hover:text-accent-neon', 'relative z-10 font-black uppercase tracking-[0.2em] text-sm py-2 cursor-pointer transition-colors']">SOCIOS</a>
          <a @click.prevent="scrollTo('#nosotros')" :class="[currentSection === 'nosotros' ? 'text-accent-neon' : 'text-on-surface hover:text-accent-neon', 'relative z-10 font-black uppercase tracking-[0.2em] text-sm py-2 cursor-pointer transition-colors']">NOSOTROS</a>
          <a @click.prevent="scrollTo('#contacto')" :class="[currentSection === 'contacto' ? 'text-accent-neon' : 'text-on-surface hover:text-accent-neon', 'relative z-10 font-black uppercase tracking-[0.2em] text-sm py-2 cursor-pointer transition-colors']">CONTACTO</a>
          
          <hr class="border-on-surface/10 relative z-10 my-2" />
          
          <button @click="$router.push('/login'); isMenuOpen = false" class="relative z-10 btn-premium btn-primary-neon !w-full !py-5 text-center text-[11px] font-black shadow-lg">
            Entrar a la Academia
          </button>
        </div>
      </transition>
    </nav>
  </header>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import ThemeToggle from '@/components/global/ThemeToggle.vue'
import AppLogo from '@/components/global/AppLogo.vue'

const router = useRouter()
const route = useRoute()

const isMenuOpen = ref(false)
const isScrolled = ref(false)
const currentSection = ref('inicio')
const isCoursesMenuOpen = ref(false)
const isMobileCoursesOpen = ref(false)

let closeTimer = null

const openCoursesMenu = () => {
  cancelCloseTimer()
  isCoursesMenuOpen.value = true
}

const closeCoursesMenu = () => {
  isCoursesMenuOpen.value = false
}

const startCloseTimer = () => {
  closeTimer = setTimeout(() => {
    isCoursesMenuOpen.value = false
  }, 300)
}

const cancelCloseTimer = () => {
  if (closeTimer) {
    clearTimeout(closeTimer)
    closeTimer = null
  }
}

const toggleCoursesMenu = () => {
  isCoursesMenuOpen.value = !isCoursesMenuOpen.value
}

const scrollTo = (hash) => {
  isMenuOpen.value = false;
  isCoursesMenuOpen.value = false;
  
  if (route.path !== '/') {
    router.push('/').then(() => {
      setTimeout(() => performScroll(hash), 300);
    });
  } else {
    setTimeout(() => performScroll(hash), 100);
  }
}

const performScroll = (hash) => {
  const el = document.querySelector(hash);
  if (el) {
    const yOffset = -80; // offset for fixed navbar
    const y = el.getBoundingClientRect().top + window.pageYOffset + yOffset;
    window.scrollTo({ top: y, behavior: 'smooth' });
  }
}

const handleScroll = () => {
  isScrolled.value = window.scrollY > 50

  if (route.path === '/') {
    const sections = ['inicio', 'cursos', 'impacto', 'socios', 'nosotros', 'contacto'];
    let current = '';
    
    // We iterate backwards to find the last section that we have scrolled past
    for (let i = sections.length - 1; i >= 0; i--) {
      const section = sections[i];
      const el = document.getElementById(section);
      if (el) {
        const rect = el.getBoundingClientRect();
        // Adjust threshold based on typical header height and some padding
        if (rect.top <= 150) {
          current = section;
          break;
        }
      }
    }
    
    if (current && currentSection.value !== current) {
      currentSection.value = current;
    }
  }
}

// Close mega menu when clicking outside
const handleClickOutside = (e) => {
  if (isCoursesMenuOpen.value && !e.target.closest('.mega-menu-container')) {
    isCoursesMenuOpen.value = false
  }
}

// Bloquear scroll cuando el menú móvil está abierto
watch(isMenuOpen, (newValue) => {
  if (newValue) {
    document.body.style.overflow = 'hidden'
  } else {
    document.body.style.overflow = ''
    isMobileCoursesOpen.value = false
  }
})

onMounted(() => {
  window.addEventListener('scroll', handleScroll)
  document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
  document.removeEventListener('click', handleClickOutside)
  // Asegurar que el scroll se restaure si el componente se desmonta con el menú abierto
  document.body.style.overflow = ''
  cancelCloseTimer()
})
</script>

<style scoped>
.glass-premium {
    background: var(--glass-bg);
    backdrop-filter: blur(24px) saturate(180%);
    border: 1px solid var(--glass-border);
    box-shadow: var(--shadow-premium);
}

.glass-mega {
    background: color-mix(in srgb, var(--surface-container, #1a1a2e) 92%, transparent);
    backdrop-filter: blur(40px) saturate(200%);
    border: 1px solid var(--glass-border);
    box-shadow: var(--shadow-premium), 0 0 0 1px rgba(0,0,0,0.1);
}

/* Mega Menu Cards */
.mega-card {
    display: flex;
    flex-direction: column;
    padding: 1.25rem;
    border-radius: 1.25rem;
    border: 1px solid transparent;
    transition: all 0.3s ease;
    text-decoration: none;
    position: relative;
    overflow: hidden;
}

.mega-card:hover {
    background: rgba(46, 204, 113, 0.04);
    border-color: rgba(46, 204, 113, 0.12);
    transform: translateY(-2px);
}

.mega-card-icon {
    width: 48px;
    height: 48px;
    border-radius: 1rem;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 0.75rem;
    transition: transform 0.3s ease;
}

.mega-card:hover .mega-card-icon {
    transform: scale(1.1);
}

.mega-card-items {
    display: flex;
    flex-wrap: wrap;
    gap: 0.25rem;
    margin-top: 0.75rem;
    margin-bottom: 0.75rem;
}

.mega-card-items span {
    font-size: 9px;
    font-weight: 600;
    padding: 2px 8px;
    border-radius: 6px;
    background: var(--surface-container, rgba(0,0,0,0.05));
    color: var(--on-surface-variant);
    white-space: nowrap;
}

.mega-card-badge {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-size: 10px;
    font-weight: 800;
    letter-spacing: 0.05em;
    text-transform: uppercase;
    padding: 4px 10px;
    border-radius: 8px;
    width: fit-content;
    margin-top: auto;
}

/* Mega Menu Transitions */
.mega-menu-enter-active { 
    transition: all 0.35s cubic-bezier(0.16, 1, 0.3, 1); 
}
.mega-menu-leave-active { 
    transition: all 0.2s ease-in; 
}
.mega-menu-enter-from { 
    opacity: 0; 
    transform: translate(-50%, -12px) scale(0.96); 
}
.mega-menu-leave-to { 
    opacity: 0; 
    transform: translate(-50%, -8px) scale(0.98); 
}

/* Mobile Menu Transitions */
.mobile-menu-enter-active, .mobile-menu-leave-active { 
    transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1); 
}
.mobile-menu-enter-from, .mobile-menu-leave-to { 
    opacity: 0; 
    transform: translateY(-20px) scale(0.95); 
}

.mobile-sub-enter-active { 
    transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1); 
}
.mobile-sub-leave-active { 
    transition: all 0.2s ease-in; 
}
.mobile-sub-enter-from, .mobile-sub-leave-to { 
    opacity: 0; 
    max-height: 0;
    transform: translateY(-8px); 
}
.mobile-sub-enter-to, .mobile-sub-leave-from {
    max-height: 300px;
}

.logo-img {
    height: clamp(4rem, 8vw, 6.5rem);
}
</style>
