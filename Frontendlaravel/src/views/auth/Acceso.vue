<template>
  <div class="login-wrapper font-inter overflow-hidden relative min-h-screen flex items-center justify-center bg-background">
    <!-- Fondos Animados Premium -->
    <div class="absolute inset-0 z-0 overflow-hidden pointer-events-none">
      <div class="absolute -top-[10%] -right-[5%] w-[820px] h-[820px] bg-accent-neon/10 rounded-full blur-[160px] animate-pulse-slow"></div>
      <div class="absolute -bottom-[10%] -left-[5%] w-[620px] h-[620px] bg-accent-solar/5 rounded-full blur-[140px] animate-pulse-slow delay-1000"></div>
    </div>

    <main class="relative z-10 w-full max-w-[1320px] px-6 py-8">
      <div class="grid items-stretch gap-8 lg:grid-cols-[1.12fr_0.88fr]">
        <!-- Feature Card (Izquierda) -->
        <section class="hidden lg:flex auth-feature-card p-10">
          <div class="relative z-10 flex h-full w-full flex-col">
            <button type="button" class="self-center transition-transform hover:scale-105 active:scale-95" @click="$router.push('/')">
              <AppLogo :img-style="{ height: '7.3rem' }" img-class="w-auto object-contain mx-auto" />
            </button>
            <div class="mt-8 space-y-4 max-w-[44ch]">
              <p class="text-accent-neon text-xs uppercase tracking-[0.3em] font-black">Energia que da vida</p>
              <h1 class="text-5xl leading-[0.95] font-black text-on-surface font-lexend">Accede a nuestros cursos y aprende sobre energía solar.</h1>
              <p class="text-on-surface-variant text-lg leading-relaxed">El conocimiento en energía solar es una necesidad para el futuro inmediato. Aprende con nosotros.</p>
            </div>
            <div class="mt-auto pt-8">
              <div class="relative group overflow-hidden rounded-[2.5rem]">
                <img src="/images/acceso.webp" alt="Paneles solares" class="h-[310px] w-full object-cover transition-transform duration-700 group-hover:scale-110" />
                <div class="absolute inset-0 bg-gradient-to-t from-background/80 to-transparent opacity-60"></div>
              </div>
            </div>
          </div>
        </section>

        <!-- Form Section (Derecha) -->
        <section class="flex flex-col items-center justify-center">
          <div class="text-center mb-8">
            <div class="inline-block cursor-pointer mb-6 transition-transform hover:scale-105 lg:hidden" @click="$router.push('/')">
              <AppLogo :img-style="{ height: '4rem' }" img-class="w-auto object-contain mx-auto" />
            </div>
            <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tight uppercase">Bienvenido</h2>
            <p class="text-on-surface-variant text-sm mt-2 font-medium tracking-wide">Accede a tu panel de control</p>
          </div>

          <div class="w-full max-w-[540px] auth-form-card p-8 md:p-10">
            <form class="space-y-6" @submit.prevent="handleLogin">
              <!-- Email Field -->
              <div class="space-y-2">
                <label class="block text-[10px] font-black text-accent-neon uppercase tracking-[0.2em] ml-1">Correo corporativo</label>
                <div class="relative group">
                  <div class="absolute left-5 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-accent-neon transition-all duration-300">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/></svg>
                  </div>
                  <input v-model="email" class="input-glass pl-14" placeholder="usuario@enervida.com" type="email" required />
                </div>
              </div>

              <!-- Password Field -->
              <div class="space-y-2">
                <label class="block text-[10px] font-black text-accent-neon uppercase tracking-[0.2em] ml-1">Contrasena</label>
                <div class="relative group">
                  <div class="absolute left-5 top-1/2 -translate-y-1/2 text-on-surface-variant group-focus-within:text-accent-neon transition-all duration-300">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="10" rx="2"/><path d="M7 11V8a5 5 0 0 1 10 0v3"/></svg>
                  </div>
                  <input 
                    v-model="password" 
                    class="input-glass pl-14 pr-14" 
                    placeholder="********" 
                    :type="showPassword ? 'text' : 'password'" 
                    required 
                  />
                  <!-- Toggle Password Visibility Icon -->
                  <button 
                    type="button" 
                    @click="showPassword = !showPassword"
                    class="absolute right-5 top-1/2 -translate-y-1/2 text-on-surface-variant hover:text-accent-neon transition-colors p-1"
                  >
                    <svg v-if="!showPassword" class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                    <svg v-else class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>
                  </button>
                </div>
              </div>

              <div class="flex justify-end">
                <router-link to="/forgot-password" class="inline-flex items-center gap-2 text-xs text-accent-neon hover:text-accent-solar font-bold transition-all hover:translate-x-1">
                  Recuperar contrasena
                  <svg class="w-3.5 h-3.5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
                </router-link>
              </div>

              <div v-if="error" class="bg-red-500/10 p-4 rounded-2xl text-red-400 text-[11px] font-bold text-center animate-shake border border-red-500/10">{{ error }}</div>

              <button :disabled="loading" class="btn-premium btn-primary-neon w-full !py-4.5 !rounded-2xl group relative overflow-hidden" type="submit">
                <div class="absolute inset-0 bg-white/10 translate-y-full group-hover:translate-y-0 transition-transform duration-300"></div>
                <span v-if="!loading" class="relative flex items-center justify-center gap-2">Iniciar sesion</span>
                <span v-else class="relative flex items-center justify-center gap-3 font-black">
                  <svg class="animate-spin h-4 w-4 text-primary" viewBox="0 0 24 24"><circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle><path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
                  Verificando...
                </span>
              </button>
            </form>

            <p class="social-hint my-7 text-center text-[11px] font-black text-on-surface-variant uppercase tracking-[0.2em]">O continua con</p>

            <button type="button" @click="customGoogleLogin" :disabled="loading" class="secondary-auth-btn w-full rounded-2xl py-4 px-6 flex items-center justify-center gap-3 active:scale-95 group">
              <img src="https://www.gstatic.com/firebasejs/ui/2.0.0/images/auth/google.svg" class="w-5 h-5 transition-transform group-hover:scale-110" alt="Google" />
              <span class="text-on-surface font-bold text-xs uppercase tracking-widest">Iniciar con Google</span>
            </button>

            <div class="mt-8 flex items-center justify-between gap-4">
              <p class="text-sm text-on-surface-variant font-medium">¿Aun no tienes cuenta?</p>
              <router-link to="/register" class="auth-switch-btn group">
                <span>Registrarme</span>
                <svg class="w-4 h-4 transition-transform group-hover:translate-x-1" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
              </router-link>
            </div>
          </div>
        </section>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import AppLogo from '@/components/global/AppLogo.vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useTokenClient } from 'vue3-google-signin'
import { useNotificationStore } from '@/stores/notificationStore'
import confetti from 'canvas-confetti'

const router = useRouter()
const authStore = useAuthStore()
const notificationStore = useNotificationStore()
const loading = ref(false)
const email = ref('')
const password = ref('')
const error = ref('')
const showPassword = ref(false)

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
      const user = await authStore.googleLogin({ access_token: tokenResponse.access_token })
      triggerConfetti()
      notificationStore.addNotification({
        title: 'Acceso exitoso',
        message: `Bienvenido de nuevo, ${user.nombre || 'estudiante'}.`,
        type: 'success'
      })
      const userRole = user.rol?.nombre?.toLowerCase()
      const target = userRole === 'estudiante' ? '/student' : '/admin'
      await router.push(target)
    } catch (err) {
      console.error('Error google login:', err)
      const errorCode = err.response?.data?.error
      if (errorCode === 'DISPOSITIVO_NO_AUTORIZADO') {
        error.value = 'Esta cuenta ya está vinculada a otro dispositivo. Contacta al administrador para liberar tu cuenta.'
      } else {
        const msg = err.response?.data?.message || 'Error al validar cuenta de Google'
        error.value = msg
      }
      notificationStore.addNotification({ title: 'Acceso denegado', message: error.value, type: 'error' })
    } finally {
      loading.value = false
    }
  },
  onError: () => {
    error.value = 'Error al iniciar sesion con Google'
    notificationStore.addNotification({
      title: 'Google Login',
      message: 'Se cancelo o fallo el inicio de sesion con Google.',
      type: 'error'
    })
    loading.value = false
  }
})

const handleLogin = async () => {
  if (loading.value) return
  
  error.value = ''
  loading.value = true
  
  // Timeout de seguridad para evitar quedarse trabado si algo falla en la navegación
  const timeoutId = setTimeout(() => {
    if (loading.value) {
      loading.value = false
      error.value = 'La sesión tardó demasiado en responder. Intenta de nuevo.'
    }
  }, 20000)

  try {
    const user = await authStore.login({
      correo: email.value,
      contrasena: password.value
    })
    
    clearTimeout(timeoutId)
    triggerConfetti()
    
    notificationStore.addNotification({
      title: 'Bienvenido',
      message: 'Has iniciado sesion correctamente.',
      type: 'success'
    })
    
    const userRole = user.rol?.nombre?.toLowerCase()
    const target = userRole === 'estudiante' ? '/student' : '/admin'
    
    await router.push(target)
  } catch (err) {
    clearTimeout(timeoutId)
    console.error('Error en login:', err)

    const errorCode = err.response?.data?.error
    if (errorCode === 'DISPOSITIVO_NO_AUTORIZADO') {
      error.value = 'Esta cuenta ya está vinculada a otro dispositivo. Contacta al administrador para liberar tu cuenta.'
    } else {
      const msg = err.response?.data?.message || 'Credenciales invalidas o error de conexion'
      error.value = msg
    }

    notificationStore.addNotification({ title: 'Acceso denegado', message: error.value, type: 'error' })
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.input-glass {
  width: 100%;
  background-color: var(--input-bg);
  border: none; /* Eliminamos las líneas blancas */
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

/* Ocultar el ojo nativo del navegador para evitar conflictos */
input::-ms-reveal,
input::-ms-clear {
  display: none;
}

.auth-feature-card {
  position: relative;
  overflow: hidden;
  border-radius: 3rem;
  border: none; /* Sin bordes blancos */
  background: linear-gradient(
    135deg,
    color-mix(in srgb, var(--surface-card) 94%, #16345f 6%),
    color-mix(in srgb, var(--surface-card) 88%, #102744 12%)
  );
  box-shadow: 0 40px 100px -20px rgba(0, 0, 0, 0.4);
}

.auth-form-card {
  border-radius: 3.5rem;
  border: none; /* Sin bordes blancos */
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


