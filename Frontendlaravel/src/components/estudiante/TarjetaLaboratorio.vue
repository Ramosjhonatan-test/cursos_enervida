<template>
  <div 
    class="admin-card !border-none group relative overflow-hidden rounded-[40px] p-8 transition-all duration-500 hover:-translate-y-2 hover:shadow-2xl hover:shadow-accent-neon/10"
  >
    <!-- Background Decor -->
    <div class="absolute -right-10 -top-10 h-32 w-32 rounded-full bg-accent-neon/5 blur-3xl transition-all group-hover:bg-accent-neon/10"></div>
    
    <div class="relative z-10">
      <div 
        :class="[
          'mb-8 flex h-20 w-20 items-center justify-center rounded-3xl shadow-inner transition-all duration-500 group-hover:scale-110 !border-none',
          type === 'biotech' 
            ? 'bg-accent-neon/10 text-accent-neon' 
            : 'bg-accent-solar/10 text-accent-solar'
        ]"
      >
        <span class="material-symbols-outlined text-4xl font-black">{{ icon }}</span>
      </div>

      <div class="mb-6 flex items-center gap-3">
        <span 
          :class="[
            'rounded-full px-3 py-1 text-[8px] font-black uppercase tracking-widest',
            available ? 'bg-green-500/10 text-green-500' : 'bg-on-surface/5 text-on-surface/40'
          ]"
        >
          {{ available ? 'Disponible' : 'Próximamente' }}
        </span>
        <span class="text-[9px] font-black uppercase tracking-widest text-on-surface/20">{{ category }}</span>
      </div>

      <h3 class="font-lexend text-2xl font-black leading-tight tracking-tight">{{ title }}</h3>
      <p class="mt-4 line-clamp-3 text-sm leading-relaxed text-on-surface-variant opacity-60">
        {{ description }}
      </p>

      <div class="mt-10 flex items-center justify-between gap-4">
        <div class="flex -space-x-3">
          <div v-for="i in 3" :key="i" class="h-8 w-8 rounded-full bg-on-surface/10 !border-none shadow-sm"></div>
          <div class="flex h-8 w-8 items-center justify-center rounded-full bg-accent-neon/10 text-[8px] font-black text-accent-neon !border-none shadow-sm">
            +12
          </div>
        </div>
        
        <button 
          v-if="available"
          class="btn-premium btn-primary-neon !rounded-2xl !px-6 !py-3 !text-[10px]"
        >
          Acceder al Lab
          <span class="material-symbols-outlined text-sm">arrow_forward</span>
        </button>
        <span v-else class="text-[10px] font-black uppercase tracking-widest text-on-surface/25">En desarrollo</span>
      </div>
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: String,
  description: String,
  icon: String,
  type: {
    type: String,
    default: 'biotech'
  },
  available: {
    type: Boolean,
    default: false
  },
  category: String
})
</script>
