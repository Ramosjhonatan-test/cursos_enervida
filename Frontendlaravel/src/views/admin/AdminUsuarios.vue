<template>
  <div class="space-y-10 animate-fade-in">
    <!-- Header -->
    <div class="panel-hero p-8 relative overflow-hidden group rounded-[40px] bg-on-surface/[0.03] !border-none">
      <div class="absolute -right-20 -top-20 w-80 h-80 bg-accent-neon/10 rounded-full blur-[100px] group-hover:bg-accent-neon/20 transition-all duration-1000"></div>
      
      <div class="flex flex-col md:flex-row md:items-center justify-between gap-8 relative z-10">
        <div>
          <h2 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">Gestión de <span class="text-accent-neon italic">Usuarios</span></h2>
          <p class="text-on-surface/40 mt-3 text-[10px] font-bold uppercase tracking-[0.3em] flex items-center gap-2">
            <span class="flex h-1.5 w-1.5 relative">
              <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
              <span class="relative inline-flex rounded-full h-1.5 w-1.5 bg-accent-neon"></span>
            </span>
            Control centralizado del ecosistema
          </p>
        </div>
        <div class="flex flex-wrap items-center gap-4">
          <select v-model="filterRole" @change="fetchUsuarios" class="input-cyber !py-3 !text-[10px] !font-black uppercase tracking-widest appearance-none cursor-pointer !bg-on-surface/[0.05] !border-none min-w-[180px]">
            <option value="todos">Todos los Roles</option>
            <option v-for="rol in roles" :key="rol.id" :value="rol.nombre">{{ rol.nombre.toUpperCase() }}</option>
          </select>
          <router-link to="/admin/estudiantes/nuevo" class="btn-premium btn-primary-neon !py-4 px-8 gap-3 group/btn shadow-neon-sm">
            <span class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-90">person_add</span>
            <span class="font-black uppercase text-xs tracking-widest">Nuevo Usuario</span>
          </router-link>
           <div class="flex flex-wrap items-center gap-4">
          <button @click="fetchUsuarios" class="btn-premium btn-primary-cyan !py-4 px-8 group/btn relative overflow-hidden !border-none shadow-xl hover:shadow-accent-cyan/20 transition-all duration-500">
             <span class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-180 duration-500 relative" :class="{ 'animate-spin': loading }">refresh</span>
             <span class="relative font-bold">Actualizar</span>
          </button>
        </div>
        </div>
      </div>
    </div>

    <!-- Users Table -->
    <div class="glass-card-premium rounded-[20px] overflow-hidden shadow-2xl relative min-h-[400px] !border-none p-2">
  <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
    <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
    <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando usuarios...</p>
  </div>
  
  <div class="overflow-x-auto w-full scrollbar-thin scrollbar-track-white/5 scrollbar-thumb-white/10 hover:scrollbar-thumb-accent-neon">
    <table class="w-full min-w-[1000px] text-left border-collapse bg-transparent">
      <thead>
        <tr class="border-b border-on-surface/[0.08]">
          <th class="p-8 pl-4 text-[11px] font-black text-on-surface/30 uppercase tracking-[0.2em]">Identidad</th>
          <th class="p-8 text-[11px] font-black text-on-surface/30 uppercase tracking-[0.2em]">Correo / Contacto</th>
          <th class="p-8 text-[11px] font-black text-on-surface/30 uppercase tracking-[0.2em] text-center">Rol Actual</th>
          <th class="p-8 text-[11px] font-black text-on-surface/30 uppercase tracking-[0.2em]">Estado</th>
          <th class="p-8 pr-4 text-[11px] font-black text-on-surface/30 uppercase tracking-[0.2em] text-right">Gestión</th>
        </tr>
      </thead>
      <tbody class="bg-transparent divide-y divide-on-surface/[0.04]">
        <tr v-for="usuario in usuarios" :key="usuario.id" class="group hover:bg-on-surface/[0.03] transition-all duration-500">
          <td class="p-8 pl-4">
            <div class="flex items-center gap-5">
              <div class="w-14 h-14 rounded-2xl bg-on-surface/5 p-1 relative group/avatar">
                <img :src="usuario.imagen_perfil || 'https://i.pravatar.cc/150?u=' + usuario.id" class="w-full h-full object-cover rounded-xl transition-transform duration-500 group-hover/avatar:scale-110" />
                <div class="absolute -right-1 -bottom-1 w-5 h-5 rounded-full border-2 border-background bg-green-500" v-if="usuario.estado === 'ACTIVO'"></div>
              </div>
              <div>
                <p class="text-sm font-black text-on-surface tracking-tight group-hover:text-accent-neon transition-colors">{{ usuario.nombres }} {{ usuario.apellidos }}</p>
                <p class="text-[10px] text-accent-neon font-black uppercase tracking-widest mt-1">ID: {{ usuario.ci || 'SIN CI' }}</p>
              </div>
            </div>
          </td>
          <td class="p-8">
            <div class="flex flex-col gap-1.5">
              <span class="text-sm text-on-surface/80 font-bold tracking-tight">{{ usuario.correo }}</span>
              <div class="flex items-center gap-2 opacity-40 group-hover:opacity-100 transition-opacity">
                <span class="material-symbols-outlined text-xs">phone</span>
                <span class="text-[10px] font-black tracking-widest">{{ usuario.telefono || 'SIN CONTACTO' }}</span>
              </div>
            </div>
          </td>
          <td class="p-8">
            <div class="flex justify-center">
              <div class="relative group/rol">
                <span :class="['px-4 py-1.5 rounded-xl text-[10px] font-black uppercase tracking-[0.1em] transition-all cursor-pointer shadow-sm', getRoleClass(usuario.rol?.nombre)]">
                  {{ usuario.rol?.nombre || 'Sin Rol' }}
                </span>
                <div class="absolute bottom-full left-1/2 -translate-x-1/2 mb-3 opacity-0 invisible group-hover/rol:opacity-100 group-hover/rol:visible transition-all duration-300 z-50 flex flex-col bg-background/80 backdrop-blur-xl rounded-2xl shadow-[0_20px_50px_rgba(0,0,0,0.5)] border border-on-surface/10 p-2.5 min-w-[150px]">
                  <p class="text-[9px] text-accent-solar font-black text-on-surface/40 uppercase tracking-widest px-2.5 py-1.5 mb-1 border-b border-on-surface/[0.06]">
                    Cambiar Rol
                  </p>
                  <button v-for="r in roles" :key="r.id" @click="changeRole(usuario.id, r.id)" class="px-3 py-2 text-[10px] font-black text-left text-on-surface/70 hover:text-accent-neon hover:bg-accent-neon/10 rounded-xl transition-all duration-200 active:scale-95 capitalize">{{ r.nombre }}
                  </button>
                </div>
              </div>
            </div>
          </td>
          <td class="p-8">
            <div class="flex items-center gap-3">
              <div :class="['w-2 h-2 rounded-full animate-pulse-slow', usuario.estado === 'ACTIVO' ? 'bg-green-500 shadow-neon-sm' : 'bg-red-500 shadow-lg']"></div>
              <span class="text-[10px] font-black uppercase tracking-[0.2em] text-on-surface/60">
                {{ usuario.estado }}
              </span>
            </div>
          </td>
          <td class="p-8 pr-4 text-right">
            <div class="flex justify-end gap-3">
              <button @click="toggleStatus(usuario)" class="w-11 h-11 rounded-xl bg-emerald-500/20 flex items-center justify-center text-emerald-500 hover:bg-emerald-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-lg hover:shadow-emerald-500/40" title="Alternar Estado">
                <span class="material-symbols-outlined text-xl">{{ usuario.estado === 'ACTIVO' ? 'block' : 'check_circle' }}</span>
              </button>
              <router-link :to="'/admin/estudiantes/editar/' + usuario.id" class="w-11 h-11 rounded-xl bg-blue-500/20 flex items-center justify-center text-blue-500 hover:bg-blue-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-lg hover:shadow-blue-500/40" title="Editar Perfil">
                <span class="material-symbols-outlined text-xl">edit</span>
              </router-link>
              <button @click="deleteUsuario(usuario.id)" class="w-11 h-11 rounded-xl bg-red-500/20 flex items-center justify-center text-red-500 hover:bg-red-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-lg hover:shadow-red-500/40" title="Eliminar Permanente">
                <span class="material-symbols-outlined text-xl">delete</span>
              </button>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '@/services/api';
import { useNotificationStore } from '@/stores/notificationStore';
import { useModalStore } from '@/stores/modalStore';

const usuarios = ref([]);
const roles = ref([]);
const loading = ref(true);
const filterRole = ref('todos');
const notificationStore = useNotificationStore();
const modalStore = useModalStore();

const getRoleClass = (rol) => {
  switch (rol?.toLowerCase()) {
    case 'admin': return 'bg-red-500/10 text-red-500';
    case 'instructor': return 'bg-accent-solar/10 text-accent-solar';
    case 'estudiante': return 'bg-accent-neon/10 text-accent-neon';
    default: return 'bg-on-surface/5 text-on-surface/40';
  }
};

const fetchRoles = async () => {
  try {
    const res = await api.get('/roles');
    roles.value = res.data;
  } catch (error) {
    console.error('Error fetching roles:', error);
  }
};

const fetchUsuarios = async () => {
  loading.value = true;
  try {
    let url = '/usuarios';
    if (filterRole.value !== 'todos') {
      url = `/usuarios/rol/${filterRole.value}`;
    }
    const res = await api.get(url);
    usuarios.value = res.data;
  } catch (error) {
    console.error('Error fetching users:', error);
  } finally {
    loading.value = false;
  }
};

const changeRole = async (userId, roleId) => {
  try {
    await api.patch(`/usuarios/${userId}`, { rol_id: roleId });
    await fetchUsuarios();
    notificationStore.addNotification({
      title: 'Rol Actualizado',
      message: 'Los permisos del usuario han sido modificados.',
      type: 'success'
    })
  } catch (error) {
    console.error('Error changing role:', error);
    notificationStore.addNotification({
      title: 'Error de Permisos',
      message: 'No se pudo actualizar el rol del usuario.',
      type: 'error'
    })
  }
};

const toggleStatus = async (usuario) => {
  try {
    const newStatus = usuario.estado === 'ACTIVO' ? 'INACTIVO' : 'ACTIVO';
    await api.patch(`/usuarios/${usuario.id}`, { estado: newStatus });
    usuario.estado = newStatus;
    notificationStore.addNotification({
      title: 'Estado Cambiado',
      message: `Usuario ${newStatus.toLowerCase()} exitosamente.`,
      type: 'success'
    })
  } catch (error) {
    notificationStore.addNotification({
      title: 'Error de Estado',
      message: 'No se pudo actualizar el acceso del usuario.',
      type: 'error'
    })
  }
};

const deleteUsuario = async (id) => {
  modalStore.openModal({
    title: '¿Eliminar Usuario?',
    message: 'Esta acción es irreversible y el usuario perderá todo acceso.',
    confirmText: 'Eliminar Permanente',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/usuarios/${id}`);
        usuarios.value = usuarios.value.filter(u => u.id !== id);
        notificationStore.addNotification({
          title: 'Usuario Removido',
          message: 'La cuenta ha sido eliminada del sistema.',
          type: 'success'
        })
      } catch (error) {
        notificationStore.addNotification({
          title: 'Error al Eliminar',
          message: 'No se pudo completar la operación de borrado.',
          type: 'error'
        })
      }
    }
  })
};

onMounted(async () => {
  await Promise.all([fetchRoles(), fetchUsuarios()]);
});
</script>
