<template>
  <transition name="fade">
    <div v-if="isLoading" class="fixed inset-0 z-[1000] bg-[#020617] flex flex-col items-center justify-center">
      <div class="flex flex-col items-center">
        <!-- Logo prominente -->
        <div class="animate-pulse-slow">
          <img
            src="/logo-light.webp"
            alt="Enervida"
            class="splash-logo object-contain"
          />
        </div>
        <!-- Barra de progreso -->
        <div class="mt-10 flex flex-col items-center">
          <p class="text-white font-lexend font-bold tracking-[0.5em] uppercase text-xs animate-pulse">Cargando Sistema</p>
          <div class="w-48 h-1 bg-white/5 rounded-full mt-4 overflow-hidden">
            <div class="h-full bg-accent-neon animate-progress"></div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script setup>
defineProps({ isLoading: Boolean })
</script>

<style scoped>
.splash-logo {
    height: clamp(4rem, 12vw, 8rem);
    width: auto;
}

.animate-pulse-slow {
    animation: pulse 3s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

@keyframes pulse {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: .85; transform: scale(0.97); }
}

@keyframes progress {
    0% { width: 0%; }
    100% { width: 100%; }
}

.animate-progress {
    animation: progress 2s ease-in-out infinite;
}

.fade-leave-active {
    transition: opacity 0.8s ease;
}

.fade-leave-to {
    opacity: 0;
}
</style>
