<template>
  <div class="fixed top-8 left-1/2 -translate-x-1/2 z-[2000] flex flex-col gap-4 pointer-events-none w-full max-w-[440px] px-4">
    <TransitionGroup 
      name="notification"
    >
      <div 
        v-for="notification in store.notifications" 
        :key="notification.id"
        class="pointer-events-auto relative overflow-hidden rounded-[2rem] glass-premium border border-white/10 shadow-[0_20px_50px_rgba(0,0,0,0.3)] flex items-center p-3 pr-6 gap-4"
        :class="[
          notification.type === 'success' ? 'glow-neon' : 
          notification.type === 'error' ? 'glow-error' : 
          'glow-solar'
        ]"
      >
        <!-- Background subtle color wash -->
        <div class="absolute inset-0 opacity-[0.05]"
             :class="notification.type === 'success' ? 'bg-accent-neon' : notification.type === 'error' ? 'bg-red-500' : 'bg-accent-solar'"></div>

        <!-- Icon container with ring -->
        <div 
          class="w-12 h-12 rounded-full flex items-center justify-center shrink-0 relative"
          :class="[
            notification.type === 'success' ? 'bg-accent-neon/20 text-accent-neon' : 
            notification.type === 'error' ? 'bg-red-500/20 text-red-400' : 
            'bg-accent-solar/20 text-accent-solar'
          ]"
        >
          <div class="absolute inset-0 rounded-full border-2 border-current opacity-20 animate-ping-slow"></div>
          <span class="material-symbols-outlined text-2xl relative z-10">
            {{ getIcon(notification.type) }}
          </span>
        </div>

        <!-- Content -->
        <div class="flex-1 min-w-0">
          <h4 class="text-[13px] font-black tracking-tight text-on-surface uppercase leading-none mb-1">
            {{ notification.title }}
          </h4>
          <p class="text-[12px] text-on-surface-variant font-semibold truncate opacity-80">
            {{ notification.message }}
          </p>
        </div>

        <!-- Progress ring (mini) -->
        <div class="relative w-8 h-8 shrink-0 flex items-center justify-center">
           <button 
            @click="store.removeNotification(notification.id)"
            class="p-1 rounded-full hover:bg-white/10 text-on-surface-variant hover:text-on-surface transition-colors shrink-0"
          >
            <span class="material-symbols-outlined text-lg">close</span>
          </button>
        </div>

        <!-- Animated line at the bottom -->
        <div 
          class="absolute bottom-0 left-0 h-[3px] transition-all duration-linear"
          :class="notification.type === 'success' ? 'bg-accent-neon' : notification.type === 'error' ? 'bg-red-500' : 'bg-accent-solar'"
          :style="{ width: progressWidths[notification.id] + '%' }"
        ></div>
      </div>
    </TransitionGroup>
  </div>
</template>

<script setup>
import { useNotificationStore } from '@/stores/notificationStore'
import { ref, watch, onMounted } from 'vue'

const store = useNotificationStore()
const progressWidths = ref({})

// Lógica de progreso para cada notificación
watch(() => store.notifications, (newNotifs) => {
  newNotifs.forEach(n => {
    if (progressWidths.value[n.id] === undefined) {
      progressWidths.value[n.id] = 100
      const duration = 5000 // Coincide con el store
      const step = 100 / (duration / 16) // ~60fps
      
      const interval = setInterval(() => {
        if (progressWidths.value[n.id] > 0) {
          progressWidths.value[n.id] -= step
        } else {
          clearInterval(interval)
          delete progressWidths.value[n.id]
        }
      }, 16)
    }
  })
}, { deep: true })

const getIcon = (type) => {
  switch (type) {
    case 'success': return 'verified'
    case 'error': return 'dangerous'
    case 'warning': return 'warning'
    default: return 'notifications'
  }
}

onMounted(() => {
  console.log('NotificationToast montado en modo global')
})
</script>

<style scoped>
.notification-enter-active {
  animation: dynamic-island-in 0.7s cubic-bezier(0.19, 1, 0.22, 1);
}

.notification-leave-active {
  animation: dynamic-island-out 0.5s cubic-bezier(0.19, 1, 0.22, 1) forwards;
}

@keyframes dynamic-island-in {
  0% {
    opacity: 0;
    transform: translateY(-40px) scale(0.9);
    filter: blur(10px);
  }
  100% {
    opacity: 1;
    transform: translateY(0) scale(1);
    filter: blur(0);
  }
}

@keyframes dynamic-island-out {
  0% {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
  100% {
    opacity: 0;
    transform: translateY(-20px) scale(0.9);
    filter: blur(5px);
  }
}

.glass-premium {
  background: rgba(255, 255, 255, 0.05);
  backdrop-filter: blur(30px) saturate(150%);
}

.dark .glass-premium {
  background: rgba(10, 15, 25, 0.85);
}

.glow-neon { box-shadow: 0 10px 40px -10px rgba(46, 204, 113, 0.3), inset 0 0 0 1px rgba(46, 204, 113, 0.1); }
.glow-error { box-shadow: 0 10px 40px -10px rgba(239, 68, 68, 0.3), inset 0 0 0 1px rgba(239, 68, 68, 0.1); }
.glow-solar { box-shadow: 0 10px 40px -10px rgba(234, 179, 8, 0.3), inset 0 0 0 1px rgba(234, 179, 8, 0.1); }

.animate-ping-slow {
  animation: ping 3s cubic-bezier(0, 0, 0.2, 1) infinite;
}

@keyframes ping {
  75%, 100% {
    transform: scale(1.5);
    opacity: 0;
  }
}
</style>

