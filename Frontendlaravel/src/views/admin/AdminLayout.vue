<template>
  <div class="admin-surface min-h-screen text-on-surface font-inter">
    <transition name="fade">
      <div v-if="isMenuOpen" class="fixed inset-0 z-[70] bg-black/55 backdrop-blur-sm lg:hidden" @click="isMenuOpen = false"></div>
    </transition>

    <aside
      :class="[
        'fixed left-0 top-0 z-[80] flex h-full flex-col glass-card transition-all duration-300',
        isSidebarCollapsed ? 'lg:w-24' : 'lg:w-72',
        isMenuOpen ? 'translate-x-0 w-80' : '-translate-x-full lg:translate-x-0 w-80'
      ]"
    >
      <div class="flex h-20 items-center gap-3 px-5">
        <div v-if="isSidebarCollapsed && !isMenuOpen" class="grid h-11 w-11 shrink-0 place-items-center">
          <img src="/logo-icon.webp" alt="Enervida Icon" style="height: clamp(2rem, 4vw, 2.75rem);" class="w-auto object-contain transition-all duration-300" />
        </div>
        <div v-else class="min-w-0">
          <AppLogo :img-style="{ height: 'clamp(2.25rem, 5vw, 3rem)' }" img-class="w-auto object-contain" />
          <p class="text-[10px] font-black uppercase tracking-[0.26em] text-on-surface-variant mt-1">Campus admin</p>
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

      <nav class="flex-1 space-y-6 px-3 py-4 overflow-y-auto custom-scrollbar">
        <div v-for="category in filteredLinks" :key="category.title" class="space-y-2">
          <p v-if="!isSidebarCollapsed || isMenuOpen" class="px-4 text-[10px] font-black uppercase tracking-[0.2em] text-on-surface-variant/50">
            {{ category.title }}
          </p>
          <div class="space-y-1">
            <router-link
              v-for="link in category.links"
              :key="link.text"
              :to="link.path"
              :title="isSidebarCollapsed && !isMenuOpen ? link.text : ''"
              :class="[
                'group flex items-center rounded-2xl py-2.5 text-sm font-bold transition-all relative',
                isActive(link.path) ? 'bg-accent-neon text-primary shadow-neon-sm' : 'admin-soft-hover text-on-surface-variant hover:text-on-surface',
                isSidebarCollapsed && !isMenuOpen ? 'justify-center px-0' : 'gap-3 px-4'
              ]"
              @click="isMenuOpen = false"
            >
              <span v-if="link.icon" class="material-symbols-outlined text-[20px] relative">
                {{ link.icon }}
                <span v-if="isSidebarCollapsed && !isMenuOpen && link.text === 'Solicitudes' && solicitudStore.pendingCount > 0" class="absolute -top-1.5 -right-1.5 flex h-2.5 w-2.5">
                  <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-orange-400 opacity-75"></span>
                  <span class="relative inline-flex rounded-full h-2.5 w-2.5 bg-orange-500"></span>
                </span>
              </span>
              <span v-else-if="link.svg" v-html="link.svg" class="w-5 h-5 flex items-center justify-center relative">
              </span>
              <span v-if="!isSidebarCollapsed || isMenuOpen" class="truncate flex-1">{{ link.text }}</span>
              <div v-if="(!isSidebarCollapsed || isMenuOpen) && link.text === 'Solicitudes' && solicitudStore.pendingCount > 0" class="relative ml-auto flex h-5 items-center justify-center">
                <span class="absolute inline-flex h-full w-full animate-ping rounded-full bg-orange-500/40 opacity-75"></span>
                <span class="relative flex h-5 min-w-[20px] items-center justify-center rounded-full bg-orange-500 px-1.5 text-[10px] font-black uppercase tracking-wider text-white shadow-[0_2px_8px_rgba(249,115,22,0.4)] dark:shadow-[0_0_12px_rgba(249,115,22,0.4)] transition-all duration-300">
                {{ solicitudStore.pendingCount }}
                </span>
              </div>
            </router-link>
          </div>
        </div>
      </nav>

      <div class="p-3">
        <button
          type="button"
          :class="[
            'flex w-full items-center rounded-2xl py-3 text-sm font-bold text-on-surface-variant transition-all hover:bg-red-500/10 hover:text-red-500',
            isSidebarCollapsed && !isMenuOpen ? 'justify-center px-0' : 'gap-3 px-4'
          ]"
          @click="handleLogout"
        >
          <span class="material-symbols-outlined text-[22px]">logout</span>
          <span v-if="!isSidebarCollapsed || isMenuOpen">Cerrar sesion</span>
        </button>
      </div>
    </aside>

    <header
      :class="[
        'fixed right-0 top-0 z-50 flex h-20 items-center justify-between bg-surface-glass px-4 backdrop-blur-xl transition-all duration-300 md:px-8',
        isSidebarCollapsed ? 'lg:left-24' : 'lg:left-72',
        'left-0'
      ]"
    >
      <div class="flex min-w-0 items-center gap-3">
        <button
          type="button"
          class="admin-soft-hover grid h-11 w-11 place-items-center rounded-2xl text-on-surface lg:hidden"
          @click="isMenuOpen = true"
          aria-label="Abrir menu"
        >
          <span class="material-symbols-outlined">menu</span>
        </button>
        <button
          type="button"
          class="admin-soft-hover hidden h-11 w-11 place-items-center rounded-2xl text-on-surface-variant transition hover:text-on-surface lg:grid"
          @click="isSidebarCollapsed = !isSidebarCollapsed"
          aria-label="Colapsar menu"
        >
          <span class="material-symbols-outlined">{{ isSidebarCollapsed ? 'keyboard_double_arrow_right' : 'keyboard_double_arrow_left' }}</span>
        </button>
        <div class="min-w-0 hidden sm:block">
          <p class="text-[10px] font-black uppercase tracking-[0.24em] text-accent-neon">Panel administrativo</p>
          <h1 class="truncate font-lexend text-lg font-black tracking-tight md:text-xl lg:text-2xl">{{ currentSection }}</h1>
        </div>
      </div>

      <div class="flex flex-1 items-center justify-end gap-3 md:gap-4 lg:ml-8">
        <!-- Global Search -->
        <div class="relative flex-1 max-w-md group hidden md:block">
          <span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-on-surface/30 text-[20px] group-focus-within:text-accent-neon transition-colors">search</span>
          <input 
            type="text" 
            placeholder="Búsqueda global..." 
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
          <div class="grid h-10 w-10 shrink-0 place-items-center rounded-xl bg-gradient-to-br from-accent-neon to-accent-solar p-[2px]">
            <div class="grid h-full w-full place-items-center rounded-[10px] bg-background text-xs font-black shadow-inner">
              {{ authStore.user?.nombres?.charAt(0) }}{{ authStore.user?.apellidos?.charAt(0) }}
            </div>
          </div>
        </div>
      </div>
    </header>

    <main :class="['min-h-screen px-4 pb-12 pt-28 transition-all duration-300 md:px-8 xl:px-10', isSidebarCollapsed ? 'lg:ml-24' : 'lg:ml-72']">
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

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()

const isMenuOpen = ref(false)
const isSidebarCollapsed = ref(false)

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
      { text: 'Verificación QR', icon: 'qr_code_scanner', path: '/admin/verificacion-qr', moduleId: 'CERTIFICADOS' },
    ]
  }
]

const filteredLinks = computed(() => {
  return categorizedLinks.map(category => ({
    ...category,
    links: category.links.filter(link => authStore.canAccess(link.moduleId))
  })).filter(category => category.links.length > 0);
});

const isActive = (path) => {
  if (path === '/admin') return route.path === '/admin'
  return route.path.startsWith(path)
}

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
});

onUnmounted(() => {
  document.body.style.overflow = ''
  if (pollingInterval) {
    clearInterval(pollingInterval)
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
</style>
