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
 
    <main class="relative z-20 w-full max-w-[440px] px-6">
      <!-- Header -->
      <div class="text-center mb-10">
        <AppLogo :img-style="{ height: 'clamp(3rem, 7vw, 5rem)' }" img-class="w-auto object-contain mx-auto mb-2" />
        <p class="text-on-surface-variant tracking-[0.4em] uppercase text-[9px] font-bold opacity-70">Verificación de Identidad</p>
      </div>
 
      <!-- Card -->
      <div class="glass-card-premium p-8 md:p-12 rounded-[40px] shadow-2xl relative overflow-hidden group/card border-accent-neon/10">
        <div class="relative z-10 text-center">
          <div v-if="status === 'loading'" class="space-y-6">
            <div class="loader-cyber mx-auto"></div>
            <p class="text-on-surface-variant text-sm font-light uppercase tracking-widest">Validando credenciales...</p>
          </div>

          <div v-if="status === 'success'" class="space-y-6">
            <div class="w-16 h-16 bg-accent-neon/20 rounded-full flex items-center justify-center mx-auto">
              <span class="material-symbols-outlined text-accent-neon text-3xl">verified_user</span>
            </div>
            <h2 class="text-2xl font-black text-on-surface font-lexend">¡Email Verificado!</h2>
            <p class="text-on-surface-variant text-sm font-light">Tu cuenta ha sido activada correctamente. Ya tienes acceso completo a la plataforma.</p>
            <button @click="$router.push('/login')" class="btn-premium btn-primary-neon w-full py-4 mt-4">
              Ir al Dashboard
            </button>
          </div>

          <div v-if="status === 'error'" class="space-y-6">
            <div class="w-16 h-16 bg-error/20 rounded-full flex items-center justify-center mx-auto">
              <span class="material-symbols-outlined text-error text-3xl">error</span>
            </div>
            <h2 class="text-2xl font-black text-error font-lexend">Error de Validación</h2>
            <p class="text-on-surface-variant text-sm font-light">{{ errorMessage }}</p>
            <button @click="$router.push('/login')" class="btn-premium btn-secondary-glass w-full py-4 mt-4">
              Volver al Inicio
            </button>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import AppLogo from '@/components/global/AppLogo.vue'
import { useRoute } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const route = useRoute()
const authStore = useAuthStore()
const particlesContainer = ref(null)

const status = ref('loading') // loading, success, error
const errorMessage = ref('')

onMounted(async () => {
  // Animación partículas
  if (particlesContainer.value) {
    for(let i=0; i<30; i++){
      const p = document.createElement('div');
      p.className = 'energy-particle';
      p.style.left = Math.random() * 100 + '%';
      p.style.top = Math.random() * 100 + '%';
      p.style.animationDelay = Math.random() * 10 + 's';
      particlesContainer.value.appendChild(p);
    }
  }

  // Lógica de verificación
  const token = route.query.token
  if (!token) {
    status.value = 'error'
    errorMessage.value = 'Token de verificación no proporcionado.'
    return
  }

  try {
    await authStore.verifyEmail(token)
    status.value = 'success'
  } catch (err) {
    console.error('Error verificando email:', err)
    status.value = 'error'
    errorMessage.value = err.response?.data?.message || 'El enlace ha expirado o no es válido.'
  }
})
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



.loader-cyber {
    width: 48px;
    height: 48px;
    border: 2px solid var(--accent-neon-dim);
    border-radius: 50%;
    position: relative;
    animation: rotate 1s linear infinite;
}
.loader-cyber::after {
    content: '';
    position: absolute;
    top: -2px; left: -2px;
    width: 48px; height: 48px;
    border: 2px solid transparent;
    border-top-color: var(--accent-neon);
    border-radius: 50%;
}

@keyframes rotate {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
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
