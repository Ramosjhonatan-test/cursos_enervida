<template>
  <header class="student-page-header">
    <div class="flex flex-col gap-5 lg:flex-row lg:items-end lg:justify-between">
      <div class="max-w-3xl">
        <p class="student-page-eyebrow">{{ eyebrow }}</p>
        <h1 class="student-page-title">
          {{ title }}
          <span v-if="highlight" class="text-gradient-neon">{{ highlight }}</span>
        </h1>
        <p v-if="description" class="student-page-description">{{ description }}</p>
      </div>

      <div v-if="$slots.actions" class="flex shrink-0 flex-wrap gap-3">
        <slot name="actions" />
      </div>
    </div>
  </header>
</template>

<script setup>
defineProps({
  eyebrow: {
    type: String,
    default: '',
  },
  title: {
    type: String,
    default: '',
  },
  highlight: {
    type: String,
    default: '',
  },
  description: {
    type: String,
    default: '',
  }
})
</script>
