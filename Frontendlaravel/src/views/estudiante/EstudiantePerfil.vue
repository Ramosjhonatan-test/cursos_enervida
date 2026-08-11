<template>
  <div class="relative min-h-screen transition-colors duration-300">
    <!-- Orbes decorativos de fondo -->
    <div class="pointer-events-none absolute inset-0 overflow-hidden">
      <div class="absolute -left-[10%] -top-[10%] h-[400px] w-[400px] rounded-full bg-accent-neon/10 dark:bg-accent-neon/15 blur-[120px] animate-pulse"></div>
      <div class="absolute -right-[5%] top-[15%] h-[350px] w-[350px] rounded-full bg-accent-solar/10 dark:bg-accent-solar/5 blur-[100px]"></div>
    </div>

    <div class="relative z-10 max-w-7xl mx-auto py-2 sm:py-6 px-4 sm:px-6 space-y-4 sm:space-y-6">
      <!-- Header de Configuración (Compacto) -->
      <EstudiantePageHeader
        eyebrow="Configuración"
        title="Mi"
        highlight="Perfil"
        description="Gestiona tus datos personales, verifica la seguridad de tu cuenta y consulta tus estadísticas de formación."
        :stats="headerStats"
      />

      <div class="grid grid-cols-1 gap-6 xl:grid-cols-[minmax(0,1.6fr)_minmax(340px,0.9fr)]">
        
        <!-- Formulario Principal de Datos -->
        <section class="course-card-premium p-5 sm:p-7 md:p-8 rounded-3xl sm:rounded-[32px] bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 shadow-xl transition-all">
          <div class="mb-6 flex flex-col sm:flex-row sm:items-center justify-between gap-3 pb-4 border-b border-gray-100 dark:border-white/5">
            <div>
              <span class="text-[9px] font-black uppercase tracking-[0.2em] text-accent-neon">Datos personales</span>
              <h2 class="font-lexend text-xl sm:text-2xl font-black text-gray-900 dark:text-white tracking-tight">
                Información de la Cuenta
              </h2>
            </div>
            <span class="self-start sm:self-auto rounded-full bg-accent-neon/10 px-3.5 py-1.5 text-[9px] font-black uppercase tracking-widest text-accent-neon border border-accent-neon/20">
              Perfil editable
            </span>
          </div>

          <form @submit.prevent="handleUpdateProfile" class="space-y-5">
            <div class="grid grid-cols-1 gap-4 sm:gap-5 md:grid-cols-2">
              
              <!-- Nombres -->
              <div class="space-y-1.5">
                <label class="px-1 text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Nombres</label>
                <div class="relative">
                  <input 
                    v-model="form.nombres" 
                    type="text" 
                    required 
                    class="input-cyber w-full rounded-2xl bg-gray-50 dark:bg-white/[0.04] border border-gray-200 dark:border-white/10 px-4 py-3 text-sm font-semibold text-gray-900 dark:text-white focus:outline-none focus:border-accent-neon transition-all" 
                    placeholder="Tus nombres" 
                  />
                </div>
              </div>

              <!-- Apellidos -->
              <div class="space-y-1.5">
                <label class="px-1 text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Apellidos</label>
                <div class="relative">
                  <input 
                    v-model="form.apellidos" 
                    type="text" 
                    required 
                    class="input-cyber w-full rounded-2xl bg-gray-50 dark:bg-white/[0.04] border border-gray-200 dark:border-white/10 px-4 py-3 text-sm font-semibold text-gray-900 dark:text-white focus:outline-none focus:border-accent-neon transition-all" 
                    placeholder="Tus apellidos" 
                  />
                </div>
              </div>

              <!-- Correo Electrónico (Readonly) -->
              <div class="space-y-1.5">
                <label class="px-1 text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Correo electrónico</label>
                <div class="relative">
                  <input 
                    :value="authStore.user?.correo" 
                    type="email" 
                    readonly 
                    class="input-cyber w-full rounded-2xl bg-gray-100 dark:bg-white/[0.02] border border-gray-200/50 dark:border-white/5 px-4 py-3 text-sm font-semibold text-gray-500 dark:text-white/40 cursor-not-allowed" 
                  />
                  <span class="material-symbols-outlined absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 dark:text-white/20 text-lg">lock</span>
                </div>
              </div>

              <!-- Cédula / DNI -->
              <div class="space-y-1.5">
                <label class="px-1 text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Cédula / DNI</label>
                <div class="relative">
                  <input 
                    v-model="form.ci" 
                    type="text" 
                    required 
                    class="input-cyber w-full rounded-2xl bg-gray-50 dark:bg-white/[0.04] border border-gray-200 dark:border-white/10 px-4 py-3 text-sm font-semibold text-gray-900 dark:text-white focus:outline-none focus:border-accent-neon transition-all" 
                    placeholder="Documento de identidad" 
                  />
                </div>
              </div>

              <!-- WhatsApp / Teléfono -->
              <div class="space-y-1.5">
                <label class="px-1 text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">WhatsApp / Teléfono</label>
                <div class="relative">
                  <input 
                    v-model="form.telefono" 
                    type="text" 
                    required 
                    class="input-cyber w-full rounded-2xl bg-gray-50 dark:bg-white/[0.04] border border-gray-200 dark:border-white/10 px-4 py-3 text-sm font-semibold text-gray-900 dark:text-white focus:outline-none focus:border-accent-neon transition-all" 
                    placeholder="+591 ..." 
                  />
                </div>
              </div>

              <!-- Nueva Contraseña -->
              <div class="space-y-1.5">
                <label class="px-1 text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">Nueva Contraseña</label>
                <div class="relative">
                  <input 
                    v-model="form.contrasena" 
                    :type="showPassword ? 'text' : 'password'" 
                    class="input-cyber w-full rounded-2xl bg-gray-50 dark:bg-white/[0.04] border border-gray-200 dark:border-white/10 pr-12 pl-4 py-3 text-sm font-semibold text-gray-900 dark:text-white focus:outline-none focus:border-accent-neon transition-all" 
                    placeholder="Dejar en blanco para mantener" 
                  />
                  <button 
                    type="button" 
                    @click="showPassword = !showPassword" 
                    class="absolute right-4 top-1/2 -translate-y-1/2 text-gray-400 hover:text-accent-neon transition-colors"
                  >
                    <span class="material-symbols-outlined text-lg">{{ showPassword ? 'visibility_off' : 'visibility' }}</span>
                  </button>
                </div>
              </div>
            </div>

            <!-- Botones de Acción -->
            <div class="flex flex-col sm:flex-row gap-3 pt-3">
              <button 
                type="submit" 
                :disabled="saving" 
                class="btn-premium btn-primary-neon w-full sm:w-auto inline-flex items-center justify-center gap-2 !px-8 !py-3.5 text-[9px] font-black uppercase tracking-widest shadow-neon-sm relative overflow-hidden"
              >
                <div v-if="saving" class="shimmer-effect"></div>
                <span v-if="!saving" class="material-symbols-outlined text-base">save</span>
                <div v-else class="animate-spin rounded-full h-4 w-4 border-t-2 border-background"></div>
                {{ saving ? 'Guardando...' : 'Guardar perfil' }}
              </button>

              <router-link 
                to="/student/certificates" 
                class="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-6 py-3.5 rounded-2xl text-[9px] font-black uppercase tracking-widest bg-gray-100 hover:bg-gray-200 dark:bg-white/5 dark:hover:bg-white/10 text-gray-800 dark:text-white hover:text-accent-neon transition-all text-center"
              >
                <span class="material-symbols-outlined text-base">workspace_premium</span>
                Ver historial
              </router-link>
            </div>
          </form>
        </section>

        <!-- Sidebar Informativo / Avatar / Seguridad -->
        <aside class="space-y-6">
          
          <!-- Card Avatar & Estadísticas Rápidas -->
          <section class="course-card-premium overflow-hidden p-5 sm:p-6 rounded-3xl bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 shadow-lg text-center">
            <div class="relative mx-auto mb-4 h-24 w-24">
              <div class="flex h-full w-full items-center justify-center rounded-[28px] bg-accent-neon/10 text-3xl font-black text-accent-neon border border-accent-neon/20 shadow-inner overflow-hidden">
                <img
                  v-if="profileImageUrl && !profileImageFailed"
                  :src="profileImageUrl"
                  class="h-full w-full object-cover"
                  @error="profileImageFailed = true"
                />
                <span v-else>{{ userInitials }}</span>
              </div>
              <button 
                class="absolute -bottom-1 -right-1 flex h-8 w-8 items-center justify-center rounded-xl bg-accent-neon text-background shadow-md shadow-accent-neon/30 transition-transform hover:scale-110"
                aria-label="Cambiar foto de perfil"
              >
                <span class="material-symbols-outlined text-base">photo_camera</span>
              </button>
            </div>

            <h3 class="text-lg sm:text-xl font-black font-lexend text-gray-900 dark:text-white">
              {{ authStore.user?.nombres }} {{ authStore.user?.apellidos }}
            </h3>
            <p class="mt-0.5 text-[9px] font-black uppercase tracking-widest text-gray-400 dark:text-white/40">
              Estudiante verificado
            </p>

            <div class="mt-6 grid grid-cols-2 gap-3 pt-4 border-t border-gray-100 dark:border-white/5">
              <div class="rounded-2xl bg-gray-50 dark:bg-white/[0.03] p-3 text-center border border-gray-200/50 dark:border-white/5">
                <p class="text-xl font-black font-lexend text-accent-neon">{{ stats.completedCourses }}</p>
                <p class="text-[8px] font-black uppercase tracking-widest text-gray-400 dark:text-white/40">Cursos</p>
              </div>
              <div class="rounded-2xl bg-gray-50 dark:bg-white/[0.03] p-3 text-center border border-gray-200/50 dark:border-white/5">
                <p class="text-xl font-black font-lexend text-accent-solar">{{ stats.certificates }}</p>
                <p class="text-[8px] font-black uppercase tracking-widest text-gray-400 dark:text-white/40">Certificados</p>
              </div>
            </div>
          </section>

          <!-- Seguridad de Cuenta & Dispositivo Vinculado -->
          <section class="course-card-premium p-5 sm:p-6 rounded-3xl bg-white dark:bg-surface border border-gray-200/80 dark:border-white/10 shadow-lg">
            <h3 class="mb-4 flex items-center gap-2 text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">
              <span class="material-symbols-outlined text-accent-neon text-base">security</span>
              Seguridad de la cuenta
            </h3>

            <!-- Dispositivo Activo -->
            <div v-if="activeDevice" class="mb-4 p-4 rounded-2xl bg-accent-neon/5 border border-accent-neon/20 animate-in fade-in duration-500">
              <div class="flex items-center gap-3">
                <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-accent-neon/10 text-accent-neon border border-accent-neon/20">
                  <span class="material-symbols-outlined text-xl">{{ getDeviceIcon(activeDevice.sistema_operativo) }}</span>
                </div>
                <div class="flex-1 min-w-0">
                  <p class="text-xs font-black text-gray-900 dark:text-white">Equipo Vinculado</p>
                  <p class="text-[9px] font-bold text-gray-500 dark:text-white/60 uppercase truncate">
                    {{ activeDevice.sistema_operativo }} • {{ activeDevice.navegador }}
                  </p>
                </div>
              </div>

              <div class="mt-3 pt-3 border-t border-accent-neon/10 space-y-1.5">
                <div class="flex justify-between items-center text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">
                  <span>Último acceso</span>
                  <span class="text-gray-700 dark:text-white/70">{{ activeDevice.ultimo_acceso ? new Date(activeDevice.ultimo_acceso).toLocaleDateString() : 'Nunca' }}</span>
                </div>
                <div class="flex justify-between items-center text-[9px] font-black uppercase tracking-widest text-gray-500 dark:text-white/40">
                  <span>Dirección IP</span>
                  <span class="text-gray-700 dark:text-white/70 font-mono">{{ activeDevice.direccion_ip }}</span>
                </div>
              </div>
            </div>

            <!-- Lista de Verificaciones -->
            <ul class="space-y-2.5">
              <li class="flex items-center gap-2.5 text-xs font-bold text-gray-600 dark:text-white/70">
                <span class="material-symbols-outlined text-green-500 text-base">check_circle</span>
                Verificación activa del correo
              </li>
              <li class="flex items-center gap-2.5 text-xs font-bold text-gray-600 dark:text-white/70">
                <span class="material-symbols-outlined text-accent-neon text-base animate-pulse">verified_user</span>
                Protección de huella digital activa
              </li>
            </ul>

            <!-- Nota Informativa -->
            <div class="mt-4 p-3 rounded-2xl bg-gray-50 dark:bg-white/[0.03] text-[9px] font-bold text-gray-500 dark:text-white/40 leading-relaxed border border-gray-200/50 dark:border-white/5">
              * Tu cuenta está vinculada a este equipo por seguridad. Si requieres cambiar de dispositivo, contacta con soporte técnico para liberar tu sesión.
            </div>
          </section>

        </aside>
      </div>
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
