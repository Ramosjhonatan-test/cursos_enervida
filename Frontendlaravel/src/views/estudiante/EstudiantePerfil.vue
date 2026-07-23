<template>
  <div class="space-y-10 animate-in fade-in">
    <EstudiantePageHeader
      eyebrow="Configuracion"
      title="Mi"
      highlight="Perfil"
      description="Reordene esta vista para que editar datos, revisar el estado de la cuenta y leer tus estadisticas sea mas natural en todas las pantallas."
      :stats="headerStats"
    />

    <div class="grid grid-cols-1 gap-8 xl:grid-cols-[minmax(0,1.6fr)_minmax(320px,0.9fr)]">
      <section class="course-card-premium p-6 md:p-10">
        <div class="mb-8 flex items-center justify-between gap-4">
          <div>
            <p class="text-[10px] font-black uppercase tracking-[0.22em] text-accent-neon">Datos personales</p>
            <h2 class="mt-2 font-lexend text-2xl font-black tracking-tight">Informacion de la cuenta</h2>
          </div>
          <span class="rounded-full !border-none bg-accent-neon/10 px-4 py-2 text-[10px] font-black uppercase tracking-[0.22em] text-accent-neon">
            Perfil editable
          </span>
        </div>

        <form @submit.prevent="handleUpdateProfile" class="space-y-8">
          <div class="grid grid-cols-1 gap-6 md:grid-cols-2">
            <div class="space-y-2">
              <label class="px-1 text-[10px] font-black uppercase tracking-widest text-on-surface/40">Nombres</label>
              <input v-model="form.nombres" type="text" required class="input-cyber !rounded-2xl !bg-on-surface/[0.04] !border-none w-full" placeholder="Tus nombres" />
            </div>
            <div class="space-y-2">
              <label class="px-1 text-[10px] font-black uppercase tracking-widest text-on-surface/40">Apellidos</label>
              <input v-model="form.apellidos" type="text" required class="input-cyber !rounded-2xl !bg-on-surface/[0.04] !border-none w-full" placeholder="Tus apellidos" />
            </div>
            <div class="space-y-2">
              <label class="px-1 text-[10px] font-black uppercase tracking-widest text-on-surface/40">Correo electronico</label>
              <input :value="authStore.user?.correo" type="email" readonly class="input-cyber !rounded-2xl !bg-on-surface/[0.04] !border-none w-full cursor-not-allowed opacity-50" />
            </div>
            <div class="space-y-2">
              <label class="px-1 text-[10px] font-black uppercase tracking-widest text-on-surface/40">Cedula / DNI</label>
              <input v-model="form.ci" type="text" required class="input-cyber !rounded-2xl !bg-on-surface/[0.04] !border-none w-full" placeholder="Documento de identidad" />
            </div>
            <div class="space-y-2">
              <label class="px-1 text-[10px] font-black uppercase tracking-widest text-on-surface/40">WhatsApp / Telefono</label>
              <input v-model="form.telefono" type="text" required class="input-cyber !rounded-2xl !bg-on-surface/[0.04] !border-none w-full" placeholder="+591 ..." />
            </div>
            <div class="space-y-2">
              <label class="px-1 text-[10px] font-black uppercase tracking-widest text-on-surface/40">Nueva contrasena</label>
              <div class="relative">
                <input v-model="form.contrasena" :type="showPassword ? 'text' : 'password'" class="input-cyber !rounded-2xl !bg-on-surface/[0.04] !border-none w-full pr-14" placeholder="Dejar en blanco para mantener" />
                <button type="button" @click="showPassword = !showPassword" class="absolute right-4 top-1/2 -translate-y-1/2 text-on-surface/30 hover:text-accent-neon">
                  <span class="material-symbols-outlined text-xl">{{ showPassword ? 'visibility_off' : 'visibility' }}</span>
                </button>
              </div>
            </div>
          </div>

          <div class="flex flex-col gap-3 pt-2 sm:flex-row">
            <button type="submit" :disabled="saving" class="btn-premium btn-primary-neon !w-full sm:!w-auto !px-12 !py-5 relative overflow-hidden">
              <div v-if="saving" class="shimmer-effect"></div>
              <span v-if="!saving" class="material-symbols-outlined text-sm">save</span>
              <div v-else class="animate-spin rounded-full h-4 w-4 border-t-2 border-primary"></div>
              {{ saving ? 'Guardando...' : 'Guardar perfil' }}
            </button>
            <router-link to="/student/certificates" class="btn-premium glass-card !bg-on-surface/[0.05] !border-none !w-full sm:!w-auto !px-8 !py-5">
              Ver historial
            </router-link>
          </div>
        </form>
      </section>

      <aside class="space-y-8">
        <section class="course-card-premium overflow-hidden p-8 text-center">
          <div class="relative mx-auto mb-6 h-32 w-32">
            <div class="flex h-full w-full items-center justify-center rounded-[40px] !border-none bg-accent-neon/5 text-4xl font-black text-accent-neon shadow-inner">
              <img
                v-if="profileImageUrl && !profileImageFailed"
                :src="profileImageUrl"
                class="h-full w-full rounded-[38px] object-cover"
                @error="profileImageFailed = true"
              />
              <span v-else>{{ userInitials }}</span>
            </div>
            <button class="absolute -bottom-2 -right-2 flex h-10 w-10 items-center justify-center rounded-2xl bg-accent-neon text-primary shadow-neon-sm transition hover:scale-110">
              <span class="material-symbols-outlined text-xl">photo_camera</span>
            </button>
          </div>

          <h2 class="text-xl font-black">{{ authStore.user?.nombres }} {{ authStore.user?.apellidos }}</h2>
          <p class="mt-1 text-[10px] font-black uppercase tracking-widest text-on-surface/35">Estudiante verificado</p>

          <div class="mt-8 grid grid-cols-2 gap-4 pt-8">
            <div class="rounded-2xl !border-none bg-on-surface/[0.03] p-4 text-center">
              <p class="text-2xl font-black text-accent-neon">{{ stats.completedCourses }}</p>
              <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Cursos</p>
            </div>
            <div class="rounded-2xl !border-none bg-on-surface/[0.03] p-4 text-center">
              <p class="text-2xl font-black text-accent-neon">{{ stats.certificates }}</p>
              <p class="text-[9px] font-black uppercase tracking-widest text-on-surface/30">Certificados </p>
            </div>
          </div>
        </section>

        <section class="course-card-premium p-8">
          <h3 class="mb-6 flex items-center gap-3 text-[10px] font-black uppercase tracking-widest text-on-surface/40">
            <span class="material-symbols-outlined text-accent-neon">security</span>
            Seguridad de cuenta
          </h3>
          
          <div v-if="activeDevice" class="mb-6 p-4 rounded-2xl bg-accent-neon/5 !border-none animate-in slide-in-from-bottom-2">
            <div class="flex items-center gap-4">
              <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-accent-neon/10 text-accent-neon">
                <span class="material-symbols-outlined text-2xl">{{ getDeviceIcon(activeDevice.sistema_operativo) }}</span>
              </div>
              <div class="flex-1">
                <p class="text-xs font-black text-on-surface">Equipo Vinculado</p>
                <p class="text-[10px] font-bold text-on-surface/60 uppercase">{{ activeDevice.sistema_operativo }} • {{ activeDevice.navegador }}</p>
              </div>
            </div>
            <div class="mt-4 pt-4 space-y-2">
              <div class="flex justify-between items-center text-[10px] font-black uppercase tracking-widest text-on-surface/40">
                <span>Último acceso</span>
                <span class="text-on-surface/60">{{ activeDevice.ultimo_acceso ? new Date(activeDevice.ultimo_acceso).toLocaleDateString() : 'Nunca' }}</span>
              </div>
              <div class="flex justify-between items-center text-[10px] font-black uppercase tracking-widest text-on-surface/40">
                <span>Dirección IP</span>
                <span class="text-on-surface/60 font-mono">{{ activeDevice.direccion_ip }}</span>
              </div>
            </div>
          </div>

          <ul class="space-y-4">
            <li class="flex items-center gap-4 text-sm font-bold text-on-surface/60">
              <span class="material-symbols-outlined text-green-500">check_circle</span>
              Verificacion activa del correo
            </li>
            <li class="flex items-center gap-4 text-sm font-bold text-on-surface/60">
              <span class="material-symbols-outlined text-accent-neon animate-pulse">verified_user</span>
              Protección de huella digital activa
            </li>
          </ul>

          <div class="mt-8 p-4 rounded-xl bg-accent-neon/5 text-[10px] font-bold text-on-surface/40 leading-relaxed !border-none">
            * Su cuenta está vinculada a este equipo para mayor seguridad. Si necesita cambiar de dispositivo, contacte a soporte técnico para "Liberar" su cuenta.
          </div>
        </section>
      </aside>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import api from '@/services/api'
import { getFileUrl } from '@/config'
import { useNotificationStore } from '@/stores/notificationStore'
import EstudiantePageHeader from '@/components/estudiante/EstudiantePageHeader.vue'

const authStore = useAuthStore()
const notificationStore = useNotificationStore()
const saving = ref(false)
const showPassword = ref(false)
const profileImageFailed = ref(false)
const fullUser = ref(null)

const activeDevice = computed(() => {
  return fullUser.value?.dispositivos?.find(d => d.activo)
})

const getDeviceIcon = (os) => {
  const osLower = os?.toLowerCase() || ''
  if (osLower.includes('windows')) return 'desktop_windows'
  if (osLower.includes('android')) return 'phone_android'
  if (osLower.includes('ios') || osLower.includes('iphone') || osLower.includes('ipad')) return 'phone_iphone'
  if (osLower.includes('mac')) return 'desktop_mac'
  if (osLower.includes('linux')) return 'terminal'
  return 'devices'
}

const form = ref({
  nombres: authStore.user?.nombres || '',
  apellidos: authStore.user?.apellidos || '',
  ci: authStore.user?.ci || '',
  telefono: authStore.user?.telefono || '',
  contrasena: '',
})

const stats = ref({
  completedCourses: 0,
  certificates: 0,
})

const userInitials = computed(() => {
  const n = authStore.user?.nombres || ''
  const a = authStore.user?.apellidos || ''
  return `${n.charAt(0)}${a.charAt(0)}`.toUpperCase() || 'ES'
})

const profileImageUrl = computed(() => {
  const url = authStore.user?.imagen_perfil || authStore.user?.foto
  return getFileUrl(url)
})

const headerStats = computed(() => [
  {
    label: 'Cursos completos',
    value: stats.value.completedCourses,  
    help: 'Rutas finalizadas por este usuario',
    icon: 'task_alt',
  },
  {
    label: 'Certificados',
    value: stats.value.certificates,
    help: 'Documentos emitidos disponibles',
    icon: 'workspace_premium',
  },
])

onMounted(async () => {
  try {
    const [insResponse, certResponse, profileResponse] = await Promise.all([
      api.get('/inscripciones/me'),
      api.get('/certificados/me'),
      api.get('/usuarios/profile'),
    ])
    stats.value.completedCourses = insResponse.data.filter((item) => Number(item.porcentaje_progreso || 0) >= 100).length
    stats.value.certificates = certResponse.data.length
    fullUser.value = profileResponse.data
  } catch (error) {
    console.warn('Error loading stats or profile:', error)
  }
})

async function handleUpdateProfile() {
  saving.value = true
  try {
    const data = { ...form.value }
    if (!data.contrasena) delete data.contrasena

    const response = await api.patch('/usuarios/profile', data)

    await authStore.updateUser(response.data)
    notificationStore.addNotification({
      title: 'Perfil Actualizado',
      message: 'Tus datos se han guardado correctamente.',
      type: 'success'
    })
    form.value.contrasena = ''
  } catch (error) {
    console.error('Error updating profile:', error)
    notificationStore.addNotification({
      title: 'Error al Guardar',
      message: 'No se pudo actualizar tu información de perfil.',
      type: 'error'
    })
  } finally {
    saving.value = false
  }
}
</script>
