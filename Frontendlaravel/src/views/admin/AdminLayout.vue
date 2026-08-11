<template>
  <div class="admin-surface min-h-screen text-on-surface font-inter">
    <!-- Theme transition overlay (center-out circle) -->
    <div id="theme-transition-overlay" aria-hidden="true"></div>

    <transition name="overlay-fade">
      <div v-if="isMenuOpen" class="fixed inset-0 z-[70] bg-black/60 backdrop-blur-md lg:hidden" @click="isMenuOpen = false"></div>
    </transition>

    <aside
      :class="[
        'fixed left-0 top-0 z-[80] flex h-full flex-col glass-card',
        'transition-[transform,width,opacity] duration-500 ease-[cubic-bezier(0.32,0.72,0,1)]',
        isSidebarCollapsed ? 'lg:w-24' : 'lg:w-72',
        isMenuOpen
          ? 'translate-x-0 w-80 opacity-100 scale-100 shadow-2xl shadow-black/40'
          : 'pointer-events-none -translate-x-full w-80 opacity-0 scale-[0.97] lg:translate-x-0 lg:scale-100 lg:opacity-100 lg:pointer-events-auto'
      ]"
    >
      <!-- Sidebar Header -->
      <div class="flex h-20 items-center gap-3 px-5">
        <div v-if="isSidebarCollapsed && !isMenuOpen" class="grid h-11 w-11 shrink-0 place-items-center">
          <img src="/sol.png" alt="Enervida Icon" style="height: clamp(2rem, 4vw, 2.75rem);" class="w-auto object-contain transition-all duration-500" />
        </div>
        <div v-else class="min-w-0 flex-1">
          <AppLogo :img-style="{ height: 'clamp(2.25rem, 5vw, 3rem)' }" img-class="w-auto object-contain" />
          <div class="flex items-center gap-1.5 mt-1">
            <span class="h-1 w-1 rounded-full bg-accent-neon"></span>
            <p class="text-[10px] font-black uppercase tracking-[0.26em] text-on-surface-variant">Campus admin</p>
          </div>
        </div>
        <button
          class="admin-soft-hover ml-auto grid h-10 w-10 place-items-center rounded-xl text-on-surface-variant hover:text-on-surface lg:hidden"
          type="button"
          @click="isMenuOpen = false"
          aria-label="Cerrar menu"
        >
          <span class="material-symbols-outlined">close</span>
        </button>
      </div>

      <!-- Navigation -->
      <nav class="flex-1 space-y-7 px-3 py-5 overflow-y-auto custom-scrollbar">
        <div v-for="category in filteredLinks" :key="category.title" class="space-y-1.5">
          <p
            v-if="!isSidebarCollapsed || isMenuOpen"
            class="px-4 text-[10px] font-black uppercase tracking-[0.2em] text-on-surface-variant/50 menu-text-anim"
          >
            {{ category.title }}
          </p>
          <div v-else class="mx-auto my-2 h-px w-6 bg-on-surface/10"></div>
          <div class="space-y-1">
            <div
              v-for="link in category.links"
              :key="link.text"
              class="relative"
              @mouseenter="hoveredLink = link.text"
              @mouseleave="hoveredLink = null"
            >
              <router-link
                :to="link.path"
                :class="[
                  'group flex items-center rounded-2xl py-2.5 text-sm font-bold transition-all duration-300 relative',
                  isActive(link.path)
                    ? 'bg-accent-neon text-primary shadow-neon-sm'
                    : 'admin-soft-hover text-on-surface-variant hover:text-on-surface',
                  isSidebarCollapsed && !isMenuOpen ? 'justify-center px-0' : 'gap-3 px-4'
                ]"
                @click="isMenuOpen = false"
              >
                <span
                  v-if="link.icon"
                  class="material-symbols-outlined text-[20px] relative transition-transform duration-300 group-hover:scale-110"
                >
                  {{ link.icon }}
                  <span
                    v-if="isSidebarCollapsed && !isMenuOpen && link.text === 'Solicitudes' && solicitudStore.pendingCount > 0"
                    class="absolute -top-1.5 -right-1.5 flex h-2.5 w-2.5"
                  >
                    <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-orange-400 opacity-75"></span>
                    <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-orange-500"></span>
                  </span>
                </span>
                <span
                  v-else-if="link.svg"
                  v-html="link.svg"
                  class="w-5 h-5 flex items-center justify-center relative transition-transform duration-300 group-hover:scale-110"
                ></span>

                <span
                  v-if="!isSidebarCollapsed || isMenuOpen"
                  class="truncate flex-1 menu-text-anim"
                >
                  {{ link.text }}
                </span>

                <div
                  v-if="(!isSidebarCollapsed || isMenuOpen) && link.text === 'Solicitudes' && solicitudStore.pendingCount > 0"
                  class="relative ml-auto flex h-5 items-center justify-center"
                >
                  <span class="absolute inline-flex h-full w-full animate-ping rounded-full bg-orange-500/40 opacity-75"></span>
                  <span class="relative flex h-5 min-w-[20px] items-center justify-center rounded-full bg-orange-500 px-1.5 text-[10px] font-black uppercase tracking-wider text-white shadow-[0_2px_8px_rgba(249,115,22,0.4)] dark:shadow-[0_0_12px_rgba(249,115,22,0.4)] transition-all duration-300">
                    {{ solicitudStore.pendingCount }}
                  </span>
                </div>
              </router-link>

              <!-- Custom Tooltip when sidebar is collapsed -->
              <transition name="tooltip">
                <div
                  v-if="isSidebarCollapsed && !isMenuOpen && hoveredLink === link.text"
                  class="pointer-events-none absolute left-full top-1/2 -translate-y-1/2 ml-3 z-[90] whitespace-nowrap"
                >
                  <div class="relative rounded-xl bg-surface-glass backdrop-blur-xl px-3 py-2 shadow-xl">
                    <span class="text-xs font-bold text-on-surface">{{ link.text }}</span>
                    <span
                      v-if="link.text === 'Solicitudes' && solicitudStore.pendingCount > 0"
                      class="ml-2 inline-flex h-4 min-w-[16px] items-center justify-center rounded-full bg-orange-500 px-1 text-[9px] font-black text-white"
                    >
                      {{ solicitudStore.pendingCount }}
                    </span>
                    <span class="absolute right-full top-1/2 -translate-y-1/2 border-y-[6px] border-r-[6px] border-y-transparent border-r-surface-glass"></span>
                  </div>
                </div>
              </transition>
            </div>
          </div>
        </div>
      </nav>

      <!-- Sidebar Footer / Logout -->
      <div class="p-3">
        <button
          type="button"
          :class="[
            'flex w-full items-center rounded-2xl py-3 text-sm font-bold text-on-surface-variant transition-all duration-300 hover:bg-red-500/10 hover:text-red-500 active:scale-[0.98]',
            isSidebarCollapsed && !isMenuOpen ? 'justify-center px-0' : 'gap-3 px-4'
          ]"
          @click="handleLogout"
        >
          <span class="material-symbols-outlined text-[22px]">logout</span>
          <span v-if="!isSidebarCollapsed || isMenuOpen" class="menu-text-anim">Cerrar sesión</span>
        </button>
      </div>
    </aside>

    <!-- Top Header -->
    <header
      :class="[
        'fixed right-0 top-0 z-50 flex h-20 items-center justify-between bg-surface-glass px-4 backdrop-blur-xl transition-[left] duration-500 ease-[cubic-bezier(0.32,0.72,0,1)] md:px-8',
        isSidebarCollapsed ? 'lg:left-24' : 'lg:left-72',
        'left-0'
      ]"
    >
      <div class="flex min-w-0 items-center gap-3">
        <button
          type="button"
          class="admin-soft-hover grid h-11 w-11 place-items-center rounded-2xl text-on-surface lg:hidden active:scale-95 transition-transform"
          @click="isMenuOpen = true"
          aria-label="Abrir menu"
        >
          <span class="material-symbols-outlined">menu</span>
        </button>
        <button
          type="button"
          class="admin-soft-hover hidden h-11 w-11 place-items-center rounded-2xl text-on-surface-variant transition hover:text-on-surface lg:grid active:scale-90"
          @click="isSidebarCollapsed = !isSidebarCollapsed"
          aria-label="Colapsar menu"
        >
          <span class="material-symbols-outlined transition-transform duration-500" :class="isSidebarCollapsed ? 'rotate-180' : ''">{{ isSidebarCollapsed ? 'keyboard_double_arrow_left' : 'keyboard_double_arrow_left' }}</span>
        </button>
        <div class="min-w-0 hidden sm:block">
          <div class="flex items-center gap-1.5">
            <span class="h-1.5 w-1.5 rounded-full bg-accent-neon"></span>
            <p class="text-[10px] font-black uppercase tracking-[0.24em] text-accent-neon">Panel administrativo</p>
          </div>
          <h1 class="truncate font-lexend text-lg font-black tracking-tight md:text-xl lg:text-2xl mt-0.5">{{ currentSection }}</h1>
        </div>
      </div>

      <div class="flex flex-1 items-center justify-end gap-3 md:gap-4 lg:ml-8">
        <!-- Global Search -->
        <div class="relative flex-1 max-w-md group hidden md:block">
          <span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-on-surface/30 text-[20px] group-focus-within:text-accent-neon transition-colors">search</span>
          <input
            ref="globalSearchInput"
            v-model="globalSearchQuery"
            @keydown.enter.prevent="onGlobalSearchSubmit"
            type="text"
            placeholder="Búsqueda global..."
            aria-label="Buscar en reportes"
            class="w-full bg-on-surface/[0.03] rounded-2xl py-2.5 pl-11 pr-4 text-xs font-bold focus:outline-none focus:border-accent-neon/40 focus:bg-accent-neon/5 transition-all"
          />
          <div class="absolute right-3 top-1/2 -translate-y-1/2 flex items-center gap-1 opacity-20 group-focus-within:opacity-0 transition-opacity">
            <span class="text-[10px] font-black rounded px-1.5 py-0.5">⌘</span>
            <span class="text-[10px] font-black rounded px-1.5 py-0.5">K</span>
          </div>
        </div>

        <button class="md:hidden admin-soft-hover grid h-11 w-11 place-items-center rounded-2xl text-on-surface-variant">
          <span class="material-symbols-outlined">search</span>
        </button>

        <div class="admin-soft-bg hidden items-center gap-2 rounded-2xl px-3 py-2 lg:flex shrink-0">
          <span class="material-symbols-outlined text-[18px] text-accent-neon">bolt</span>
          <span class="text-[10px] font-black uppercase tracking-wider text-on-surface-variant">Campus activo</span>
        </div>

        <ThemeToggle />

        <div class="flex items-center gap-3 pl-2">
          <div class="hidden sm:block text-right">
            <p class="text-[10px] font-black uppercase tracking-wider text-on-surface-variant">{{ authStore.userRole }}</p>
            <p class="text-xs font-bold truncate max-w-[100px]">{{ authStore.user?.nombres }}</p>
          </div>
          <div class="relative">
            <div class="grid h-11 w-11 shrink-0 place-items-center rounded-xl bg-gradient-to-br from-accent-neon to-accent-solar p-[2px]">
              <div class="grid h-full w-full place-items-center rounded-[10px] bg-background text-xs font-black shadow-inner overflow-hidden">
                <template v-if="avatarUrl">
                  <img :src="avatarUrl" alt="Avatar" class="h-full w-full object-cover" @error="onAvatarError" />
                </template>
                <template v-else>
                  {{ initials }}
                </template>
              </div>
            </div>
            <span class="absolute -bottom-0.5 -right-0.5 h-3 w-3 rounded-full bg-emerald-500 border-2 border-background"></span>
          </div>
        </div>
      </div>
    </header>

    <main :class="['min-h-screen px-4 pb-12 pt-28 transition-[margin] duration-500 ease-[cubic-bezier(0.32,0.72,0,1)] md:px-8 xl:px-10', isSidebarCollapsed ? 'lg:ml-24' : 'lg:ml-72']">
      <router-view />
    </main>
  </div>
</template>

<script setup>
import { computed, ref, watch, onMounted, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useSolicitudStore } from '@/stores/solicitudStore'
import ThemeToggle from '@/components/global/ThemeToggle.vue'
import AppLogo from '@/components/global/AppLogo.vue'

const solicitudStore = useSolicitudStore()
let pollingInterval = null
let themeObserver = null
let lastTheme = null

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const isMenuOpen = ref(false)
const isSidebarCollapsed = ref(false)
const hoveredLink = ref(null)

const categorizedLinks = [
  {
    title: 'Principal',
    links: [
      { text: 'Dashboard', icon: 'dashboard', path: '/admin', moduleId: 'DASHBOARD' },
      { text: 'Reportes', svg: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" x2="12" y1="20" y2="10"/><line x1="18" x2="18" y1="20" y2="4"/><line x1="6" x2="6" y1="20" y2="16"/></svg>', path: '/admin/reportes', moduleId: 'REPORTES' },
      { text: 'Auditoria', icon: 'shield_lock', path: '/admin/auditoria', moduleId: 'AUDITORIA' },
    ]
  },
  {
    title: 'Académico',
    links: [
      { text: 'Cursos', icon: 'school', path: '/admin/cursos', moduleId: 'CURSOS' },
      { text: 'Categorías', icon: 'category', path: '/admin/categorias', moduleId: 'CATEGORIAS' },
      { text: 'Inscripciones', icon: 'history_edu', path: '/admin/inscripciones', moduleId: 'INSCRIPCIONES' },
      { text: 'Evaluaciones', svg: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="m9 11 3 3L22 4"/><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/></svg>', path: '/admin/evaluaciones', moduleId: 'EVALUACIONES' },
      { text: 'Calificaciones', icon: 'grade', path: '/admin/calificaciones', moduleId: 'EVALUACIONES' },
      { text: 'Clases En Vivo', svg: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M15 10l5-5v14l-5-5H5V10h10z"/></svg>', path: '/admin/clases-en-vivo', moduleId: 'CLASES_VIVO' },
      { text: 'Certificados', icon: 'workspace_premium', path: '/admin/certificados', moduleId: 'CERTIFICADOS' },
      { text: 'Solicitudes', icon: 'assignment', path: '/admin/solicitudes', moduleId: 'SOLICITUDES' },
    ]
  },
  {
    title: 'Gestión',
    links: [
      { text: 'Estudiantes', icon: 'groups', path: '/admin/estudiantes', moduleId: 'ESTUDIANTES' },
      { text: 'Usuarios', icon: 'person_search', path: '/admin/usuarios', moduleId: 'USUARIOS' },
      { text: 'Roles', icon: 'lock_person', path: '/admin/roles', moduleId: 'ROLES' },
      { text: 'Dispositivos', icon: 'devices', path: '/admin/dispositivos', moduleId: 'DISPOSITIVOS' },
    ]
  },
  {
    title: 'Sistema',
    links: [
      { text: 'Notificaciones', icon: 'notifications_active', path: '/admin/notificaciones', moduleId: 'NOTIFICACIONES' },
      { text: 'Archivos', icon: 'folder_open', path: '/admin/archivos', moduleId: 'ARCHIVOS' },
      { text: 'Verificación QR', icon: 'qr_code_scanner', path: '/admin/verificacion-qr', moduleId: 'VERIFICACIONES QR' },
    ]
  }
]

const filteredLinks = computed(() => {
  return categorizedLinks.map(category => ({
    ...category,
    links: category.links.filter(link => authStore.canAccess(link.moduleId))
  })).filter(category => category.links.length > 0)
})

const isActive = (path) => {
  if (path === '/admin') return route.path === '/admin'
  return route.path.startsWith(path)
}

// ===== Búsqueda global (header) =====
const globalSearchQuery = ref('')
const globalSearchInput = ref(null)

const onGlobalSearchSubmit = () => {
  const q = String(globalSearchQuery.value || '').trim()
  // Navega a la vista de reportes con ?q=texto
  if (!q) {
    router.push({ name: 'admin-reportes' })
    return
  }
  router.push({ name: 'admin-reportes', query: { q } })
}

const handleGlobalShortcut = (e) => {
  if ((e.ctrlKey || e.metaKey) && e.key && e.key.toLowerCase() === 'k') {
    e.preventDefault()
    // Mostrar o enfocar el input de búsqueda
    setTimeout(() => {
      globalSearchInput.value?.focus()
    }, 0)
  }
}

// ===== Avatar: mostrar imagen si existe, fallback a iniciales =====
const avatarUrl = ref(null)

const initials = computed(() => {
  const n = (authStore.user?.nombres || '').trim()
  const a = (authStore.user?.apellidos || '').trim()
  const first = n ? n.charAt(0).toUpperCase() : ''
  const last = a ? a.charAt(0).toUpperCase() : ''
  return (first + last) || (authStore.user?.email ? authStore.user.email.charAt(0).toUpperCase() : '')
})

const resolveAvatar = () => {
  const u = authStore.user || {}
  const candidate = u.imagen_perfil || u.imagen || u.foto || u.picture || u.avatar || u.photo || u.url_foto || null
  avatarUrl.value = candidate || null
}

const onAvatarError = () => {
  avatarUrl.value = null
}

watch(() => authStore.user, () => resolveAvatar(), { immediate: true })

const currentSection = computed(() => {
  for (const category of filteredLinks.value) {
    const active = category.links.find((link) => isActive(link.path))
    if (active) return active.text
  }
  return 'Dashboard'
})

const handleLogout = async () => {
  await authStore.logout()
  router.push('/')
}

watch(isMenuOpen, (open) => {
  document.body.style.overflow = open ? 'hidden' : ''
})

// ===== Theme transition (center-out circle) =====
const detectTheme = () => {
  const html = document.documentElement
  // Common class-based themes
  if (html.classList.contains('dark')) return 'dark'
  if (html.classList.contains('light')) return 'light'
  // Common data-attribute themes
  const dt = html.getAttribute('data-theme')
  if (dt === 'dark' || dt === 'light') return dt
  // Fallback: luminance of body bg
  const bg = getComputedStyle(document.body).backgroundColor
  const m = bg.match(/\d+/g)
  if (m) {
    const [r, g, b] = m.slice(0, 3).map(Number)
    const l = (0.299 * r + 0.587 * g + 0.114 * b) / 255
    return l < 0.5 ? 'dark' : 'light'
  }
  return null
}

const getThemeBg = (theme) => {
  const root = getComputedStyle(document.documentElement)
  const candidates = ['--background', '--bg', '--color-background', '--surface']
  for (const v of candidates) {
    const val = root.getPropertyValue(v).trim()
    if (val) return val
  }
  return theme === 'dark' ? '#0a0a0f' : '#f5f5f7'
}

const playThemeTransition = (newTheme) => {
  const overlay = document.getElementById('theme-transition-overlay')
  if (!overlay) return

  // The page has already switched to the new theme.
  // We paint the overlay with the NEW theme color and shrink it from full screen
  // to a small circle in the center, so the new theme feels like it "blooms" outward.
  const color = getThemeBg(newTheme)
  overlay.style.background = color

  // Start: cover everything (no transition)
  overlay.style.transition = 'none'
  overlay.style.clipPath = 'circle(150% at 50% 50%)'

  // Force reflow
  void overlay.offsetWidth

  // Animate: shrink to center
  requestAnimationFrame(() => {
    overlay.style.transition = 'clip-path 0.6s cubic-bezier(0.65, 0, 0.35, 1)'
    overlay.style.clipPath = 'circle(0% at 50% 50%)'
  })

  // Reset for next time
  setTimeout(() => {
    overlay.style.transition = 'none'
    overlay.style.clipPath = 'circle(0% at 50% 50%)'
  }, 750)
}

onMounted(() => {
  solicitudStore.fetchPendingCount()
  pollingInterval = setInterval(() => {
    solicitudStore.fetchPendingCount()
  }, 30000)

  // Si entramos a /admin pero no tenemos acceso al dashboard,
  // redirigimos automáticamente al primer módulo permitido.
  if (route.path === '/admin' && !authStore.canAccess('DASHBOARD')) {
    const firstAvailable = filteredLinks.value[0]?.links[0];
    if (firstAvailable) {
      router.replace(firstAvailable.path);
    }
  }

  // Watch for theme changes (dark/light) to play the center-out transition
  lastTheme = detectTheme()
  themeObserver = new MutationObserver(() => {
    const current = detectTheme()
    if (!current || current === lastTheme) return
    lastTheme = current
    playThemeTransition(current)
  })
  themeObserver.observe(document.documentElement, {
    attributes: true,
    attributeFilter: ['class', 'data-theme', 'style']
  })
  // Atajo global para búsqueda: Ctrl/Cmd+K
  document.addEventListener('keydown', handleGlobalShortcut)
});

onUnmounted(() => {
  document.body.style.overflow = ''
  document.removeEventListener('keydown', handleGlobalShortcut)
  if (pollingInterval) {
    clearInterval(pollingInterval)
  }
  if (themeObserver) {
    themeObserver.disconnect()
  }
})
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity .2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

/* Backdrop fade with a more dramatic cubic-bezier */
.overlay-fade-enter-active,
.overlay-fade-leave-active {
  transition: opacity 0.4s cubic-bezier(0.32, 0.72, 0, 1);
}

.overlay-fade-enter-from,
.overlay-fade-leave-to {
  opacity: 0;
}

.tooltip-enter-active,
.tooltip-leave-active {
  transition: all .18s cubic-bezier(0.16, 1, 0.3, 1);
}

.tooltip-enter-from,
.tooltip-leave-to {
  opacity: 0;
  transform: translate(-4px, -50%);
}

.custom-scrollbar::-webkit-scrollbar {
  width: 4px;
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(var(--accent-neon-rgb), 0.1);
  border-radius: 10px;
}

.custom-scrollbar:hover::-webkit-scrollbar-thumb {
  background: rgba(var(--accent-neon-rgb), 0.3);
}

/* Theme transition overlay (center-out effect) */
#theme-transition-overlay {
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: 9999;
  background: #0a0a0f;
  clip-path: circle(0% at 50% 50%);
  will-change: clip-path;
}

/* Smooth fade for menu text when collapsing/expanding */
.menu-text-anim {
  animation: menuTextIn 0.35s cubic-bezier(0.16, 1, 0.3, 1) both;
}

@keyframes menuTextIn {
  from {
    opacity: 0;
    transform: translateX(-4px);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

/* Respect users that prefer reduced motion */
@media (prefers-reduced-motion: reduce) {
  #theme-transition-overlay,
  .menu-text-anim {
    transition: none !important;
    animation: none !important;
  }
}
</style>
