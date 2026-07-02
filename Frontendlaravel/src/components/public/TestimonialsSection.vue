<template>
  <section id="socios" class="py-20 md:py-40 relative overflow-hidden">
    <div class="w-full max-w-[1400px] mx-auto px-6 relative z-10">
      <div class="text-center mb-16 md:mb-24 animate-in fade-in slide-in-from-top duration-1000">
        <span class="text-accent-neon font-black tracking-[0.5em] uppercase text-[10px] mb-4 block">Lo que dicen de nosotros</span>
        <h2 class="font-lexend text-4xl md:text-5xl font-black text-on-surface ">Historias de <span class="text-gradient-neon not-italic">Éxito</span></h2>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8 md:gap-12">
        <div v-for="(testimonial, index) in testimonials" :key="index"
             :class="['glass-premium p-8 md:p-14 relative group/card transition-all duration-500 hover:-translate-y-2', testimonial.roundedClass, testimonial.extraClass, testimonial.borderClass, 'animate-in fade-in slide-in-from-bottom duration-700 shadow-xl hover:shadow-[0_20px_60px_rgba(0,0,0,0.1)]']"
             :style="{ 'animation-delay': `${index * 150}ms` }">
          
          <!-- Ícono de Cita -->
          <span :class="['text-8xl md:text-9xl absolute -top-6 -left-6 md:-top-8 md:-left-8 opacity-10 font-serif transition-all duration-500 group-hover/card:opacity-20 group-hover/card:scale-110', testimonial.iconClass]">“</span>
          
          <p class="text-on-surface/80  mb-8 md:mb-12 leading-relaxed text-lg font-light relative z-10">
            "{{ testimonial.text }}"
          </p>
          
          <div class="flex items-center gap-4 md:gap-6 relative z-10">
            <div :class="['w-16 h-16 md:w-20 md:h-20 rounded-2xl overflow-hidden border-2 flex-shrink-0 transition-all duration-500', testimonial.imageBorderClass, testimonial.imageRotateClass, testimonial.imageGlowClass, 'group-hover/card:scale-110 group-hover/card:rotate-0']">
              <img :alt="testimonial.name" class="w-full h-full object-cover" :src="testimonial.image"/>
            </div>
            <div>
              <h5 class="font-black text-on-surface text-lg leading-tight">{{ testimonial.name }}</h5>
              <p :class="['text-[10px] font-black uppercase tracking-[0.2em] mt-1', testimonial.accentTextClass]">{{ testimonial.role }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref } from 'vue'

const testimonials = ref([
  {
    name: 'Ricardo Mendoza',
    role: 'Ingeniero de Proyectos',
    text: 'La calidad técnica de los instructores superó mis expectativas. Hoy lidero proyectos de micro-redes solares.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAUtX9fiucdIJOlxhOcpmwvVZ6y7YRGY6QqPxmP9C3XgNNPDIXP6j972M-wiS9XblAoo3FyAIU8RYhgCnyPHkHJzAW51fWwwsPFdGZEmH57IV3AvdHHYCisAwTAs5NpTOwFjveWB_lgTekpVsSkIWfFJDpIXT42pef9NYtBYr2_arufxAYmcWVrMa2BLkgAG28SLjanZ_mPjFo9GJVuCXha41GuOQU_LmYeulE4FhjE0rhPHzWJ-As3l6CnZ1sGBunh7n7cTWdIfFBJ',
    roundedClass: 'rounded-organic-1',
    iconClass: 'icon-gradient',
    accentTextClass: 'text-accent-neon',
    imageBorderClass: 'border-accent-neon/40',
    imageRotateClass: 'rotate-6',
    imageGlowClass: 'glow-neon',
    extraClass: '',
    borderClass: ''
  },
  {
    name: 'Lucía Vargas',
    role: 'Directora Técnica',
    text: 'El enfoque práctico en IoT me permitió digitalizar nuestra planta industrial en tiempo récord.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCdddkNFTemmdZU3pc5Po8z3-1PiGcoxqqsi5RWXfm7wacW18S7jUsp-iV1tQXw8dB-MYnMWAPaXInffZwnJD_XqIsrtuRmXdIkcG54zg0QBWZPcBFUglFfvVx4DwdG9aU0fUyPv1kr9HcUG9lLfqiJ47KwrjwovzeQmx7XJnAdPQ1DNGUJ0MWEO-EYeg__zOHqqdBoHL-puC6wQS-kvB9XM7ywpUwqOnlA2XCOPL6FtGc9qFXd8WupKacb9xxBZMZK8ehlNojjKNVSYDdxOP',
    roundedClass: 'rounded-premium',
    iconClass: 'text-accent-solar',
    accentTextClass: 'text-accent-solar',
    imageBorderClass: 'border-accent-solar/40',
    imageRotateClass: '-rotate-6',
    imageGlowClass: 'glow-solar',
    extraClass: 'lg:-translate-y-8',
    borderClass: 'border-accent-solar/20'
  },
  {
    name: 'Andrés Castro',
    role: 'Estudiante de Élite',
    text: 'Enervida enseña una visión de futuro. Es el complemento ideal para cualquier carrera de ingeniería.',
    image: 'https://lh3.googleusercontent.com/aida-public/AB6AXuD_9kyFyN8Eptqy-zzVV2IgGQHMsNnlAzkSuIl1vFKS51oMuyxI1lESedMNFGQyXwSBS-ruwcAWGEuT8jsQ0bhU90f81QcJuNKGJoCZCWXP2sS3Bfcv4n27nFwSq-JJ6EIu9uk8n-xEeunLTXu3v42DSXz9BTPe1WLnxhzdGD8YAPv8M9T1Otw7pYO-Vw_zfOPrr7AhWx8CNeI8cjWMx8Bz_Cv42OgypSVJjrpr-h5wtKxVDxZ1tfiDBtmtez50kK9s5etWOcDgH-mzUSKQGu0qOPwIrcUpalnBdAIHkXvbnhoTFu_yYJc7dQAGSR0laNCQBqXRVqRkEMoe14bK2ZQfsa',
    roundedClass: 'rounded-organic-2',
    iconClass: 'icon-gradient',
    accentTextClass: 'text-accent-neon',
    imageBorderClass: 'border-accent-neon/40',
    imageRotateClass: 'rotate-12',
    imageGlowClass: 'glow-neon',
    extraClass: '',
    borderClass: ''
  }
])
</script>

<style scoped>
/* Las clases comunes ya están en main.css */
</style>
