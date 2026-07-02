<template>
  <div class="space-y-10 animate-fade-in text-on-surface">
    <!-- Header -->
    <div class="panel-hero p-6 sm:p-8 relative overflow-hidden group">
      <div class="absolute inset-0 bg-gradient-to-r from-accent-neon/5 to-transparent opacity-50"></div>
      <div class="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-6">
        <div>
          <div class="flex items-center gap-3 mb-2">
            <div class="w-8 h-8 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
              <span class="material-symbols-outlined text-sm">notifications_active</span>
            </div>
            <span class="text-[10px] font-black text-accent-neon uppercase tracking-[0.3em]">Comunicaciones</span>
          </div>
          <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">Centro de <span class="text-accent-neon italic">Notificaciones</span></h2>
          <p class="text-on-surface/40 mt-1 text-xs font-bold uppercase tracking-widest">Envía anuncios y mensajes directos a los usuarios</p>
        </div>
        <button @click="openModal()" class="btn-premium btn-accent-neon !py-4 gap-2">
          <span class="material-symbols-outlined text-sm">send</span>
          Nueva Notificación
        </button>
      </div>
    </div>

    <div class="grid grid-cols-1 xl:grid-cols-[1fr_350px] gap-8">
      <!-- History Table -->
      <div class="glass-card-premium rounded-[40px] overflow-hidden shadow-2xl relative min-h-[500px]">
        <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
          <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
          <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando historial...</p>
        </div>

        <div class="overflow-x-auto">
          <table class="w-full min-w-[700px] text-left border-separate border-spacing-0">
            <thead>
              <tr class="bg-on-surface/[0.03]">
                <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Usuario</th>
                <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Mensaje</th>
                <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Fecha</th>
                <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-center">Estado</th>
                <th class="p-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-right">Acciones</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="note in notifications" :key="note.id" class="group hover:bg-on-surface/[0.03] transition-colors">
                <td class="p-6">
                  <div class="flex items-center gap-3">
                    <div class="w-8 h-8 rounded-lg bg-on-surface/5 flex items-center justify-center text-on-surface/40 font-black text-[10px]">
                      {{ note.usuario?.nombres?.[0] || '?' }}
                    </div>
                    <span class="text-xs font-bold text-on-surface">{{ note.usuario?.nombres }}</span>
                  </div>
                </td>
                <td class="p-6">
                  <p class="text-xs font-black text-on-surface mb-1">{{ note.titulo }}</p>
                  <p class="text-[10px] text-on-surface/60 line-clamp-2 max-w-[300px]">{{ note.mensaje }}</p>
                </td>
                <td class="p-6">
                  <p class="text-[10px] font-bold text-on-surface/40 uppercase">{{ formatDate(note.fecha_creacion) }}</p>
                </td>
                <td class="p-6 text-center">
                  <span :class="['px-2 py-0.5 text-[8px] font-black rounded-full uppercase tracking-tighter', note.leido ? 'bg-green-500/10 text-green-500' : 'bg-orange-500/10 text-orange-500']">
                    {{ note.leido ? 'Leído' : 'Pendiente' }}
                  </span>
                </td>
                <td class="p-6 text-right">
                  <button @click="deleteNotification(note.id)" class="w-8 h-8 rounded-lg bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:bg-red-500/10 hover:text-red-500 transition-all">
                    <span class="material-symbols-outlined text-sm">delete</span>
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Quick Stats / Actions -->
      <div class="space-y-6">
        <div class="glass-card-premium p-6 rounded-[32px]">
          <h4 class="text-[10px] font-black uppercase tracking-[0.2em] text-on-surface/40 mb-4">Resumen</h4>
          <div class="space-y-4">
            <div class="flex items-center justify-between">
              <span class="text-xs font-bold text-on-surface/60">Total enviadas</span>
              <span class="text-lg font-black text-on-surface">{{ notifications.length }}</span>
            </div>
            <div class="flex items-center justify-between">
              <span class="text-xs font-bold text-on-surface/60">Leídas</span>
              <span class="text-lg font-black text-green-500">{{ notifications.filter(n => n.leido).length }}</span>
            </div>
            <div class="flex items-center justify-between">
              <span class="text-xs font-bold text-on-surface/60">Sin leer</span>
              <span class="text-lg font-black text-orange-500">{{ notifications.filter(n => !n.leido).length }}</span>
            </div>
          </div>
        </div>

        <div class="glass-card-premium p-6 rounded-[32px] bg-accent-neon/5">
          <span class="material-symbols-outlined text-accent-neon mb-3">campaign</span>
          <h4 class="text-sm font-black text-on-surface mb-2">Anuncio Global</h4>
          <p class="text-[10px] text-on-surface/60 mb-4 leading-relaxed">Envía una notificación a todos los usuarios registrados en la plataforma simultáneamente.</p>
          <button @click="openModal(true)" class="w-full btn-premium btn-accent-neon !py-3 text-[10px]">Difusión Masiva</button>
        </div>
      </div>
    </div>

    <!-- Modal Form -->
    <div v-if="showModal" class="fixed inset-0 z-[150] flex items-center justify-center p-4">
      <div class="absolute inset-0 bg-background/80 backdrop-blur-xl" @click="showModal = false"></div>
      <div class="relative w-full max-w-lg bg-surface rounded-[40px] p-8 shadow-2xl animate-in zoom-in-95 duration-200">
        <h3 class="text-2xl font-black font-lexend mb-6">Enviar <span class="text-accent-neon italic">{{ isGlobal ? 'Anuncio Global' : 'Notificación' }}</span></h3>
        
        <form @submit.prevent="sendNotification" class="space-y-6">
          <div v-if="!isGlobal" class="space-y-2">
            <label class="text-[10px] font-black uppercase tracking-widest text-on-surface/40">Destinatario</label>
            <select v-model="form.usuario_id" required class="w-full bg-on-surface/[0.03] rounded-2xl py-4 px-6 text-sm font-bold focus:outline-none focus:border-accent-neon/40 transition-all">
              <option value="" disabled>Seleccione un usuario</option>
              <option v-for="u in users" :key="u.id" :value="u.id">{{ u.nombres }} {{ u.apellidos }} ({{ u.correo }})</option>
            </select>
          </div>

          <div class="space-y-2">
            <label class="text-[10px] font-black uppercase tracking-widest text-on-surface/40">Título del Mensaje</label>
            <input v-model="form.titulo" type="text" placeholder="Ej: Actualización de sistema" required class="w-full bg-on-surface/[0.03] rounded-2xl py-4 px-6 text-sm font-bold focus:outline-none focus:border-accent-neon/40 transition-all" />
          </div>

          <div class="space-y-2">
            <label class="text-[10px] font-black uppercase tracking-widest text-on-surface/40">Contenido</label>
            <textarea v-model="form.mensaje" rows="4" placeholder="Escribe el mensaje aquí..." required class="w-full bg-on-surface/[0.03] rounded-2xl py-4 px-6 text-sm font-bold focus:outline-none focus:border-accent-neon/40 transition-all resize-none"></textarea>
          </div>

          <div class="pt-4 flex gap-3">
            <button type="button" @click="showModal = false" class="flex-1 btn-premium btn-secondary-glass !py-4">Cancelar</button>
            <button type="submit" :disabled="sending" class="flex-2 btn-premium btn-accent-neon !py-4 gap-2">
              <span v-if="sending" class="animate-spin material-symbols-outlined text-sm">refresh</span>
              {{ isGlobal ? 'Difundir a todos' : 'Enviar Mensaje' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'

const notificationStore = useNotificationStore()
const modalStore = useModalStore()

const notifications = ref([])
const users = ref([])
const loading = ref(true)
const sending = ref(false)
const showModal = ref(false)
const isGlobal = ref(false)

const form = ref({
  usuario_id: '',
  titulo: '',
  mensaje: ''
})

const fetchData = async () => {
  loading.value = true
  try {
    const [resNote, resUsers] = await Promise.all([
      api.get('/notificaciones'),
      api.get('/usuarios')
    ])
    notifications.value = resNote.data.sort((a, b) => new Date(b.fecha_creacion) - new Date(a.fecha_creacion))
    users.value = resUsers.data
  } catch (error) {
    console.error('Error fetching data:', error)
  } finally {
    loading.value = false
  }
}

const openModal = (global = false) => {
  isGlobal.value = global
  form.value = { usuario_id: '', titulo: '', mensaje: '' }
  showModal.value = true
}

const sendNotification = async () => {
  sending.value = true
  try {
    if (isGlobal.value) {
      // Simulación de envío global iterando si el backend no tiene endpoint masivo
      const promises = users.value.map(u => 
        api.post('/notificaciones', {
          usuario_id: u.id,
          titulo: form.value.titulo,
          mensaje: form.value.mensaje
        })
      )
      await Promise.all(promises)
    } else {
      await api.post('/notificaciones', form.value)
    }
    await fetchData()
    notificationStore.addNotification({
      title: isGlobal.value ? 'Anuncio Difundido' : 'Mensaje Enviado',
      message: 'La notificación ha sido procesada correctamente.',
      type: 'success'
    })
    showModal.value = false
  } catch (error) {
    console.error('Error sending:', error)
    notificationStore.addNotification({
      title: 'Error de Envío',
      message: 'No se pudo completar la operación de notificación.',
      type: 'error'
    })
  } finally {
    sending.value = false
  }
}

const deleteNotification = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Notificación?',
    message: 'Esta entrada se borrará del historial permanentemente.',
    confirmText: 'Borrar',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/notificaciones/${id}`)
        notifications.value = notifications.value.filter(n => n.id !== id)
        notificationStore.addNotification({
          title: 'Registro Borrado',
          message: 'El historial ha sido actualizado.',
          type: 'success'
        })
      } catch (error) {
        console.error('Error deleting:', error)
        notificationStore.addNotification({
          title: 'Error al Borrar',
          message: 'No se pudo eliminar el registro.',
          type: 'error'
        })
      }
    }
  })
}

const formatDate = (date) => new Date(date).toLocaleString()

onMounted(fetchData)
</script>
