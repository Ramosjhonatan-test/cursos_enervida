<template>
  <Transition name="modal">
    <div v-if="store.isOpen" class="fixed inset-0 z-[3000] flex items-center justify-center p-4 md:p-6">
      <!-- Backdrop -->
      <div class="absolute inset-0 bg-background/60 backdrop-blur-md" @click="store.cancel"></div>
      
      <!-- Modal Card -->
      <div class="glass-card-premium relative w-full max-w-md overflow-hidden rounded-[3rem] border-white/10 p-8 shadow-2xl md:p-10 animate-in zoom-in duration-300">
        <!-- Decoration light -->
        <div class="absolute -top-20 -right-20 w-40 h-40 rounded-full blur-[80px] opacity-20"
             :class="typeColorClass"></div>

        <div class="relative z-10 text-center">
          <!-- Icon -->
          <div class="mx-auto mb-6 flex h-20 w-20 items-center justify-center rounded-3xl border animate-bounce-slow"
               :class="iconBorderClass">
            <span class="material-symbols-outlined text-4xl" :class="iconTextClass">
              {{ iconName }}
            </span>
          </div>

          <h3 class="font-lexend text-2xl font-black tracking-tight text-on-surface mb-3">
            {{ store.options.title }}
          </h3>
          
          <p class="text-sm font-medium text-on-surface-variant leading-relaxed mb-10 opacity-80">
            {{ store.options.message }}
          </p>

          <div class="flex flex-col sm:flex-row gap-3">
            <button 
              @click="store.cancel"
              class="btn-premium btn-secondary-glass flex-1 !py-4"
            >
              {{ store.options.cancelText }}
            </button>
            <button 
              @click="store.confirm"
              class="btn-premium flex-1 !py-4 shadow-lg transition-transform hover:scale-105 active:scale-95"
              :class="confirmButtonClass"
            >
              {{ store.options.confirmText }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script setup>
import { useModalStore } from '@/stores/modalStore'
import { computed } from 'vue'

const store = useModalStore()

const typeColorClass = computed(() => {
  switch (store.options.type) {
    case 'danger': return 'bg-red-500'
    case 'success': return 'bg-accent-neon'
    case 'info': return 'bg-blue-500'
    default: return 'bg-accent-solar'
  }
})

const iconBorderClass = computed(() => {
  switch (store.options.type) {
    case 'danger': return 'border-red-500/20 bg-red-500/10'
    case 'success': return 'border-accent-neon/20 bg-accent-neon/10'
    case 'info': return 'border-blue-500/20 bg-blue-500/10'
    default: return 'border-accent-solar/20 bg-accent-solar/10'
  }
})

const iconTextClass = computed(() => {
  switch (store.options.type) {
    case 'danger': return 'text-red-500'
    case 'success': return 'text-accent-neon'
    case 'info': return 'text-blue-500'
    default: return 'text-accent-solar'
  }
})

const iconName = computed(() => {
  switch (store.options.type) {
    case 'danger': return 'delete_forever'
    case 'success': return 'check_circle'
    case 'info': return 'info'
    default: return 'warning'
  }
})

const confirmButtonClass = computed(() => {
  switch (store.options.type) {
    case 'danger': return 'bg-red-500 text-white'
    case 'success': return 'btn-primary-neon'
    case 'info': return 'bg-blue-600 text-white'
    default: return 'btn-primary-solar'
  }
})
</script>

<style scoped>
.modal-enter-active {
  transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.modal-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}
.modal-enter-from,
.modal-leave-to {
  opacity: 0;
  transform: scale(0.9);
}

.animate-bounce-slow {
  animation: bounce-slow 3s ease-in-out infinite;
}

@keyframes bounce-slow {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.glass-card-premium {
    background: var(--surface-card);
    backdrop-filter: blur(40px) saturate(180%);
    border: 1px solid var(--glass-border);
    box-shadow: 0 40px 100px -20px rgba(0, 0, 0, 0.5);
}
</style>
