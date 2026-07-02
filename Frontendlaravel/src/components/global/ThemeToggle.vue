<template>
  <button 
    @click="toggleTheme" 
    class="relative w-10 h-10 md:w-12 md:h-12 rounded-full glass-premium flex items-center justify-center transition-all duration-500 hover:scale-110 active:scale-95 group overflow-hidden border border-on-surface/5"
    aria-label="Cambiar tema"
  >
    <!-- Background glow pulse -->
    <div 
      class="absolute inset-0 opacity-0 group-hover:opacity-100 transition-opacity duration-500 pointer-events-none"
      :class="isDark ? 'bg-accent-neon/10' : 'bg-accent-solar/10'"
    ></div>

    <transition name="theme-swap" mode="out-in">
      <span v-if="isDark" key="dark" 
            class="material-symbols-outlined text-xl md:text-2xl text-accent-neon select-none relative z-10 drop-shadow-neon-sm">
        dark_mode
      </span>
      <span v-else key="light" 
            class="material-symbols-outlined text-xl md:text-2xl text-accent-solar select-none relative z-10 drop-shadow-solar-sm">
        light_mode
      </span>
    </transition>

    <!-- Ripple effect on click -->
    <div class="absolute inset-0 bg-white/10 opacity-0 group-active:opacity-100 transition-opacity rounded-full pointer-events-none"></div>
  </button>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const isDark = ref(false)

const checkTheme = () => {
  isDark.value = document.documentElement.classList.contains('dark')
}

const toggleTheme = () => {
  const updateTheme = () => {
    isDark.value = !isDark.value
    if (isDark.value) {
      document.documentElement.classList.add('dark')
      localStorage.setItem('theme', 'dark')
    } else {
      document.documentElement.classList.remove('dark')
      localStorage.setItem('theme', 'light')
    }
  }

  if (document.startViewTransition) {
    document.startViewTransition(updateTheme)
  } else {
    updateTheme()
  }
}

onMounted(() => {
  checkTheme()
})
</script>

<style scoped>
.glass-premium {
  background: var(--glass-bg);
  backdrop-filter: blur(12px) saturate(180%);
}

.theme-swap-enter-active,
.theme-swap-leave-active {
  transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.theme-swap-enter-from {
  opacity: 0;
  transform: rotate(-180deg) scale(0);
}

.theme-swap-leave-to {
  opacity: 0;
  transform: rotate(180deg) scale(0);
}

.drop-shadow-neon-sm {
  filter: drop-shadow(0 0 8px rgba(46, 204, 113, 0.4));
}

.drop-shadow-solar-sm {
  filter: drop-shadow(0 0 8px rgba(243, 156, 18, 0.4));
}
</style>

