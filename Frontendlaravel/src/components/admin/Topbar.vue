<template>
  <header class="h-20 bg-surface-glass/80 border-b border-white/5 backdrop-blur-xl flex items-center justify-between px-8 sticky top-0 z-30">
    <div class="flex items-center gap-6">
      <button class="md:hidden p-2 rounded-xl bg-on-surface/5 hover:bg-on-surface/10 transition-colors">
        <span class="material-symbols-outlined">menu</span>
      </button>
      <div class="relative hidden sm:block">
        <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface/30 text-lg">search</span>
        <input 
          placeholder="Buscar cursos, lecciones..." 
          class="bg-on-surface/5 border border-white/5 rounded-2xl pl-12 pr-6 py-2.5 w-80 text-sm focus:outline-none focus:bg-on-surface/10 focus:border-accent-neon/30 transition-all" 
        />
      </div>
    </div>

    <div class="flex items-center gap-6">
      <!-- Theme Toggle -->
      <div class="flex items-center gap-2">
        <span class="hidden lg:block text-[10px] font-black uppercase tracking-widest text-on-surface/30">Tema</span>
        <ThemeToggle />
      </div>

      <div class="h-8 w-px bg-white/5 mx-2"></div>

      <!-- User Profile -->
      <div class="flex items-center gap-4">
        <div class="hidden md:flex flex-col items-end">
          <span class="text-xs font-black">{{ userName }}</span>
          <span class="text-[9px] font-bold uppercase tracking-widest text-accent-neon">{{ userRole }}</span>
        </div>
        
        <button class="flex h-11 w-11 items-center justify-center rounded-2xl bg-gradient-to-br from-accent-neon to-primary text-white shadow-neon-sm ring-2 ring-white/10 hover:scale-105 transition-transform">
          <span class="text-sm font-black">{{ userInitials }}</span>
        </button>
      </div>
    </div>
  </header>
</template>

<script setup>
import { computed } from 'vue'
import ThemeToggle from '@/components/global/ThemeToggle.vue'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()

const userName = computed(() => {
  if (!authStore.user) return 'Usuario'
  return `${authStore.user.nombre} ${authStore.user.apellido || ''}`
})

const userRole = computed(() => {
  return authStore.user?.rol?.nombre || 'Estudiante'
})

const userInitials = computed(() => {
  if (!authStore.user) return 'U'
  const n = authStore.user.nombre?.charAt(0) || ''
  const a = authStore.user.apellido?.charAt(0) || ''
  return (n + a).toUpperCase()
})
</script>
