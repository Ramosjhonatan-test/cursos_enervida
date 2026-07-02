<script setup>
import { ref, onMounted } from 'vue'
import { RouterView } from 'vue-router'
import LoadingScreen from '@/components/global/LoadingScreen.vue'
import NotificationToast from '@/components/global/NotificationToast.vue'
import ConfirmModal from '@/components/global/ConfirmModal.vue'

const isLoading = ref(true)

// Lógica de Tema
const initTheme = () => {
  const savedTheme = localStorage.getItem('theme')
  // Default to dark; only enable light when the user explicitly chose it.
  if (savedTheme === 'light') {
    document.documentElement.classList.remove('dark')
  } else {
    document.documentElement.classList.add('dark')
    if (!savedTheme) localStorage.setItem('theme', 'dark')
  }
}

onMounted(() => {
  initTheme()
  setTimeout(() => {
    isLoading.value = false
  }, 2500) // Simula tiempo de carga
})
</script>

<template>
  <LoadingScreen :isLoading="isLoading" />

  <div :class="{'opacity-0': isLoading}" class="transition-opacity duration-1000 ease-out flex-1">
    <RouterView />
  </div>

  <!-- Notificaciones Globales (Fuera de RouterView para persistencia) -->
  <NotificationToast />
  <ConfirmModal />
</template>

<style>
/* Transición de Tema Premium */
body {
  background-color: var(--background);
  color: var(--on-surface);
}

#app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* Estilos globales para transiciones de ruta */
.route-enter-active,
.route-leave-active {
  transition: opacity 0.3s ease;
}
.route-enter-from,
.route-leave-to {
  opacity: 0;
}
</style>
