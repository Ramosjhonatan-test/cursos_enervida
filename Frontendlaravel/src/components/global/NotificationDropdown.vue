<template>
  <div class="relative" ref="dropdownRef">
    <!-- Trigger Button -->
    <button 
      @click.stop="toggleDropdown" 
      class="relative flex h-10 w-10 items-center justify-center rounded-xl bg-on-surface/5 text-on-surface/45 transition hover:text-accent-neon hover:bg-accent-neon/10"
      aria-label="Notificaciones"
    >
      <span class="material-symbols-outlined text-xl pointer-events-none">notifications</span>
      
      <!-- Unread Badge -->
      <span v-if="unreadCount > 0" class="absolute right-2 top-2 flex h-2 w-2 pointer-events-none">
        <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
        <span class="relative inline-flex rounded-full h-2 w-2 bg-accent-neon"></span>
      </span>
    </button>

    <!-- Dropdown Panel -->
    <transition name="fade-slide">
      <div 
        v-if="isOpen" 
        class="fixed left-4 right-4 top-20 sm:absolute sm:left-auto sm:right-0 sm:top-14 sm:mt-2 w-auto sm:w-96 origin-top sm:origin-top-right overflow-hidden rounded-3xl border border-black/5 dark:border-white/10 bg-white dark:bg-[#121A2A] shadow-[0_30px_60px_rgba(0,0,0,0.15)] dark:shadow-[0_30px_60px_rgba(0,0,0,0.8)] z-[9999]"
      >
        <div class="border-b border-white/5 p-4 flex items-center justify-between bg-white/[0.02]">
          <h3 class="font-lexend font-black text-sm uppercase tracking-widest text-on-surface">Notificaciones</h3>
          <span v-if="unreadCount > 0" class="text-[10px] font-bold text-accent-neon bg-accent-neon/10 px-2 py-0.5 rounded-full">
            {{ unreadCount }} nuevas
          </span>
        </div>

        <div class="max-h-[400px] overflow-y-auto overflow-x-hidden">
          <div v-if="notifications.length === 0" class="p-8 text-center text-on-surface/40">
            <span class="material-symbols-outlined text-4xl mb-2 opacity-50">notifications_paused</span>
            <p class="text-xs font-bold uppercase tracking-widest">No hay notificaciones</p>
          </div>
          
          <div v-else class="divide-y admin-line">
            <div 
              v-for="note in sortedNotifications" 
              :key="note.id" 
              class="group relative flex gap-4 p-4 transition-colors hover:bg-on-surface/[0.02]"
              :class="{ 'bg-accent-neon/[0.03]': !note.leido }"
            >
              <!-- Icon -->
              <div class="shrink-0 mt-1">
                <div :class="['flex h-8 w-8 items-center justify-center rounded-full', !note.leido ? 'bg-accent-neon/10 text-accent-neon' : 'bg-on-surface/10 text-on-surface/40']">
                  <span class="material-symbols-outlined text-[16px]">
                    {{ getIconForNotification(note) }}
                  </span>
                </div>
              </div>
              
              <!-- Content -->
              <div class="flex-1 min-w-0">
                <div class="flex items-start justify-between gap-2 mb-1">
                  <p :class="['text-xs font-black truncate', !note.leido ? 'text-on-surface' : 'text-on-surface/70']">
                    {{ note.titulo }}
                  </p>
                  <span class="text-[9px] font-bold text-on-surface/40 shrink-0 mt-0.5">
                    {{ formatTimeAgo(note.fecha_creacion) }}
                  </span>
                </div>
                <p class="text-[11px] text-on-surface/60 line-clamp-2 leading-relaxed mb-2">
                  {{ note.mensaje }}
                </p>
                
                <!-- Action / Mark as read -->
                <div v-if="!note.leido" class="flex justify-end">
                  <button 
                    @click.stop="markAsRead(note)" 
                    class="text-[9px] font-black uppercase tracking-widest text-accent-neon hover:underline"
                  >
                    Marcar como leído
                  </button>
                </div>
              </div>

              <!-- Unread dot indicator -->
              <div v-if="!note.leido" class="absolute left-0 top-1/2 -translate-y-1/2 w-1 h-8 bg-accent-neon rounded-r-full"></div>
            </div>
          </div>
        </div>
        
        <!-- Footer actions -->
        <div v-if="notifications.length > 0 && unreadCount > 0" class="border-t admin-line p-2 bg-on-surface/[0.02]">
          <button 
            @click="markAllAsRead" 
            class="w-full py-2 text-[10px] font-black uppercase tracking-[0.2em] text-on-surface/50 hover:text-on-surface transition-colors rounded-xl hover:bg-on-surface/5"
          >
            Marcar todas como leídas
          </button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import api from '@/services/api'

const props = defineProps({
  notifications: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['update'])

const isOpen = ref(false)
const dropdownRef = ref(null)

const sortedNotifications = computed(() => {
  return [...props.notifications].sort((a, b) => {
    // First by unread, then by date
    if (a.leido === b.leido) {
      return new Date(b.fecha_creacion) - new Date(a.fecha_creacion)
    }
    return a.leido ? 1 : -1
  })
})

const unreadCount = computed(() => props.notifications.filter(n => !n.leido).length)

const toggleDropdown = () => {
  isOpen.value = !isOpen.value
}

const closeDropdown = (e) => {
  if (dropdownRef.value && !dropdownRef.value.contains(e.target)) {
    isOpen.value = false
  }
}

onMounted(() => {
  document.addEventListener('click', closeDropdown)
})

onUnmounted(() => {
  document.removeEventListener('click', closeDropdown)
})

const formatTimeAgo = (dateStr) => {
  if (!dateStr) return ''
  const date = new Date(dateStr)
  const now = new Date()
  const diffMs = now - date
  const diffMins = Math.floor(diffMs / 60000)
  
  if (diffMins < 1) return 'Ahora'
  if (diffMins < 60) return `Hace ${diffMins} min`
  
  const diffHours = Math.floor(diffMins / 60)
  if (diffHours < 24) return `Hace ${diffHours} h`
  
  const diffDays = Math.floor(diffHours / 24)
  if (diffDays < 7) return `Hace ${diffDays} d`
  
  return date.toLocaleDateString('es-BO', { day: '2-digit', month: 'short' })
}

const getIconForNotification = (note) => {
  const title = String(note.titulo || '').toLowerCase()
  if (title.includes('curso') || title.includes('inscrip')) return 'school'
  if (title.includes('pago') || title.includes('compra')) return 'payments'
  if (title.includes('vivo') || title.includes('clase')) return 'videocam'
  if (title.includes('certificado')) return 'workspace_premium'
  if (title.includes('sistema') || title.includes('admin')) return 'admin_panel_settings'
  return 'campaign'
}

const markAsRead = async (note) => {
  try {
    await api.patch(`/notificaciones/${note.id}`, { leido: true })
    emit('update') // Notify parent to refresh notifications
  } catch (error) {
    console.error('Error al marcar notificación como leída:', error)
  }
}

const markAllAsRead = async () => {
  const unread = props.notifications.filter(n => !n.leido)
  try {
    await Promise.all(unread.map(note => api.patch(`/notificaciones/${note.id}`, { leido: true })))
    emit('update')
    isOpen.value = false
  } catch (error) {
    console.error('Error al marcar todas como leídas:', error)
  }
}
</script>

<style scoped>
.fade-slide-enter-active,
.fade-slide-leave-active {
  transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
}

.fade-slide-enter-from,
.fade-slide-leave-to {
  opacity: 0;
  transform: translateY(-10px) scale(0.98);
}
</style>
