<template>
  <div class="space-y-3">
    <div class="flex justify-between items-center">
      <h2 class="text-lg font-semibold">Listado</h2>
      <button class="bg-primary text-white px-4 py-2 rounded-md">Nuevo</button>
    </div>
    <div class="bg-white/5 rounded-lg overflow-hidden">
      <table class="min-w-full">
        <thead class="bg-surface-glass">
          <tr>
            <th class="p-3 text-left">#</th>
            <th class="p-3 text-left">Nombre</th>
            <th class="p-3 text-left">Estado</th>
            <th class="p-3">Acciones</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="n in 5" :key="n" class="border-t border-input-border">
            <td class="p-3 text-sm text-on-surface-variant">{{ n }}</td>
            <td class="p-3">Ejemplo {{ n }}</td>
            <td class="p-3"><span class="text-sm text-primary/80">activo</span></td>
            <td class="p-3 text-center">—</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
