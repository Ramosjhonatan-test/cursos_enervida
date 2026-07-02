<template>
  <div class="login-wrapper font-inter">
    <!-- Fondos Dinámicos -->
    <div class="absolute inset-0 bg-background"></div>
    <div class="absolute inset-0 cyber-mesh opacity-[0.15] dark:opacity-50"></div>
    <div class="absolute inset-0 hologram-grid opacity-[0.1] dark:opacity-30"></div>
    
    <!-- Partículas -->
    <div ref="particlesContainer" class="absolute inset-0 pointer-events-none z-10"></div>
 
    <!-- Luces de Ambiente -->
    <div class="absolute top-[-10%] right-[-5%] w-[300px] md:w-[600px] h-[300px] md:h-[600px] bg-primary-container/20 rounded-full blur-[100px] md:blur-[140px] animate-pulse"></div>
    <div class="absolute bottom-[-10%] left-[-5%] w-[250px] md:w-[500px] h-[250px] md:h-[500px] bg-tertiary-container/15 rounded-full blur-[100px] md:blur-[120px]"></div>
 
    <main class="relative z-20 w-full max-w-[440px] px-6">
      <!-- Header -->
      <div class="text-center mb-10">
        <div class="inline-block relative cursor-pointer group" @click="$router.push('/')">
          <AppLogo :img-style="{ height: 'clamp(3rem, 7vw, 5rem)' }" img-class="w-auto object-contain mx-auto mb-2 group-hover:scale-105 transition-transform" />
        </div>
        <p class="text-on-surface-variant tracking-[0.4em] uppercase text-[9px] font-bold opacity-70">Renewable Energy Elite</p>
      </div>
 
      <!-- Card -->
      <div class="glass-card-premium p-8 md:p-12 rounded-[40px] shadow-2xl relative overflow-hidden group/card border-accent-neon/10">
        <div class="absolute inset-0 bg-gradient-to-br from-accent-neon/5 to-transparent"></div>
        
        <div class="relative z-10">
          <h2 class="text-2xl md:text-3xl font-black text-on-surface mb-2 font-lexend">Nueva Contraseña</h2>
          <p class="text-on-surface-variant text-sm mb-10 font-light">Establece tu nueva clave de acceso para continuar.</p>
          
          <div v-if="success" class="text-center space-y-6">
            <div class="w-16 h-16 bg-accent-neon/20 rounded-full flex items-center justify-center mx-auto">
              <span class="material-symbols-outlined text-accent-neon text-3xl">verified</span>
            </div>
            <p class="text-on-surface text-sm font-medium">¡Contraseña actualizada! Ya puedes iniciar sesión con tu nueva clave.</p>
            <button @click="$router.push('/login')" class="btn-premium btn-primary-neon w-full py-4">
              Ir al Login
            </button>
          </div>

          <form v-else class="space-y-6" @submit.prevent="handleReset">
            <div class="space-y-2">
              <label class="block text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Nueva Contraseña</label>
              <div class="relative">
                <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant/40 text-xl">lock</span>
                <input v-model="password" class="input-cyber" placeholder="••••••••" type="password" required minlength="8"/>
              </div>
            </div>

            <div class="space-y-2">
              <label class="block text-[10px] font-black text-on-surface-variant uppercase tracking-[0.2em] ml-1">Confirmar Contraseña</label>
              <div class="relative">
                <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-on-surface-variant/40 text-xl">lock_reset</span>
                <input v-model="confirmPassword" class="input-cyber" placeholder="••••••••" type="password" required minlength="8"/>
              </div>
            </div>

            <div v-if="error" class="text-error text-[10px] uppercase font-bold tracking-widest text-center animate-bounce">
              {{ error }}
            </div>

            <button :disabled="loading || !token" class="btn-premium btn-primary-neon w-full py-4 mt-4 relative overflow-hidden" type="submit">
              <div v-if="loading" class="shimmer-effect"></div>
              <span v-if="!loading" class="flex items-center justify-center gap-2">
                Actualizar Credenciales
                <span class="material-symbols-outlined text-sm">security</span>
              </span>
              <span v-else class="flex items-center justify-center gap-2 font-black tracking-widest uppercase text-[10px]">
                <div class="animate-spin rounded-full h-4 w-4 border-t-2 border-primary mr-2"></div>
                Encriptando y Guardando...
              </span>
            </button>

            <div v-if="!token" class="text-error text-[9px] text-center uppercase font-bold tracking-widest mt-4">
              Token de recuperación no válido o ausente.
            </div>
          </form>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import AppLogo from '@/components/global/AppLogo.vue'
import { useRoute, useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { useNotificationStore } from '@/stores/notificationStore'

const route = useRoute()
const router = useRouter()
const authStore = useAuthStore()
const notificationStore = useNotificationStore()
const particlesContainer = ref(null)

const password = ref('')
const confirmPassword = ref('')
const error = ref('')
const success = ref(false)
const loading = ref(false)
const token = ref(route.query.token || '')

onMounted(() => {
  if (particlesContainer.value) {
    for(let i=0; i<40; i++){
      const p = document.createElement('div');
      p.className = 'energy-particle';
      p.style.left = Math.random() * 100 + '%';
      p.style.top = Math.random() * 100 + '%';
      p.style.animationDelay = Math.random() * 15 + 's';
      p.style.opacity = Math.random() * 0.5;
      particlesContainer.value.appendChild(p);
    }
  }
})

const handleReset = async () => {
  if (password.value !== confirmPassword.value) {
    error.value = 'Las contraseñas no coinciden'
    return
  }

  error.value = ''
  loading.value = true
  
  try {
    await authStore.resetPassword({
      token: token.value,
      newPassword: password.value
    })
    success.value = true
    notificationStore.addNotification({
      title: 'Contraseña Actualizada',
      message: 'Tu acceso ha sido restaurado correctamente.',
      type: 'success'
    })
  } catch (err) {
    console.error('Error en restablecimiento:', err)
    const msg = err.response?.data?.message || 'Error al restablecer la contraseña'
    error.value = msg
    notificationStore.addNotification({
      title: 'Error de Actualización',
      message: msg,
      type: 'error'
    })
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-wrapper {
    min-height: 100vh;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}
.cyber-mesh {
    background: radial-gradient(circle at 20% 30%, var(--accent-neon-dim, rgba(16, 255, 157, 0.1)) 0%, transparent 40%),
                radial-gradient(circle at 80% 70%, var(--accent-solar-dim, rgba(255, 215, 0, 0.05)) 0%, transparent 40%);
}

.hologram-grid {
    background-image: linear-gradient(var(--accent-neon-dim, rgba(16, 255, 157, 0.03)) 1px, transparent 1px),
                      linear-gradient(90deg, var(--accent-neon-dim, rgba(16, 255, 157, 0.03)) 1px, transparent 1px);
    background-size: 60px 60px;
}

.glass-card-premium {
    background: var(--glass-bg);
    backdrop-filter: blur(40px);
    border: 1px solid var(--glass-border);
    box-shadow: var(--shadow-premium);
}



.input-cyber {
    width: 100%;
    background-color: var(--input-bg);
    border: 1px solid var(--input-border);
    border-radius: 1rem;
    padding: 1rem 1.5rem 1rem 3rem;
    color: var(--on-surface);
    font-size: 0.875rem;
    transition: all 0.3s ease;
    outline: none;
}
.input-cyber:focus {
    border-color: var(--accent-neon);
    box-shadow: 0 0 0 4px var(--accent-neon-dim, rgba(16, 255, 157, 0.1));
}

:deep(.energy-particle) {
    position: absolute;
    width: 2px;
    height: 2px;
    background: var(--accent-neon);
    border-radius: 50%;
    filter: blur(1px);
    animation: float-particle 20s infinite linear;
}
@keyframes float-particle {
    0% { transform: translateY(110vh) scale(0); opacity: 0; }
    10% { opacity: 0.5; scale: 1; }
    90% { opacity: 0.5; scale: 1; }
    100% { transform: translateY(-10vh) scale(0); opacity: 0; }
}
</style>
