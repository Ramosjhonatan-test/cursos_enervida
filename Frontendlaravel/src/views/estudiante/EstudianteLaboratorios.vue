<template>
  <section class="space-y-10 animate-in fade-in">
    <EstudiantePageHeader
      eyebrow="Practica aplicada"
      title="Laboratorios"
      highlight="Proximamente"
      description="Deje esta vista lista para crecer sin romper el orden general del campus cuando entren los laboratorios."
      :stats="headerStats"
    />

    <div class="student-panel relative overflow-hidden px-8 py-14 text-center md:px-12 md:py-20">
      <div class="absolute inset-0 bg-[radial-gradient(circle_at_top,_rgba(5,150,105,0.12),_transparent_40%)]"></div>
      <div class="relative z-10 mx-auto max-w-2xl">
        <div class="mx-auto mb-8 flex h-24 w-24 items-center justify-center rounded-[32px] border border-accent-neon/20 bg-accent-neon/10 shadow-inner">
          <span class="material-symbols-outlined text-5xl text-accent-neon">science</span>
        </div>
        <h2 class="mb-6 font-lexend text-4xl font-black tracking-tight md:text-5xl">
          Modulo en <span class="text-gradient-neon">Construccion</span>
        </h2>
        <p class="mx-auto max-w-xl text-base leading-8 text-on-surface/55">
          Estamos preparando esta seccion para experiencias practicas, laboratorios guiados y recursos descargables.
        </p>
        <router-link to="/student/dashboard" class="btn-premium btn-primary-neon mt-10 !inline-flex !px-10 !py-5">
          Volver al inicio
        </router-link>
      </div>
    </div>
  </section>
</template>

<script setup>
import EstudiantePageHeader from '@/components/estudiante/EstudiantePageHeader.vue'

const headerStats = [
  {
    label: 'Estado',
    value: 'En armado',
    help: 'Vista preparada para crecer sin perder coherencia',
    icon: 'construction',
  },
]
</script>
