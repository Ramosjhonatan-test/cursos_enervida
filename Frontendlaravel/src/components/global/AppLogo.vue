<template>
  <img
    :src="logoSrc"
    :alt="alt"
    :class="imgClass"
    :style="imgStyle"
    draggable="false"
  />
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'

const props = defineProps({
  alt: { type: String, default: 'Enervida — Energía que da vida' },
  imgClass: { type: [String, Array, Object], default: '' },
  imgStyle: { type: [String, Object], default: '' },
})

const isDark = ref(false)

const checkTheme = () => {
  isDark.value = document.documentElement.classList.contains('dark')
}

let observer = null

onMounted(() => {
  checkTheme()
  // Watch for class changes on <html> to react to theme toggles
  observer = new MutationObserver(checkTheme)
  observer.observe(document.documentElement, {
    attributes: true,
    attributeFilter: ['class'],
  })
})

onUnmounted(() => {
  observer?.disconnect()
})

// logo-dark.webp = dark text → light backgrounds
// logo-light.webp = light text → dark backgrounds
const logoSrc = computed(() => isDark.value ? '/logo-light.webp' : '/logo-dark.webp')
</script>
