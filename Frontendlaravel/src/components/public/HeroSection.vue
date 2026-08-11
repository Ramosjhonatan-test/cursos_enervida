<template>
  <section id="inicio" class="relative min-h-screen flex items-center pt-32 pb-20 overflow-hidden bg-background">
    <!-- Soft Background Elements -->
    <div class="absolute inset-0 z-0 opacity-30 dark:opacity-20 pointer-events-none">
      <div class="absolute top-0 left-1/4 w-[500px] h-[500px] bg-accent-neon/10 rounded-full blur-[120px]"></div>
      <div class="absolute bottom-0 right-1/4 w-[400px] h-[400px] bg-accent-solar/5 rounded-full blur-[100px]"></div>
    </div>

    <!-- Branding Watermark -->
    <div class="absolute top-1/2 left-0 -translate-y-1/2 -translate-x-1/4 opacity-[0.15] dark:opacity-[0.1] pointer-events-none z-0">
      <img src="/logo-dark.webp" alt="Watermark" class="w-[800px] lg:w-[1200px] grayscale brightness-0 invert dark:invert-0 blur-[3px]" loading="lazy" fetchpriority="low" decoding="async" />
    </div>

    <div class="w-full max-w-[1400px] mx-auto px-6 grid lg:grid-cols-2 gap-12 lg:gap-20 items-center relative z-10">
      <!-- Content Column -->
      <div class="space-y-8 animate-in fade-in slide-in-from-left duration-1000">
        <div class="inline-flex items-center gap-2 px-4 py-1.5 rounded-full bg-accent-neon/10 border border-accent-neon/20">
          <span class="w-2 h-2 bg-accent-neon rounded-full animate-pulse"></span>
          <span class="text-[10px] font-bold tracking-widest uppercase text-accent-neon">Academia de Energía Sostenible</span>
        </div>
        
        <h1 class="font-lexend font-black text-5xl md:text-6xl lg:text-7xl text-on-surface leading-[1.1] tracking-tight">
          Impulsa tu carrera en <br/>
          <span class="text-gradient-neon">Energía Renovable</span>
        </h1>
        
        <p class="text-lg md:text-xl text-on-surface-variant max-w-xl leading-relaxed font-medium">
          Domina las tecnologías que están transformando el mundo con educación técnica de élite y certificación internacional.
        </p>
        
        <div class="flex flex-col sm:flex-row gap-4 pt-4">
          <button @click="$router.push('/login')" class="btn-premium btn-primary-neon !px-10 !py-4 shadow-neon-sm">
            Empezar ahora
          </button>
          <button @click="$router.push('/cursos/vivenciales')" class="btn-premium btn-secondary-glass !px-10 !py-4">
            Ver Cursos
          </button>
        </div>

        <div class="flex items-center gap-6 pt-8 border-t border-on-surface/5">
          <div class="flex -space-x-3">
            <div v-for="i in 4" :key="i" class="w-10 h-10 rounded-full border-2 border-background bg-surface-container flex items-center justify-center text-[10px] font-bold overflow-hidden">
              <img :src="`https://i.pravatar.cc/100?img=${i+10}`" alt="User" loading="lazy" decoding="async" />
            </div>
          </div>
          <p class="text-sm text-on-surface-variant font-semibold">
            <span class="text-on-surface font-bold">+500 profesionales</span> ya están aprendiendo
          </p>
        </div>
      </div>

      <!-- Visual Column -->
      <div class="relative animate-in fade-in slide-in-from-right duration-1000 delay-200">
        <div class="relative z-10 rounded-[3rem] overflow-hidden shadow-2xl border border-white/5 aspect-square lg:aspect-[4/3] group">
          <img 
            alt="Sustainable Energy Tech" 
            class="w-full h-full object-cover transition-all duration-1000 group-hover:scale-110 group-hover:rotate-1" 
            src="https://www.solartechmexico.com/wp-content/uploads/2024/02/cuanto_cuesta_poner_paneles_solares_en_mexico.webp"
            fetchpriority="high"
            loading="eager"
            decoding="sync"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-background via-transparent to-transparent opacity-60"></div>
          
          <!-- Floating UI Element with Enhanced Glass -->
          <div class="absolute bottom-8 left-8 right-8 p-8 glass-premium rounded-[2rem] border border-white/10 shadow-2xl animate-float backdrop-blur-3xl bg-white/5">
            <div class="flex items-center justify-between">
              <div class="space-y-1">
                <div class="flex items-center gap-2">
                  <span class="w-1.5 h-1.5 bg-accent-neon rounded-full animate-pulse"></span>
                  <p class="text-[9px] uppercase tracking-[0.3em] font-black text-accent-neon">Sesión en Vivo</p>
                </div>
                <h4 class="text-base font-black text-on-surface font-lexend">Sistemas Fotovoltaicos Avanzados</h4>
                <p class="text-[11px] text-on-surface-variant font-medium">Instructor: Ing. Carlos Méndez</p>
              </div>
              <div class="flex flex-col items-center gap-2">
                <!--redirige a solo ala pantall de login-->
                <button @click="$router.push('/login')" class="btn-premium btn-primary-neon !px-10 !py-4 shadow-neon-sm">
                  Unirse
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Background Decorative Orbs -->
        <div class="absolute -top-20 -right-20 w-64 h-64 bg-accent-solar/10 rounded-full blur-[100px] animate-pulse"></div>
        <div class="absolute -bottom-20 -left-20 w-64 h-64 bg-accent-neon/10 rounded-full blur-[100px] animate-pulse delay-700"></div>
      </div>
    </div>
  </section>
</template>

<script setup>
</script>

<style scoped>
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.animate-float {
  animation: float 4s ease-in-out infinite;
}

.text-gradient-neon {
  background: linear-gradient(135deg, var(--accent-neon) 0%, var(--accent-solar) 100%);
  -webkit-background-clip : text;
  -webkit-text-fill-color: transparent;
  display: inline-block;
}
</style>
