<template>
  <div class="login-wrapper font-inter overflow-hidden relative min-h-screen flex items-center justify-center bg-background">
    <!-- Fondos Animados Premium -->
    <div class="absolute inset-0 z-0 overflow-hidden pointer-events-none">
      <div class="absolute -top-[10%] -right-[5%] w-[820px] h-[820px] bg-accent-neon/10 rounded-full blur-[160px] animate-pulse-slow"></div>
      <div class="absolute -bottom-[10%] -left-[5%] w-[620px] h-[620px] bg-accent-solar/5 rounded-full blur-[140px] animate-pulse-slow delay-1000"></div>
    </div>

    <main class="relative z-10 w-full max-w-[1320px] px-6 py-8">
      <div class="grid items-stretch gap-8 lg:grid-cols-[0.88fr_1.12fr]">
        <!-- Form Section (Izquierda en Desktop, abajo en Mobile) -->
        <section class="flex flex-col items-center justify-center order-2 lg:order-1">
          <div class="text-center mb-8">
            <div class="inline-block cursor-pointer mb-6 transition-transform hover:scale-105 lg:hidden" @click="$router.push('/')">
              <AppLogo :img-style="{ height: '4rem' }" img-class="w-auto object-contain mx-auto" />
            </div>
            <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tight uppercase">Unete a Enervida</h2>
            <p class="text-on-surface-variant text-sm mt-2 font-medium tracking-wide">Crea tu cuenta y comienza hoy</p>
          </div>

          <div class="w-full max-w-[560px] auth-form-card p-8 md:p-10">
            <form class="space-y-6" @submit.prevent="handleRegister">
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <!-- Nombre -->
                <div class="space-y-2">
                  <label class="block text-[10px] font-black text-accent-neon uppercase tracking-[0.2em] ml-1">Nombre</label>
                  <div class="relative group">
                    <div class="absolute left-5 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-accent-neon transition-all duration-300">
                      <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M20 21a8 8 0 0 0-16 0"/><circle cx="12" cy="7" r="4"/>
                      </svg>
                    </div>
                    <input v-model="form.nombres" class="input-glass pl-14" placeholder="Juan" type="text" required />
                  </div>
                </div>
                <!-- Apellido -->
                <div class="space-y-2">
                  <label class="block text-[10px] font-black text-accent-neon uppercase tracking-[0.2em] ml-1">Apellido</label>
                  <div class="relative group">
                    <div class="absolute left-5 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-accent-neon transition-all duration-300">
                      <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M19 8v6m-3-3h6"/>
                      </svg>
                    </div>
                    <input v-model="form.apellidos" class="input-glass pl-14" placeholder="Perez" type="text" required />
                  </div>
                </div>
              </div>

              <!-- Correo -->
              <div class="space-y-2">
                <label class="block text-[10px] font-black text-accent-neon uppercase tracking-[0.2em] ml-1">Correo corporativo</label>
                <div class="relative group">
                  <div class="absolute left-5 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-accent-neon transition-all duration-300">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/>
                    </svg>
                  </div>
                  <input v-model="form.correo" class="input-glass pl-14" placeholder="usuario@enervida.com" type="email" required />
                </div>
              </div>

              <!-- Contrasena -->
              <div class="space-y-2">
                <label class="block text-[10px] font-black text-accent-neon uppercase tracking-[0.2em] ml-1">Contrasena</label>
                <div class="relative group">
                  <div class="absolute left-5 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-accent-neon transition-all duration-300">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V8a5 5 0 0 1 10 0v3"/>
                    </svg>
                  </div>
                  <input 
                    v-model="form.contrasena_hash" 
                    class="input-glass pl-14 pr-14" 
                    placeholder="********" 
                    :type="showPassword ? 'text' : 'password'" 
                    required 
                  />
                  <!-- Toggle Visibility -->
                  <button 
                    type="button" 
                    @click="showPassword = !showPassword"
                    class="absolute right-5 top-1/2 -translate-y-1/2 text-on-surface-variant hover:text-accent-neon transition-colors p-1"
                  >
                    <svg v-if="!showPassword" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                    <svg v-else class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>
                  </button>
                </div>

                <!-- Fortaleza de Contraseña -->
                <div v-if="form.contrasena_hash" class="mt-3 space-y-3 p-4 rounded-2xl bg-on-surface/[0.02] border border-on-surface/[0.05] transition-all duration-300">
                  <div class="flex items-center justify-between">
                    <span class="text-[9px] font-black uppercase tracking-wider text-on-surface-variant">Fortaleza:</span>
                    <span :class="['text-[10px] font-black uppercase tracking-wider transition-colors duration-300', passwordStrength.textClass]">{{ passwordStrength.label }}</span>
                  </div>
                  
                  <!-- Barra de progreso -->
                  <div class="h-1.5 w-full bg-on-surface/10 rounded-full overflow-hidden">
                    <div 
                      :class="['h-full rounded-full transition-all duration-500 ease-out', passwordStrength.colorClass]"
                      :style="{ width: (passwordStrength.score * 25) + '%' }"
                    ></div>
                  </div>

                  <!-- Reglas de seguridad -->
                  <div class="grid grid-cols-2 gap-x-4 gap-y-2 pt-2 border-t border-on-surface/5">
                    <!-- Rule 1: Longitud -->
                    <div class="flex items-center gap-2 text-[10px] font-bold transition-all duration-300" :class="passwordRules.length ? 'text-emerald-400' : 'text-on-surface/30'">
                      <svg class="w-3.5 h-3.5 shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"></polyline>
                      </svg>
                      <span>8+ caracteres</span>
                    </div>

                    <!-- Rule 2: Mayúscula -->
                    <div class="flex items-center gap-2 text-[10px] font-bold transition-all duration-300" :class="passwordRules.uppercase ? 'text-emerald-400' : 'text-on-surface/30'">
                      <svg class="w-3.5 h-3.5 shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"></polyline>
                      </svg>
                      <span>Una Mayúscula</span>
                    </div>

                    <!-- Rule 3: Número -->
                    <div class="flex items-center gap-2 text-[10px] font-bold transition-all duration-300" :class="passwordRules.number ? 'text-emerald-400' : 'text-on-surface/30'">
                      <svg class="w-3.5 h-3.5 shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"></polyline>
                      </svg>
                      <span>Un Número</span>
                    </div>

                    <!-- Rule 4: Especial -->
                    <div class="flex items-center gap-2 text-[10px] font-bold transition-all duration-300" :class="passwordRules.special ? 'text-emerald-400' : 'text-on-surface/30'">
                      <svg class="w-3.5 h-3.5 shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                        <polyline points="20 6 9 17 4 12"></polyline>
                      </svg>
                      <span>Carácter Especial</span>
                    </div>
                  </div>
                </div>
              </div>

              <div v-if="error" class="bg-red-500/10 p-4 rounded-2xl text-red-400 text-[11px] font-bold text-center animate-shake border border-red-500/10">{{ error }}</div>

              <button :disabled="loading" class="btn-premium btn-primary-neon w-full !py-4.5 !rounded-2xl group relative overflow-hidden" type="submit">
                <div class="absolute inset-0 bg-white/10 translate-y-full group-hover:translate-y-0 transition-transform duration-300"></div>
                <span v-if="!loading" class="relative flex items-center justify-center gap-2">Crear cuenta</span>
                <span v-else class="relative flex items-center justify-center gap-3 font-black">
                  <svg class="animate-spin h-4 w-4 text-primary" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
                  Procesando...
                </span>
              </button>
            </form>

            <p class="social-hint my-7 text-center text-[11px] font-black text-on-surface-variant uppercase tracking-[0.2em]">O continua con</p>

            <button type="button" @click="customGoogleLogin" :disabled="loading" class="secondary-auth-btn w-full rounded-2xl py-4 px-6 flex items-center justify-center gap-3 active:scale-95 group">
              <img src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" class="w-5 h-5 transition-transform group-hover:scale-110" alt="Google" />
              <span class="text-on-surface font-bold text-xs uppercase tracking-widest">Registrar con Google</span>
            </button>

            <div class="mt-8 flex items-center justify-between gap-4">
              <p class="text-sm text-on-surface-variant font-medium">¿Ya tienes cuenta?</p>
              <router-link to="/login" class="auth-switch-btn group">
                <span>Iniciar sesion</span>
                <svg class="w-4 h-4 transition-transform group-hover:translate-x-1" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
              </router-link>
            </div>
          </div>
        </section>

        <!-- Feature Card (Derecha en Desktop) -->
        <section class="hidden lg:flex auth-feature-card p-10 order-1 lg:order-2">
          <div class="relative z-10 flex h-full w-full flex-col">
            <button type="button" class="self-center transition-transform hover:scale-105 active:scale-95" @click="$router.push('/')">
              <AppLogo :img-style="{ height: '7.3rem' }" img-class="w-auto object-contain mx-auto" />
            </button>
            <div class="mt-8 space-y-4 max-w-[44ch]">
              <p class="text-accent-neon text-xs uppercase tracking-[0.3em] font-black">Comunidad solar</p>
              <h1 class="text-5xl leading-[0.95] font-black text-on-surface font-lexend">Aprende, certifica y crece con Enervida.</h1>
              <p class="text-on-surface-variant text-lg leading-relaxed">Accede a rutas de aprendizaje, clases en vivo y herramientas tecnicas desde un solo lugar.</p>
            </div>
            <div class="mt-auto pt-8">
              <div class="relative group overflow-hidden rounded-[2.5rem]">
                <img src="/images/registro.webp" alt="Energia solar" class="h-[310px] w-full object-cover transition-transform duration-700 group-hover:scale-110" />
                <div class="absolute inset-0 bg-gradient-to-t from-background/80 to-transparent opacity-60"></div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue'
import AppLogo from '@/components/global/AppLogo.vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useNotificationStore } from '@/stores/notificationStore'
import { useTokenClient } from 'vue3-google-signin'
import confetti from 'canvas-confetti'

const router = useRouter()
const authStore = useAuthStore()
const notificationStore = useNotificationStore()
const loading = ref(false)
const error = ref('')
const showPassword = ref(false)

const form = reactive({
  nombres: '',
  apellidos: '',
  correo: '',
  contrasena_hash: ''
})

const passwordRules = computed(() => {
  const pwd = form.contrasena_hash || ''
  return {
    length: pwd.length >= 8,
    uppercase: /[A-Z]/.test(pwd),
    number: /[0-9]/.test(pwd),
    special: /[^A-Za-z0-9]/.test(pwd)
  }
})

const passwordStrength = computed(() => {
  const pwd = form.contrasena_hash || ''
  if (!pwd) return { score: 0, label: '', colorClass: 'bg-transparent', textClass: 'text-on-surface-variant' }

  let score = 0
  if (passwordRules.value.length) score++
  if (passwordRules.value.uppercase) score++
  if (passwordRules.value.number) score++
  if (passwordRules.value.special) score++

  let label = 'Débil'
  let colorClass = 'bg-red-500'
  let textClass = 'text-red-400'

  if (score === 2) {
    label = 'Moderada'
    colorClass = 'bg-orange-500'
    textClass = 'text-orange-400'
  } else if (score === 3) {
    label = 'Buena'
    colorClass = 'bg-emerald-500'
    textClass = 'text-emerald-400'
  } else if (score === 4) {
    label = 'Fuerte'
    colorClass = 'bg-accent-neon'
    textClass = 'text-accent-neon'
  }

  return {
    score,
    label,
    colorClass,
    textClass
  }
})

const triggerConfetti = () => {
  confetti({
    particleCount: 150,
    spread: 70,
    origin: { y: 0.6 },
    colors: ['#06b6d4', '#0ea5a4', '#EAB308'],
    disableForReducedMotion: true
  })
}

const { login: customGoogleLogin } = useTokenClient({
  onSuccess: async (tokenResponse) => {
    loading.value = true
    error.value = ''
    try {
      const user = await authStore.googleLogin({ 
        access_token: tokenResponse.access_token 
      })
      triggerConfetti()
      notificationStore.addNotification({
        title: '¡Acceso Exitoso!',
        message: 'Bienvenido a Enervida. Tu cuenta de Google ha sido vinculada.',
        type: 'success'
      })
      const userRole = user.rol?.nombre?.toLowerCase()
      const target = userRole === 'estudiante' ? '/student' : '/admin'
      await router.push(target)
    } catch (err) {
      console.error('Error google register:', err)
      const errorCode = err.response?.data?.error
      if (errorCode === 'DISPOSITIVO_NO_AUTORIZADO') {
        error.value = ' Esta cuenta ya está vinculada a otro dispositivo. Contacta al administrador para liberar tu cuenta.'
      } else {
        const msg = err.response?.data?.message || 'Error al registrar con Google'
        error.value = msg
      }
      notificationStore.addNotification({
        title: 'Acceso denegado',
        message: error.value,
        type: 'error'
      })
    } finally {
      loading.value = false
    }
  },
  onError: () => {
    error.value = 'Error al registrar con Google'
    loading.value = false
  }
})

const handleRegister = async () => {
  if (loading.value) return
  
  error.value = ''
  loading.value = true

  // Timeout de seguridad
  const timeoutId = setTimeout(() => {
    if (loading.value) {
      loading.value = false
      error.value = 'El registro está tardando demasiado. Verifica tu conexión.'
    }
  }, 15000)
  
  try {
    const user = await authStore.register(form)
    clearTimeout(timeoutId)
    triggerConfetti()
    
    notificationStore.addNotification({
      title: '¡Bienvenido, ' + form.nombres + '!',
      message: 'Tu cuenta ha sido creada exitosamente. Iniciando sesión...',
      type: 'success'
    })
    
    const userRole = user.rol?.nombre?.toLowerCase()
    const target = userRole === 'estudiante' ? '/student' : '/admin'
    await router.push(target)
  } catch (err) {
    clearTimeout(timeoutId)
    console.error('Error en registro:', err)
    const msg = err.response?.data?.message || 'Error al crear la cuenta'
    error.value = msg
    notificationStore.addNotification({
      title: 'Error en Registro',
      message: msg,
      type: 'error'
    })
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.input-glass {
  width: 100%;
  background-color: var(--input-bg);
  border: none;
  border-radius: 1.25rem;
  padding-top: 1.1rem;
  padding-bottom: 1.1rem;
  color: var(--on-surface);
  font-size: 0.875rem;
  transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
  outline: none;
  caret-color: var(--accent-neon);
  box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.05);
}

.input-glass:hover {
  background-color: color-mix(in srgb, var(--input-bg) 92%, var(--on-surface) 8%);
  transform: translateY(-1px);
}

.input-glass:focus {
  background-color: var(--input-bg-focus);
  box-shadow: 0 0 0 2px var(--accent-neon), 0 10px 20px -10px rgba(6, 182, 212, 0.3);
}

/* Ocultar el ojo nativo del navegador */
input::-ms-reveal,
input::-ms-clear {
  display: none;
}

.auth-feature-card {
  position: relative;
  overflow: hidden;
  border-radius: 3rem;
  border: none;
  background: linear-gradient(
    135deg,
    color-mix(in srgb, var(--surface-card) 94%, #16345f 6%),
    color-mix(in srgb, var(--surface-card) 88%, #102744 12%)
  );
  box-shadow: 0 40px 100px -20px rgba(0, 0, 0, 0.4);
}

.auth-form-card {
  border-radius: 3.5rem;
  border: none;
  background: color-mix(in srgb, var(--surface-card) 98%, var(--background) 2%);
  box-shadow: 0 30px 80px -20px rgba(0, 0, 0, 0.25);
  backdrop-filter: blur(40px);
}

.auth-switch-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.65rem 1.1rem;
  border-radius: 1rem;
  color: var(--accent-neon);
  font-weight: 800;
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  background: color-mix(in srgb, var(--accent-neon) 8%, transparent);
  transition: all 0.3s ease;
}

.auth-switch-btn:hover {
  background: color-mix(in srgb, var(--accent-neon) 15%, transparent);
  transform: scale(1.05);
}

.secondary-auth-btn {
  border: none;
  background: color-mix(in srgb, var(--surface-card) 94%, var(--on-surface) 6%);
  transition: all 0.3s cubic-bezier(0.23, 1, 0.32, 1);
}

.secondary-auth-btn:hover {
  background: color-mix(in srgb, var(--surface-card) 88%, var(--on-surface) 12%);
  transform: translateY(-2px);
  box-shadow: 0 10px 25px -10px rgba(0, 0, 0, 0.2);
}

@keyframes pulse-slow {
  0%, 100% { opacity: 0.1; transform: scale(1); }
  50% { opacity: 0.2; transform: scale(1.05); }
}

.animate-pulse-slow {
  animation: pulse-slow 8s ease-in-out infinite;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-6px); }
  75% { transform: translateX(6px); }
}

.animate-shake {
  animation: shake 0.4s cubic-bezier(.36,.07,.19,.97) both;
}
</style>
















