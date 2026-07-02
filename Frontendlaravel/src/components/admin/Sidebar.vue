<template>
  <aside :class="['fixed top-0 left-0 h-screen transition-all duration-500 z-[100] p-4', collapsed ? 'w-24' : 'w-72']">
    <div class="glass-card h-full rounded-[32px] flex flex-col border border-on-surface/5 shadow-2xl relative overflow-hidden">
      <!-- Background Glow -->
      <div class="absolute -top-24 -left-24 w-48 h-48 bg-accent-neon/5 blur-[100px] pointer-events-none"></div>
      
      <!-- Logo Section -->
      <div class="p-6 mb-2 relative">
        <div class="flex items-center gap-3 overflow-hidden">
          <div class="w-10 h-10 rounded-2xl bg-accent-neon flex items-center justify-center shrink-0 shadow-neon-sm">
            <span class="material-symbols-outlined text-black font-bold">bolt</span>
          </div>
          <div v-if="!collapsed" class="flex flex-col animate-fade-in">
            <span class="text-lg font-black text-on-surface tracking-tighter leading-none font-lexend uppercase">LMS<span class="text-accent-neon italic ml-0.5">PRO</span></span>
            <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-[0.2em]">Administración</span>
          </div>
        </div>
      </div>

      <!-- Navigation -->
      <nav class="flex-1 overflow-y-auto px-4 custom-scrollbar space-y-8 pb-10">
        <!-- Dashboard Group -->
        <div v-if="authStore.canAccess('DASHBOARD')" class="space-y-1">
          <label v-if="!collapsed" class="text-[9px] font-black text-on-surface/20 uppercase tracking-[0.2em] ml-3 mb-2 block">Principal</label>
          <router-link to="/admin" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">dashboard</span>
            <span v-if="!collapsed" class="nav-label">Dashboard</span>
          </router-link>
        </div>

        <!-- Académico Group -->
        <div v-if="hasAcademicoAccess" class="space-y-1">
          <label v-if="!collapsed" class="text-[9px] font-black text-on-surface/20 uppercase tracking-[0.2em] ml-3 mb-2 block">Académico</label>
          <router-link v-if="authStore.canAccess('CURSOS')" to="/admin/cursos" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">menu_book</span>
            <span v-if="!collapsed" class="nav-label">Cursos</span>
          </router-link>
          <router-link v-if="authStore.canAccess('INSCRIPCIONES')" to="/admin/inscripciones" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">person_add</span>
            <span v-if="!collapsed" class="nav-label">Inscripciones</span>
          </router-link>
          <router-link v-if="authStore.canAccess('CLASES_VIVO')" to="/admin/clases-vivo" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">video_call</span>
            <span v-if="!collapsed" class="nav-label">Clases Vivo</span>
          </router-link>
          <router-link v-if="authStore.canAccess('CERTIFICADOS')" to="/admin/certificados" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">workspace_premium</span>
            <span v-if="!collapsed" class="nav-label">Certificados</span>
          </router-link>
        </div>

        <!-- Usuarios Group -->
        <div v-if="hasUsuariosAccess" class="space-y-1">
          <label v-if="!collapsed" class="text-[9px] font-black text-on-surface/20 uppercase tracking-[0.2em] ml-3 mb-2 block">Comunidad</label>
          <router-link v-if="authStore.canAccess('ESTUDIANTES')" to="/admin/estudiantes" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">group</span>
            <span v-if="!collapsed" class="nav-label">Estudiantes</span>
          </router-link>
          <router-link v-if="authStore.canAccess('USUARIOS')" to="/admin/personal" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">person_manage</span>
            <span v-if="!collapsed" class="nav-label">Personal / Staff</span>
          </router-link>
        </div>

        <!-- Sistema Group -->
        <div v-if="hasSistemaAccess" class="space-y-1">
          <label v-if="!collapsed" class="text-[9px] font-black text-on-surface/20 uppercase tracking-[0.2em] ml-3 mb-2 block">Sistema</label>
          <router-link v-if="authStore.canAccess('AUDITORIA')" to="/admin/auditoria" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">history</span>
            <span v-if="!collapsed" class="nav-label">Auditoría</span>
          </router-link>
          <router-link v-if="authStore.canAccess('ROLES')" to="/admin/roles" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">security</span>
            <span v-if="!collapsed" class="nav-label">Roles y Permisos</span>
          </router-link>
          <router-link v-if="authStore.canAccess('DISPOSITIVOS')" to="/admin/dispositivos" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">devices</span>
            <span v-if="!collapsed" class="nav-label">Seguridad Web</span>
          </router-link>
          <router-link v-if="authStore.canAccess('CONFIG')" to="/admin/configuracion" class="nav-item group" active-class="active">
            <span class="material-symbols-outlined">settings</span>
            <span v-if="!collapsed" class="nav-label">Ajustes</span>
          </router-link>
        </div>
      </nav>

      <!-- Footer Info -->
      <div v-if="!collapsed" class="p-6 border-t border-on-surface/5">
        <div class="bg-on-surface/[0.03] p-4 rounded-2xl border border-on-surface/5">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest mb-2">Usuario Actual</p>
          <div class="flex items-center gap-3">
            <div class="w-8 h-8 rounded-lg bg-accent-neon flex items-center justify-center text-black font-black text-[10px]">
              {{ authStore.user?.nombres?.charAt(0) }}{{ authStore.user?.apellidos?.charAt(0) }}
            </div>
            <div class="flex flex-col min-w-0">
              <span class="text-[11px] font-black text-on-surface truncate">{{ authStore.user?.nombres }}</span>
              <span class="text-[9px] font-bold text-accent-neon uppercase tracking-tighter">{{ authStore.userRole }}</span>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Collapse Button -->
      <button @click="collapsed = !collapsed" class="absolute bottom-6 right-0 translate-x-1/2 w-8 h-8 rounded-full bg-surface border border-on-surface/10 flex items-center justify-center text-on-surface/40 hover:text-accent-neon hover:border-accent-neon transition-all z-10">
        <span class="material-symbols-outlined text-sm">{{ collapsed ? 'chevron_right' : 'chevron_left' }}</span>
      </button>
    </div>
  </aside>
</template>

<script setup>
import { ref, computed } from 'vue';
import { useAuthStore } from '@/stores/auth';

const authStore = useAuthStore();
const collapsed = ref(false);

const hasAcademicoAccess = computed(() => {
  return authStore.canAccess('CURSOS') || 
         authStore.canAccess('INSCRIPCIONES') || 
         authStore.canAccess('CLASES_VIVO') || 
         authStore.canAccess('CERTIFICADOS');
});

const hasUsuariosAccess = computed(() => {
  return authStore.canAccess('ESTUDIANTES') || 
         authStore.canAccess('USUARIOS');
});

const hasSistemaAccess = computed(() => {
  return authStore.canAccess('AUDITORIA') || 
         authStore.canAccess('ROLES') || 
         authStore.canAccess('DISPOSITIVOS') || 
         authStore.canAccess('CONFIG');
});
</script>

<style scoped>
.nav-item {
  @apply flex items-center gap-3 px-4 py-3 rounded-2xl text-on-surface/60 transition-all duration-300 relative overflow-hidden;
}

.nav-item:hover {
  @apply bg-on-surface/[0.04] text-on-surface;
}

.nav-item.active {
  @apply bg-accent-neon/10 text-accent-neon font-black shadow-[0_0_20px_rgba(0,255,153,0.05)];
}

.nav-item.active::before {
  content: '';
  @apply absolute left-0 top-1/4 bottom-1/4 w-1 bg-accent-neon rounded-r-full shadow-neon-sm;
}

.nav-label {
  @apply text-xs font-bold uppercase tracking-widest whitespace-nowrap;
}

.material-symbols-outlined {
  @apply text-[20px] transition-transform duration-300;
}

.nav-item:hover .material-symbols-outlined {
  @apply scale-110;
}

.custom-scrollbar::-webkit-scrollbar {
  width: 3px;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  @apply bg-on-surface/10 rounded-full;
}
</style>
