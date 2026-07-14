<template>
  <div class="space-y-10 animate-fade-in text-on-surface">
    <!-- Header & Hero -->
    <div class="panel-hero p-10 relative overflow-hidden group rounded-[40px] bg-on-surface/[0.03] !border-none shadow-2xl">
      <div class="absolute -right-20 -top-20 w-80 h-80 bg-accent-neon/10 rounded-full blur-[100px] group-hover:bg-accent-neon/20 transition-all duration-1000"></div>
      <div class="absolute -left-20 -bottom-20 w-64 h-64 bg-primary/5 rounded-full blur-[80px]"></div>

      <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-8 relative z-10">
        <div class="flex-1">
          <div class="flex items-center gap-4 mb-3">
            <div class="w-16 h-16 rounded-2xl bg-accent-neon/20 flex items-center justify-center text-accent-neon shadow-neon-sm animate-pulse-slow">
              <span class="material-symbols-outlined text-4xl">devices</span>
            </div>
            <div>
              <h2 class="text-3xl md:text-5xl font-black text-on-surface font-lexend tracking-tighter leading-none">
                Control de <span class="text-accent-neon italic">Dispositivos</span>
              </h2>
              <p class="text-on-surface/50 text-xs font-bold uppercase tracking-[0.4em] mt-3 flex items-center gap-2">
                <span class="flex h-2 w-2 relative">
                  <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
                  <span class="relative inline-flex rounded-full h-2 w-2 bg-accent-neon"></span>
                </span>
                GESTIÓN DE SEGURIDAD Y ACCESOS
              </p>
            </div>
          </div>
        </div>

        <div class="flex flex-wrap items-center gap-4">
          <div class="relative group">
            <span class="absolute left-5 top-1/2 -translate-y-1/2 material-symbols-outlined text-on-surface/30 group-focus-within:text-accent-neon transition-all scale-110">search</span>
            <input 
              v-model="searchQuery" 
              type="text" 
              placeholder="Buscar IP o usuario..." 
              class="input-cyber !pl-14 !py-4 !text-sm w-full md:w-80 transition-all !border-none !bg-on-surface/[0.04] !shadow-none"
            />
          </div>
          <button @click="fetchDispositivos" class="btn-premium btn-secondary-glass !py-4 px-8 group/btn relative overflow-hidden !border-none shadow-xl hover:shadow-accent-neon/20 transition-all duration-500">
             <span class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-180 duration-500 relative" :class="{ 'animate-spin': loading }">refresh</span>
             <span class="relative font-bold">Actualizar</span>
          </button>
        </div>
      </div>
    </div>

    <!-- Stats Row -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-2 transition-all duration-500 relative overflow-hidden !border-none shadow-2xl">
        <div class="absolute -right-10 -bottom-10 w-32 h-32 bg-accent-neon/5 rounded-full blur-3xl group-hover:bg-accent-neon/10 transition-colors"></div>
        <div class="flex items-center gap-6 relative z-10">
          <div class="w-16 h-16 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon group-hover:bg-accent-neon group-hover:text-on-surface transition-all duration-500 border-none">
            <span class="material-symbols-outlined text-3xl">devices</span>
          </div>
          <div>
            <p class="text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em] mb-1">Sesiones Activas</p>
            <div class="flex items-baseline gap-2">
              <p class="text-4xl font-black text-on-surface font-lexend tracking-tight">{{ dispositivos.length }}</p>
              <span class="text-xs font-bold text-green-500 flex items-center gap-1">
                <span class="material-symbols-outlined text-xs">trending_up</span>
                En línea
              </span>
            </div>
          </div>
        </div>
      </div>

      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-2 transition-all duration-500 relative overflow-hidden !border-none shadow-2xl">
        <div class="absolute -right-10 -bottom-10 w-32 h-32 bg-accent-solar/5 rounded-full blur-3xl group-hover:bg-accent-solar/10 transition-colors"></div>
        <div class="flex items-center gap-6 relative z-10">
          <div class="w-16 h-16 rounded-2xl bg-accent-solar/10 flex items-center justify-center text-accent-solar group-hover:bg-accent-solar group-hover:text-white transition-all duration-500 border-none">
            <span class="material-symbols-outlined text-3xl">person</span>
          </div>
          <div>
            <p class="text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em] mb-1">Usuarios Únicos</p>
            <p class="text-4xl font-black text-on-surface font-lexend tracking-tight">{{ uniqueUsers }}</p>
          </div>
        </div>
      </div>

      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-2 transition-all duration-500 relative overflow-hidden !border-none shadow-2xl">
        <div class="absolute -right-10 -bottom-10 w-32 h-32 bg-red-500/5 rounded-full blur-3xl group-hover:bg-red-500/10 transition-colors"></div>
        <div class="flex items-center gap-6 relative z-10">
          <div class="w-16 h-16 rounded-2xl bg-red-500/10 flex items-center justify-center text-red-500 group-hover:bg-red-500 group-hover:text-white transition-all duration-500 border-none">
            <span class="material-symbols-outlined text-3xl">security</span>
          </div>
          <div>
            <p class="text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em] mb-1">Alertas de Riesgo</p>
            <div class="flex items-center gap-3">
              <p class="text-4xl font-black text-on-surface font-lexend tracking-tight">{{ riskAlerts }}</p>
              <span v-if="riskAlerts > 0" class="px-2 py-1 rounded-lg bg-red-500/10 text-red-500 text-[10px] font-black uppercase tracking-widest animate-pulse">Crítico</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Devices Table -->
    <div class="glass-card-premium rounded-[20px] overflow-hidden shadow-2xl relative min-h-[400px] !border-none">
      <div v-if="loading" class="absolute inset-0 z-10 flex flex-col items-center justify-center bg-background/50 backdrop-blur-sm">
        <div class="animate-spin rounded-full h-16 w-16 border-t-2 border-accent-neon shadow-[0_0_20px_var(--accent-neon)] mb-4"></div>
        <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest animate-pulse">Cargando dispositivos...</p>
      </div>
      <div class="overflow-x-auto">
        <table class="w-full min-w-[1100px] text-left border-separate border-spacing-0">
          <thead>
            <tr class="bg-on-surface/[0.03]">
              <th class="p-8 text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em]">Usuario</th>
              <th class="p-8 text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em]">Dispositivo / SO</th>
              <th class="p-8 text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em]">Navegador</th>
              <th class="p-8 text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em]">IP / Estado</th>
              <th class="p-8 text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em]">Última Actividad</th>
              <th class="p-8 text-[11px] font-black text-on-surface/40 uppercase tracking-[0.2em] text-right">Gestión</th>
            </tr>
          </thead>
          <tbody class="bg-transparent">
            <tr v-for="dispositivo in filteredDispositivos" :key="dispositivo.id" class="group hover:bg-on-surface/[0.03] transition-all duration-500">
              <td class="p-8">
                <span v-if="dispositivo.usuario" class="text-sm font-bold text-on-surface">
                  {{ dispositivo.usuario.nombres }} {{ dispositivo.usuario.apellidos }}
                </span>
                <span v-else class="text-sm text-on-surface/40 italic">Desconocido</span>
              </td>
              <td class="p-8">
                <div class="flex items-center gap-4">
                  <div class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/60 group-hover:text-accent-neon transition-colors">
                    <span class="material-symbols-outlined text-2xl">
                      {{ getDeviceIcon(dispositivo.sistema_operativo) }}
                    </span>
                  </div>
                  <div>
                    <p class="text-sm font-black text-on-surface tracking-tight leading-none">{{ dispositivo.sistema_operativo || 'Desconocido' }}</p>
                    <p class="text-[10px] text-on-surface/40 font-bold uppercase tracking-widest mt-1">{{ dispositivo.nombre_dispositivo || 'Dispositivo Genérico' }}</p>
                  </div>
                </div>
              </td>
              <td class="p-8">
                <div class="flex items-center gap-2">
                  <span class="px-3 py-1.5 rounded-xl bg-on-surface/5 text-xs text-on-surface/60 font-black tracking-tight group-hover:text-accent-solar transition-all">
                    {{ dispositivo.navegador || 'Desconocido' }}
                  </span>
                </div>
              </td>
              <td class="p-8">
                <div class="flex flex-col gap-1.5">
                  <div class="flex items-center gap-2">
                    <span class="text-sm font-black text-on-surface tracking-tighter">{{ dispositivo.direccion_ip }}</span>
                    <span v-if="dispositivo.fingerprint" class="w-2 h-2 rounded-full bg-blue-500/60"></span>
                  </div>
                  <div class="flex items-center gap-1 opacity-20 group-hover:opacity-60 transition-opacity">
                    <span class="material-symbols-outlined text-xs">verified_user</span>
                    <span class="text-[9px] font-black uppercase tracking-[0.1em]">
                      {{ dispositivo.fingerprint ? 'Sesión Firmada' : 'Firma no disponible' }}
                    </span>
                  </div>
                </div>
              </td>
              <td class="p-8">
                <div class="flex items-center gap-3">
                  <div :class="['w-2 h-2 rounded-full', dispositivo.activo ? 'bg-green-500' : 'bg-on-surface/10']"></div>
                  <div class="flex flex-col">
                    <span class="text-xs font-black text-on-surface/80">{{ formatDate(dispositivo.ultimo_acceso).split(' ')[0] }}</span>
                    <span class="text-[10px] text-on-surface/40 font-bold uppercase tracking-tighter mt-0.5">{{ formatDate(dispositivo.ultimo_acceso).split(' ')[1] }}</span>
                  </div>
                </div>
              </td>
              <td class="p-8 text-right">
                <div class="flex justify-end">
                  <button 
                    @click="revokeSession(dispositivo.id)" 
                    class="w-11 h-11 rounded-xl bg-red-500/20 flex items-center justify-center text-red-500 hover:bg-red-500 hover:text-white hover:-translate-y-1 transition-all duration-300 shadow-lg hover:shadow-red-500/40"
                    title="Revocar Sesión"
                  >
                    <span class="material-symbols-outlined text-xl">no_accounts</span>
                  </button>
                </div>
              </td>
            </tr>
            <tr v-if="filteredDispositivos.length === 0">
              <td colspan="6" class="p-20 text-center">
                <div class="flex flex-col items-center gap-4 opacity-10">
                  <span class="material-symbols-outlined text-8xl">important_devices </span>
                  <p class="text-xl font-black uppercase tracking-[0.2em]">No hay resultados</p>
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
import { ref, onMounted, computed } from 'vue';
import api from '@/services/api';
import { useNotificationStore } from '@/stores/notificationStore';
import { useModalStore } from '@/stores/modalStore';

const notificationStore = useNotificationStore();
const modalStore = useModalStore();

const dispositivos = ref([]);
const loading = ref(true);
const searchQuery = ref('');

const fetchDispositivos = async () => {
  loading.value = true;
  try {
    const res = await api.get('/dispositivos-usuario');
    dispositivos.value = res.data;
  } catch (error) {
    console.error('Error fetching devices:', error);
    // Mock data alineado con Schema
    dispositivos.value = [
      {
        id: 1,
        direccion_ip: '192.168.1.1',
        sistema_operativo: 'Windows 11',
        navegador: 'Chrome',
        nombre_dispositivo: 'PC Oficina',
        activo: true,
        ultimo_acceso: new Date(),
        usuario: { id: 1, nombres: 'Juan', apellidos: 'Perez', correo: 'juan@enervida.com' }
      }
    ];
  } finally {
    loading.value = false;
  }
};

const revokeSession = async (id) => {
  modalStore.openModal({
    title: '¿Revocar Sesión?',
    message: 'El usuario será desconectado de este dispositivo inmediatamente.',
    confirmText: 'Revocar Acceso',
    type: 'danger',
    onConfirm: async () => {
      try {
        await api.delete(`/dispositivos-usuario/${id}`);
        dispositivos.value = dispositivos.value.filter(d => d.id !== id);
        notificationStore.addNotification({
          title: 'Sesión Finalizada',
          message: 'El acceso ha sido revocado exitosamente.',
          type: 'success'
        })
      } catch (error) {
        console.error('Error revoking session:', error);
        notificationStore.addNotification({
          title: 'Error de Seguridad',
          message: 'No se pudo revocar la sesión en este momento.',
          type: 'error'
        })
      }
    }
  })
};

const filteredDispositivos = computed(() => {
  if (!searchQuery.value) return dispositivos.value;
  const q = searchQuery.value.toLowerCase();
  return dispositivos.value.filter(d => 
    d.usuario?.nombres?.toLowerCase().includes(q) ||
    d.usuario?.apellidos?.toLowerCase().includes(q) ||
    d.direccion_ip?.includes(q) ||
    d.usuario?.correo?.toLowerCase().includes(q)
  );
});

const uniqueUsers = computed(() => {
  const users = new Set(dispositivos.value.map(d => d.usuario?.id));
  return users.size;
});

const riskAlerts = computed(() => {
  const userCounts = {};
  dispositivos.value.forEach(d => {
    if (d.usuario?.id) {
      userCounts[d.usuario.id] = (userCounts[d.usuario.id] || 0) + 1;
    }
  });
  return Object.values(userCounts).filter(count => count > 2).length;
});

const getDeviceIcon = (os) => {
  const lowerOS = os?.toLowerCase() || '';
  if (lowerOS.includes('win')) return 'desktop_windows';
  if (lowerOS.includes('android')) return 'smartphone';
  if (lowerOS.includes('ios') || lowerOS.includes('iphone')) return 'smartphone';
  if (lowerOS.includes('mac')) return 'laptop_mac';
  return 'devices';
};

const formatDate = (date) => {
  if (!date) return 'N/A';
  return new Intl.DateTimeFormat('es-ES', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  }).format(new Date(date));
};

onMounted(() => {
  fetchDispositivos();
});
</script>

<style scoped>
.animate-fade-in {
  animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
