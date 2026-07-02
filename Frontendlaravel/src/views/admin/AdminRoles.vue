<template>
  <div class="space-y-10 animate-fade-in text-on-surface pb-20">
    <!-- Header & Hero -->
    <div class="panel-hero p-10 relative overflow-hidden group rounded-[40px] bg-on-surface/[0.03] !border-none shadow-2xl">
      <div class="absolute -right-20 -top-20 w-80 h-80 bg-accent-neon/10 rounded-full blur-[100px] group-hover:bg-accent-neon/20 transition-all duration-1000"></div>
      <div class="absolute -left-20 -bottom-20 w-64 h-64 bg-primary/5 rounded-full blur-[80px]"></div>

      <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-8 relative z-10">
        <div class="flex-1">
          <div class="flex items-center gap-4 mb-3">
            <div class="w-16 h-16 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon shadow-neon-sm">
              <span class="material-symbols-outlined text-4xl">admin_panel_settings</span>
            </div>
            <div>
              <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter leading-none">
                Gestión de <span class="text-accent-neon italic">Roles</span>
              </h2>
              <p class="text-on-surface/40 mt-3 text-[10px] font-bold uppercase tracking-[0.3em] flex items-center gap-2">
                <span class="flex h-1.5 w-1.5 relative">
                  <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
                  <span class="relative inline-flex rounded-full h-1.5 w-1.5 bg-accent-neon"></span>
                </span>
                Configuración de Accesos y Permisos RBAC
              </p>
            </div>
          </div>
        </div>

        <button @click="toggleForm()" class="btn-premium btn-primary-neon !py-4 px-8 gap-3 group/btn">
          <span class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-90">{{ showForm ? 'close' : 'add_moderator' }}</span>
          <span class="font-bold tracking-widest uppercase text-xs">{{ showForm ? 'Cancelar' : 'Nuevo Rol' }}</span>
        </button>
      </div>
    </div>

    <!-- Inline Form Panel -->
    <transition name="slide-fade">
      <div v-if="showForm" class="glass-card p-8 sm:p-10 rounded-[40px] !border-none shadow-2xl relative overflow-hidden">
        <div class="absolute top-0 right-0 p-10 opacity-[0.02] pointer-events-none">
          <span class="material-symbols-outlined text-[120px]">{{ isEditing ? 'edit' : 'shield' }}</span>
        </div>

        <div class="flex items-center gap-4 mb-10">
          <div class="w-12 h-12 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
            <span class="material-symbols-outlined text-xl">{{ isEditing ? 'edit_square' : 'security' }}</span>
          </div>
          <div>
            <h3 class="text-xl font-black text-on-surface font-lexend tracking-tighter uppercase">
              {{ isEditing ? 'Editar' : 'Nuevo' }} <span class="text-accent-neon italic">Rol de Usuario</span>
            </h3>
            <p class="text-[10px] font-bold text-on-surface/30 uppercase tracking-[0.2em] mt-1">Define las capacidades y restricciones del perfil</p>
          </div>
        </div>

        <form @submit.prevent="saveRol" class="space-y-10">
          <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div class="flex flex-col gap-3">
              <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest ml-1">Identificador Único</label>
              <input type="text" v-model="form.nombre" :disabled="isEditing && isSystemRole(form.nombre)" required placeholder="Ej. administrador" class="input-cyber w-full uppercase !bg-on-surface/[0.04] !border-none" />
              <p v-if="isEditing && isSystemRole(form.nombre)" class="text-[9px] text-accent-neon/60 font-bold ml-1 mt-1 uppercase tracking-tighter italic">Rol de sistema (inmutable).</p>
            </div>

            <div class="lg:col-span-2 flex flex-col gap-3">
              <label class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest ml-1">Descripción de Alcance</label>
              <input type="text" v-model="form.info_visible" placeholder="Ej. Personal con acceso a gestión académica" class="input-cyber w-full !bg-on-surface/[0.04] !border-none" />
            </div>
          </div>

          <!-- Permisos Dinámicos -->
          <div class="space-y-6">
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-3">
                <span class="w-1.5 h-6 bg-accent-neon rounded-full"></span>
                <label class="text-[10px] font-black text-on-surface/60 uppercase tracking-[0.2em]">Módulos Habilitados (RBAC)</label>
              </div>
              <div class="flex gap-6">
                <button type="button" @click="selectAll" class="text-[10px] font-black text-on-surface/30 hover:text-accent-neon uppercase tracking-widest transition-colors">Seleccionar Todos</button>
                <button type="button" @click="selectNone" class="text-[10px] font-black text-on-surface/30 hover:text-red-500/60 uppercase tracking-widest transition-colors">Limpiar</button>
              </div>
            </div>
            
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-5">
              <div v-for="modulo in listaModulos" :key="modulo.id" 
                @click="toggleModulo(modulo.id)"
                :class="[
                  'cursor-pointer p-4 rounded-3xl transition-all duration-500 flex items-center gap-4 group/mod relative overflow-hidden',
                  'bg-on-surface/[0.04] shadow-sm',
                  permisosSeleccionados.includes(modulo.id) 
                    ? 'bg-accent-neon text-black shadow-neon-sm !-translate-y-1' 
                    : 'hover:bg-accent-neon hover:text-black hover:-translate-y-1 hover:shadow-neon-sm'
                ]"
              >
                <!-- Indicador de selección lateral -->
                <div v-if="permisosSeleccionados.includes(modulo.id)" class="absolute left-0 top-1/2 -translate-y-1/2 w-1.5 h-8 bg-black/20 rounded-r-full"></div>

                <div :class="[
                  'w-11 h-11 rounded-2xl flex items-center justify-center transition-all duration-500 shrink-0',
                  permisosSeleccionados.includes(modulo.id) ? 'bg-black/10 text-black scale-110' : 'bg-on-surface/5 text-on-surface/30 group-hover/mod:text-black group-hover/mod:bg-black/10 group-hover/mod:scale-110'
                ]">
                  <span class="material-symbols-outlined text-xl">{{ modulo.icon }}</span>
                </div>
                <div class="flex flex-col min-w-0">
                  <span :class="[
                    'text-[11px] font-black uppercase tracking-tight transition-colors truncate',
                    permisosSeleccionados.includes(modulo.id) ? 'text-black' : 'text-on-surface/60 group-hover/mod:text-black'
                  ]">{{ modulo.label }}</span>
                  <span :class="[
                    'text-[8px] font-black uppercase font-mono tracking-tighter transition-colors',
                    permisosSeleccionados.includes(modulo.id) ? 'text-black/40' : 'text-on-surface/20 group-hover/mod:text-black/40'
                  ]">{{ modulo.id }}</span>
                </div>
              </div>
            </div>
          </div>

          <div class="flex justify-end gap-4 pt-8">
            <button type="button" @click="showForm = false" class="btn-premium glass-card !bg-on-surface/[0.05] !border-none !py-4 px-8">Cancelar</button>
            <button type="submit" :disabled="saving" class="btn-premium btn-primary-neon !py-4 px-10 shadow-neon-sm">
              <span v-if="saving" class="animate-spin rounded-full h-4 w-4 border-t-2 border-primary"></span>
              <span v-else class="font-black uppercase text-xs tracking-widest">{{ isEditing ? 'Guardar Configuración' : 'Crear Rol Maestro' }}</span>
            </button>
          </div>
        </form>
      </div>
    </transition>

    <!-- Roles Table -->
    <div class="glass-card-premium rounded-[48px] overflow-hidden !border-none shadow-2xl">
      <div class="overflow-x-auto">
        <table class="w-full min-w-[800px] text-left border-separate border-spacing-0">
          <thead>
            <tr class="bg-on-surface/[0.03]">
              <th class="p-8 text-[10px] font-black text-on-surface/30 uppercase tracking-[0.2em]">Identificador del Rol</th>
              <th class="p-8 text-[10px] font-black text-on-surface/30 uppercase tracking-[0.2em]">Descripción / Alcance</th>
              <th class="p-8 text-[10px] font-black text-on-surface/30 uppercase tracking-[0.2em] text-right">Acciones Directas</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="rol in roles" :key="rol.id" class="group hover:bg-accent-neon/[0.02] transition-all duration-500 relative">
              <td class="p-8">
                <div class="flex items-center gap-5">
                  <div class="w-12 h-12 rounded-[18px] bg-on-surface/5 flex items-center justify-center text-on-surface/30 group-hover:text-accent-neon transition-all duration-500">
                    <span class="material-symbols-outlined text-xl">verified_user</span>
                  </div>
                  <div class="flex flex-col">
                    <span class="text-sm font-black text-on-surface uppercase tracking-tight group-hover:text-accent-neon transition-colors">{{ rol.nombre }}</span>
                    <span class="text-[8px] font-black text-on-surface/20 uppercase tracking-widest mt-0.5">ID: #{{ rol.id }}</span>
                  </div>
                </div>
              </td>
              <td class="p-8">
                <div class="flex flex-col gap-2">
                  <p class="text-xs text-on-surface/50 line-clamp-1 max-w-md group-hover:text-on-surface/70 transition-colors font-medium italic">"{{ rol.info_visible || 'Sin descripción detallada del perfil' }}"</p>
                  <div class="flex flex-wrap gap-2 mt-1">
                    <div v-if="rol.permisos && rol.permisos.length > 0" class="flex items-center gap-1.5 px-3 py-1 rounded-full bg-accent-neon/10 text-accent-neon">
                      <span class="w-1 h-1 rounded-full bg-accent-neon animate-pulse"></span>
                      <span class="text-[9px] font-black uppercase tracking-widest">{{ rol.permisos.length }} Módulos Habilitados</span>
                    </div>
                    <div v-else-if="rol.nombre === 'admin'" class="flex items-center gap-1.5 px-3 py-1 rounded-full bg-accent-neon/20 text-accent-neon shadow-neon-sm">
                      <span class="material-symbols-outlined text-[10px]">stars</span>
                      <span class="text-[9px] font-black uppercase tracking-widest">Acceso Total (Root)</span>
                    </div>
                    <div v-else class="flex items-center gap-1.5 px-3 py-1 rounded-full bg-on-surface/5 text-on-surface/30">
                      <span class="text-[9px] font-black uppercase tracking-widest">Sin Permisos</span>
                    </div>
                  </div>
                </div>
              </td>
              <td class="p-8 text-right">
                <div class="flex justify-end gap-3">
                  <button @click="openEdit(rol)" class="w-11 h-11 rounded-xl bg-blue-500/20 flex items-center justify-center text-blue-500 hover:bg-blue-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-sm hover:shadow-blue-500/40" title="Editar Configuración">
                    <span class="material-symbols-outlined text-xl">edit_note</span>
                  </button>
                  <button v-if="!isSystemRole(rol.nombre)" @click="deleteRol(rol.id)" class="w-11 h-11 rounded-xl bg-red-500/20 flex items-center justify-center text-red-500 hover:bg-red-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-sm hover:shadow-red-500/40" title="Eliminar Rol">
                    <span class="material-symbols-outlined text-xl">delete_sweep</span>
                  </button>
                </div>
              </td>
            </tr>
            <tr v-if="roles.length === 0">
              <td colspan="3" class="p-32 text-center">
                <div class="flex flex-col items-center gap-8 text-on-surface/10 animate-float">
                  <div class="w-24 h-24 rounded-full bg-on-surface/5 flex items-center justify-center">
                    <span class="material-symbols-outlined text-6xl">shield_off</span>
                  </div>
                  <div>
                    <h4 class="text-xl font-black text-on-surface font-lexend uppercase tracking-widest">Vórtice de Seguridad Vacío</h4>
                    <p class="text-[10px] font-bold text-on-surface/30 uppercase tracking-[0.3em] mt-3">No se han detectado perfiles configurados en el sistema</p>
                  </div>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Loading Overlay -->
    <div v-if="loading" class="fixed inset-0 bg-background/60 backdrop-blur-md z-[200] flex items-center justify-center">
      <div class="flex flex-col items-center gap-6">
        <div class="w-20 h-20 rounded-full border-t-2 border-accent-neon animate-spin shadow-neon"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-[0.5em] animate-pulse">Sincronizando RBAC</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '@/services/api';
import { useNotificationStore } from '@/stores/notificationStore';
import { useModalStore } from '@/stores/modalStore';

const roles = ref([]);
const loading = ref(true);
const saving = ref(false);
const showForm = ref(false);
const isEditing = ref(false);
const notificationStore = useNotificationStore();
const modalStore = useModalStore();

const form = ref({
  id: null,
  nombre: '',
  descripcion: '',
  info_visible: '' // Campo auxiliar para la descripción humana
});

const permisosSeleccionados = ref([]);

const listaModulos = [
  { id: 'DASHBOARD', label: 'Panel de Control', icon: 'grid_view' },
  { id: 'CURSOS', label: 'Gestión de Cursos', icon: 'auto_stories' },
  { id: 'CATEGORIAS', label: 'Categorías', icon: 'label' },
  { id: 'INSCRIPCIONES', label: 'Inscripciones', icon: 'person_add' },
  { id: 'ESTUDIANTES', label: 'Estudiantes', icon: 'group' },
  { id: 'CERTIFICADOS', label: 'Certificados', icon: 'workspace_premium' },
  { id: 'CLASES_VIVO', label: 'Clases en Vivo', icon: 'videocam' },
  { id: 'EVALUACIONES', label: 'Exámenes', icon: 'quiz' },
  { id: 'SOLICITUDES', label: 'Solicitudes', icon: 'assignment' },
  { id: 'AUDITORIA', label: 'Logs de Auditoría', icon: 'policy' },
  { id: 'ROLES', label: 'Roles y Permisos', icon: 'settings_accessibility' },
  { id: 'DISPOSITIVOS', label: 'Seguridad / Sesiones', icon: 'devices' },
  { id: 'USUARIOS', label: 'Personal (Staff)', icon: 'manage_accounts' },
  { id: 'NOTIFICACIONES', label: 'Notificaciones', icon: 'notifications' },
  { id: 'REPORTES', label: 'Estadísticas', icon: 'query_stats' },
  { id: 'ARCHIVOS', label: 'Gestor Archivos', icon: 'folder_open' },
  { id: 'CONFIG', label: 'Ajustes Generales', icon: 'settings' }
];

const toggleModulo = (id) => {
  if (permisosSeleccionados.value.includes(id)) {
    permisosSeleccionados.value = permisosSeleccionados.value.filter(p => p !== id);
  } else {
    permisosSeleccionados.value.push(id);
  }
};

const selectAll = () => {
  permisosSeleccionados.value = listaModulos.map(m => m.id);
};

const selectNone = () => {
  permisosSeleccionados.value = [];
};

const isSystemRole = (nombre) => {
  if (!nombre) return false;
  const n = nombre.toLowerCase();
  return n === 'admin' || n === 'estudiante' || n === 'instructor';
};

const fetchRoles = async () => {
  loading.value = true;
  try {
    const res = await api.get('/roles');
    roles.value = res.data.map(rol => {
      // Intentar parsear la descripción por si es JSON de permisos
      try {
        if (rol.descripcion && rol.descripcion.startsWith('{')) {
          const data = JSON.parse(rol.descripcion);
          return { ...rol, info_visible: data.info || '', permisos: data.permisos || [] };
        }
      } catch (e) { }
      return { ...rol, info_visible: rol.descripcion, permisos: [] };
    });
  } catch (error) {
    console.error('Error fetching roles:', error);
  } finally {
    loading.value = false;
  }
};

const toggleForm = () => {
  if (showForm.value) {
    showForm.value = false;
  } else {
    isEditing.value = false;
    form.value = { id: null, nombre: '', descripcion: '', info_visible: '' };
    permisosSeleccionados.value = [];
    showForm.value = true;
  }
};

const openEdit = (rol) => {
  isEditing.value = true;
  try {
    if (rol.descripcion && rol.descripcion.startsWith('{')) {
      const data = JSON.parse(rol.descripcion);
      form.value = { ...rol, info_visible: data.info || '' };
      permisosSeleccionados.value = data.permisos || [];
    } else {
      form.value = { ...rol, info_visible: rol.descripcion || '' };
      permisosSeleccionados.value = [];
    }
  } catch (e) {
    form.value = { ...rol, info_visible: rol.descripcion || '' };
    permisosSeleccionados.value = [];
  }
  showForm.value = true;
};

const saveRol = async () => {
  saving.value = true;
  try {
    // Serializamos la info y los permisos en el campo descripcion
    const dataToStore = {
      info: form.value.info_visible,
      permisos: permisosSeleccionados.value
    };
    
    const payload = { 
      nombre: form.value.nombre.toLowerCase(),
      descripcion: JSON.stringify(dataToStore)
    };

    if (isEditing.value) {
      await api.patch(`/roles/${form.value.id}`, payload);
    } else {
      await api.post('/roles', payload);
    }
    showForm.value = false;
    await fetchRoles();
    notificationStore.addNotification({
      title: 'Configuración Guardada',
      message: 'El rol y sus permisos han sido actualizados en la base de datos.',
      type: 'success'
    })
  } catch (error) {
    console.error('Error saving role:', error);
    notificationStore.addNotification({
      title: 'Error de Sistema',
      message: 'No se pudo guardar. El nombre del rol debe ser único.',
      type: 'error'
    })
  } finally {
    saving.value = false;
  }
};

const deleteRol = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Rol?',
    message: 'Los usuarios asignados a este rol podrían perder acceso al sistema inmediatamente.',
    confirmText: 'Sí, Eliminar',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/roles/${id}`);
        notificationStore.addNotification({
          title: 'Rol Eliminado',
          message: 'El registro ha sido removido exitosamente.',
          type: 'success'
        })
        await fetchRoles();
      } catch (error) {
        console.error('Error deleting role:', error);
        notificationStore.addNotification({
          title: 'Acción Bloqueada',
          message: 'No se puede eliminar el rol. Verifique si tiene usuarios asignados.',
          type: 'error'
        })
      }
    }
  })
};

onMounted(() => {
  fetchRoles();
});
</script>

<style scoped>
.slide-fade-enter-active { transition: all 0.35s cubic-bezier(0.23, 1, 0.32, 1); }
.slide-fade-leave-active { transition: all 0.2s ease-in; }
.slide-fade-enter-from { transform: translateY(-12px); opacity: 0; }
.slide-fade-leave-to { transform: translateY(-8px); opacity: 0; }
</style>
