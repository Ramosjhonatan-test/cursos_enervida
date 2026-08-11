<script setup>
import Navbar from '@/components/public/Navbar.vue'
import HeroSection from '@/components/public/HeroSection.vue'
import CoursesSection from '@/components/public/CoursesSection.vue'
import BenefitsSection from '@/components/public/BenefitsSection.vue'
import TestimonialsSection from '@/components/public/TestimonialsSection.vue'
import CTASection from '@/components/public/CTASection.vue'
import Footer from '@/components/public/Footer.vue'
import Contact from '@/components/public/Contact.vue'
</script>

<template>
  <div class="mesh-gradient min-h-screen w-full overflow-x-hidden">
    <Navbar />
    <main>
      <HeroSection />
      <CoursesSection />
      <BenefitsSection />
      <TestimonialsSection />
      <CTASection />
      <Contact/>
    </main>
    <Footer />
  </div>
</template>

