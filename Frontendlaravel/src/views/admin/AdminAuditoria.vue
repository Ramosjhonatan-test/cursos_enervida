<template>
  <div class="space-y-8 animate-fade-in text-on-surface pb-20">
    <!-- Header & Hero -->
    <div class="panel-hero p-10 relative overflow-hidden group rounded-[40px] bg-on-surface/[0.03] !border-none">
      <div class="absolute -right-20 -top-20 w-80 h-80 bg-accent-neon/10 rounded-full blur-[100px] group-hover:bg-accent-neon/20 transition-all duration-1000"></div>
      <div class="absolute -left-20 -bottom-20 w-64 h-64 bg-primary/5 rounded-full blur-[80px]"></div>
      
      <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-8 relative z-10">
        <div class="flex-1">
          <div class="flex items-center gap-4 mb-3">
            <div class="w-16 h-16 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon shadow-neon-sm animate-pulse-slow">
              <span class="material-symbols-outlined text-4xl">policy</span>
            </div>
            <div>
              <h2 class="text-lg md:text-xl font-bold text-on-surface font-lexend tracking-tight leading-none">
                Auditoría
              </h2>
              <p class="text-on-surface/50 text-[10px] font-bold uppercase tracking-[0.3em] mt-3 flex items-center gap-2">
                <span class="flex h-1.5 w-1.5 relative">
                  <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent-neon opacity-75"></span>
                  <span class="relative inline-flex rounded-full h-1.5 w-1.5 bg-accent-neon"></span>
                </span>
                SISTEMA DE TRAZABILIDAD PROACTIVA
              </p>
            </div>
          </div>
        </div>
        
        <div class="flex flex-wrap items-center gap-4">
          <!-- Activity Chart Mini -->
          <div class="hidden xl:flex items-end gap-1.5 h-12 px-6">
            <div v-for="day in activityChart" :key="day.date" 
                 class="w-2 bg-accent-neon/20 rounded-full transition-all hover:bg-accent-neon hover:shadow-neon-sm relative group/bar"
                 :style="{ height: Math.max(day.height, 10) + '%' }">
              <div class="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-2 py-1 bg-black text-[8px] font-black text-white rounded opacity-0 group-hover/bar:opacity-100 transition-opacity whitespace-nowrap z-50">
                {{ day.count }} eventos
              </div>
            </div>
          </div>

          <div class="flex gap-3">
            <button @click="fetchLogs" class="btn-premium glass-card gap-2 !py-4 px-8 group/btn relative overflow-hidden">
              <div class="absolute inset-0 bg-accent-neon/5 translate-y-full group-hover/btn:translate-y-0 transition-transform"></div>
              <span class="material-symbols-outlined text-lg transition-transform group-hover/btn:rotate-180 duration-500 relative" :class="{ 'animate-spin': loading }">refresh</span>
              <span class="relative">Sincronizar</span>
            </button>
            <button @click="confirmClearAll" class="btn-premium bg-red-500/10 text-red-500 hover:bg-red-500 hover:text-white shadow-sm hover:shadow-red-500/20 transition-all !py-4 gap-2 px-6 !border-none">
              <span class="material-symbols-outlined text-lg">delete_sweep</span>
              Limpiar Bitácora
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Quick Stats -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-6 gap-6">
      <div class="glass-card rounded-[40px] p-8 relative overflow-hidden group hover:-translate-y-1 transition-all duration-500 !border-none bg-on-surface/[0.03]">
        <div class="absolute top-0 right-0 p-4 opacity-5 group-hover:opacity-10 transition-opacity">
          <span class="material-symbols-outlined text-7xl">database</span>
        </div>
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Total Eventos</p>
          <div class="w-10 h-10 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon group-hover:shadow-neon-sm transition-all">
            <span class="material-symbols-outlined text-xl">insights</span>
          </div>
        </div>
        <p class="text-5xl font-black text-on-surface font-lexend tracking-tight">{{ totalLogs }}</p>
        <div class="mt-6 flex items-center gap-3">
          <span class="text-[10px] font-black text-accent-neon bg-accent-neon/10 px-3 py-1 rounded-full italic">Global</span>
          <div class="flex-1 h-1.5 bg-on-surface/5 rounded-full overflow-hidden">
            <div class="h-full bg-accent-neon animate-pulse-slow" :style="{ width: Math.min((totalLogs/1000)*100, 100) + '%' }"></div>
          </div>
        </div>
      </div>

      <!-- Creations -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 !border-none bg-on-surface/[0.03]">
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Creaciones</p>
          <div class="w-10 h-10 rounded-xl bg-green-500/10 flex items-center justify-center text-green-500 group-hover:shadow-[0_0_15px_rgba(34,197,94,0.2)] transition-all">
            <span class="material-symbols-outlined text-xl">add_circle</span>
          </div>
        </div>
        <p class="text-5xl font-black text-green-500 font-lexend tracking-tight">{{ stats.creations }}</p>
        <div class="mt-6 flex items-center gap-2 text-[10px] font-black uppercase text-green-500/60">
          <span class="material-symbols-outlined text-sm">trending_up</span>
          <span>+{{ stats.creationsToday }} hoy</span>
        </div>
      </div>

      <!-- Ediciones -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 !border-none bg-on-surface/[0.03]">
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Ediciones</p>
          <div class="w-10 h-10 rounded-xl bg-blue-500/10 flex items-center justify-center text-blue-500 group-hover:shadow-[0_0_15px_rgba(59,130,246,0.2)] transition-all">
            <span class="material-symbols-outlined text-xl">edit_square</span>
          </div>
        </div>
        <p class="text-5xl font-black text-blue-500 font-lexend tracking-tight">{{ stats.updates }}</p>
        <div class="mt-6 flex items-center gap-2 text-[10px] font-black uppercase text-blue-500/60">
          <div class="w-full bg-on-surface/5 h-1.5 rounded-full overflow-hidden">
             <div class="h-full bg-blue-500" :style="{ width: stats.updatesPct + '%' }"></div>
          </div>
          <span class="whitespace-nowrap">{{ stats.updatesPct }}%</span>
        </div>
      </div>

      <!-- Deletions -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 relative overflow-hidden !border-none bg-on-surface/[0.03]">
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Eliminaciones</p>
          <div class="w-10 h-10 rounded-xl bg-red-500/10 flex items-center justify-center text-red-500 group-hover:shadow-[0_0_15px_rgba(239,68,68,0.2)] transition-all">
            <span class="material-symbols-outlined text-xl">delete_forever</span>
          </div>
        </div>
        <p class="text-5xl font-black text-red-500 font-lexend tracking-tight">{{ stats.deletions }}</p>
        <div class="mt-6 flex items-center gap-2 text-[10px] font-black uppercase text-red-500/40">
          <span class="material-symbols-outlined text-sm">warning</span>
          <span>Acciones Irreversibles</span>
        </div>
      </div>

      <!-- Top Actor -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 relative overflow-hidden !border-none bg-on-surface/[0.03]">
        <div class="absolute -right-4 -bottom-4 opacity-5 group-hover:opacity-10 transition-opacity">
          <span class="material-symbols-outlined text-7xl text-purple-500">person</span>
        </div>
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Top Actor</p>
          <div class="w-10 h-10 rounded-xl bg-purple-500/10 flex items-center justify-center text-purple-500">
            <span class="material-symbols-outlined text-xl">stars</span>
          </div>
        </div>
        <p class="text-lg font-black text-on-surface font-lexend tracking-tight line-clamp-1 mb-1">{{ topStats.topUser[0] }}</p>
        <p class="text-[10px] font-black text-purple-500/60 uppercase tracking-tight">{{ topStats.topUser[1] }} acciones</p>
      </div>

      <!-- Top Entity -->
      <div class="glass-card rounded-[40px] p-8 group hover:-translate-y-1 transition-all duration-500 relative overflow-hidden !border-none bg-on-surface/[0.03]">
        <div class="absolute -right-4 -bottom-4 opacity-5 group-hover:opacity-10 transition-opacity">
          <span class="material-symbols-outlined text-7xl text-orange-500">inventory_2</span>
        </div>
        <div class="flex items-center justify-between mb-6">
          <p class="text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Foco de Cambio</p>
          <div class="w-10 h-10 rounded-xl bg-orange-500/10 flex items-center justify-center text-orange-500">
            <span class="material-symbols-outlined text-xl">account_tree</span>
          </div>
        </div>
        <p class="text-xl font-black text-on-surface font-lexend tracking-tight uppercase line-clamp-1">{{ topStats.topEntity[0] }}</p>
        <p class="text-[10px] font-black text-orange-500/60 uppercase tracking-tight">{{ topStats.topEntity[1] }} mutaciones</p>
      </div>
    </div>

    <!-- Filters Bar -->
    <div class="glass-card rounded-[40px] p-8 flex flex-col xl:flex-row gap-8 items-center justify-between relative overflow-hidden">
      <div class="absolute left-0 top-0 bottom-0 w-1 bg-accent-neon/30"></div>
      
      <div class="flex flex-col md:flex-row gap-5 w-full xl:max-w-4xl">
        <div class="relative flex-1 group">
          <span class="material-symbols-outlined absolute left-5 top-1/2 -translate-y-1/2 text-on-surface/20 group-focus-within:text-accent-neon transition-all scale-110">search</span>
          <input 
            v-model="searchQuery" 
            type="text" 
            placeholder="Buscar acción, usuario, ID o descripción..." 
            class="input-cyber w-full !pl-14 !py-5 transition-all text-sm font-medium border-none bg-on-surface/[0.04]"
          />
        </div>

        <button 
          @click="showDatePicker = !showDatePicker" 
          class="btn-premium gap-3 !px-8 min-w-[220px] justify-between group !bg-on-surface/[0.06] border-none shadow-none"
          :class="{ 'bg-accent-neon !text-black': hasDateFilter }"
        >
          <div class="flex items-center gap-2">
            <span class="material-symbols-outlined text-lg">calendar_month</span>
            <span class="text-xs font-black uppercase tracking-widest">Mostrar por Fecha</span>
          </div>
          <span class="material-symbols-outlined text-sm transition-transform group-hover:rotate-180" :class="{ 'rotate-180': showDatePicker }">expand_more</span>
        </button>
      </div>

      <div class="flex flex-wrap items-center gap-5 w-full xl:w-auto">
        <!-- Quick Filters -->
        <div class="flex items-center gap-2 p-1.5 bg-on-surface/[0.03] rounded-2xl shadow-inner">
          <button 
            @click="setQuickDate('today')" 
            class="px-5 py-2.5 text-[10px] font-black uppercase tracking-widest rounded-xl transition-all"
            :class="isQuickDateActive('today') ? 'bg-accent-neon text-black shadow-neon-sm' : 'text-on-surface/40 hover:bg-on-surface/10'"
          >
            Hoy
          </button>
          <button 
            @click="setQuickDate('week')" 
            class="px-5 py-2.5 text-[10px] font-black uppercase tracking-widest rounded-xl transition-all"
            :class="isQuickDateActive('week') ? 'bg-accent-neon text-black shadow-neon-sm' : 'text-on-surface/40 hover:bg-on-surface/10'"
          >
            Semana
          </button>
          <button 
            @click="setQuickDate('month')" 
            class="px-5 py-2.5 text-[10px] font-black uppercase tracking-widest rounded-xl transition-all"
            :class="isQuickDateActive('month') ? 'bg-accent-neon text-black shadow-neon-sm' : 'text-on-surface/40 hover:bg-on-surface/10'"
          >
            Mes
          </button>
        </div>
        
        <div class="w-px h-8 bg-on-surface/10 hidden xl:block"></div>

        <button @click="exportToCSV" class="btn-icon-premium hover:bg-blue-500 hover:text-white" title="Exportar CSV">
          <span class="material-symbols-outlined text-lg">download</span>
        </button>

        <button 
          v-if="logs.length > 0"
          @click="confirmClearAll" 
          class="btn-icon-premium hover:bg-red-500 hover:text-white group" 
          title="Limpiar toda la bitácora"
        >
          <span class="material-symbols-outlined text-lg group-hover:animate-pulse">delete_sweep</span>
        </button>

        <button 
          v-if="hasFilters" 
          @click="resetFilters" 
          class="flex items-center gap-2 text-[10px] font-black text-red-500 uppercase tracking-widest hover:bg-red-500/10 px-6 py-4 rounded-2xl transition-all group"
        >
          <span class="material-symbols-outlined text-sm transition-transform group-hover:rotate-90">filter_list_off</span>
          Limpiar Filtros
        </button>
      </div>

      <!-- Expandable Date Picker -->
      <transition 
        enter-active-class="transition duration-300 ease-out"
        enter-from-class="transform -translate-y-4 opacity-0"
        enter-to-class="transform translate-y-0 opacity-100"
        leave-active-class="transition duration-200 ease-in"
        leave-from-class="transform translate-y-0 opacity-100"
        leave-to-class="transform -translate-y-4 opacity-0"
      >
        <div v-if="showDatePicker" class="absolute top-[calc(100%+10px)] left-0 right-0 z-50 glass-card-premium p-6 shadow-[0_20px_50px_rgba(0,0,0,0.5)] border-none">
          <div class="flex flex-wrap items-center gap-8 justify-center">
            <div class="flex items-center gap-6 bg-on-surface/5 p-4 rounded-2xl">
              <div class="flex flex-col">
                <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-[0.2em] mb-2">Fecha Inicial</span>
                <input type="date" v-model="filterDateStart" class="bg-transparent border-none text-sm font-black text-on-surface outline-none cursor-pointer" />
              </div>
              <div class="w-px h-10 bg-on-surface/10"></div>
              <div class="flex flex-col">
                <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-[0.2em] mb-2">Fecha Final</span>
                <input type="date" v-model="filterDateEnd" class="bg-transparent border-none text-sm font-black text-on-surface outline-none cursor-pointer" />
              </div>
            </div>
            
            <div class="h-10 w-px bg-on-surface/10"></div>

            <div class="flex items-center gap-4">
               <span class="text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Tipo de Acción</span>
               <div class="flex gap-2">
                 <button v-for="opt in ['all', 'POST', 'PUT', 'DELETE', 'LOGIN']" :key="opt"
                   @click="filterAction = opt"
                   class="px-4 py-2 rounded-xl text-[9px] font-black uppercase transition-all"
                   :class="filterAction === opt ? 'bg-accent-neon text-black' : 'bg-on-surface/5 text-on-surface/40 hover:bg-on-surface/10'"
                 >
                   {{ opt === 'all' ? 'Todo' : opt }}
                 </button>
               </div>
            </div>
          </div>
        </div>
      </transition>
    </div>

    <!-- Main Content Table -->
    <div class="bg-on-surface/[0.02] rounded-[40px] overflow-hidden shadow-2xl relative shadow-black/5 !border-none">
      <div v-if="loading" class="absolute inset-0 bg-background/40 backdrop-blur-[2px] z-10 flex items-center justify-center">
        <div class="flex flex-col items-center gap-4">
          <div class="w-12 h-12 border-4 border-t-accent-neon rounded-full animate-spin"></div>
          <p class="text-[10px] font-black text-accent-neon uppercase tracking-widest">Sincronizando...</p>
        </div>
      </div>

      <div class="overflow-x-auto custom-scrollbar">
        <table class="w-full min-w-[1100px] text-left border-separate border-spacing-0">
          <thead>
            <tr>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Fecha y Hora</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Actor</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Acción</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Dirección IP</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest">Descripción</th>
              <th class="p-6 text-[10px] font-black text-on-surface/30 uppercase tracking-widest text-right">Detalle</th>
            </tr>
          </thead>
          <tbody class="bg-transparent">
            <template v-for="(group, date) in groupedLogs" :key="date">
              <!-- Date Header Row -->
              <tr class="bg-accent-neon/[0.02]">
                <td colspan="6" class="px-6 py-4">
                  <div class="flex items-center gap-4">
                    <div class="flex items-center gap-2">
                      <span class="material-symbols-outlined text-accent-neon text-sm">calendar_today</span>
                      <span class="text-[10px] font-black text-accent-neon uppercase tracking-[0.4em]">{{ date }}</span>
                    </div>
                    <div class="h-px flex-1 bg-accent-neon/10"></div>
                    <span class="text-[9px] font-black text-on-surface/20 uppercase tracking-widest">{{ group.length }} eventos registrados</span>
                  </div>
                </td>
              </tr>
              
              <tr v-for="log in group" :key="log.id" class="group hover:bg-accent-neon/[0.02] transition-all duration-300">
                <td class="p-6 whitespace-nowrap">
                  <div class="flex flex-col gap-0.5">
                    <span class="text-xs font-black text-on-surface group-hover:text-accent-neon transition-colors">{{ formatDateShort(log.fecha_creacion) }}</span>
                    <span class="text-[10px] font-bold text-on-surface/30 font-mono">{{ formatTime(log.fecha_creacion) }}</span>
                  </div>
                </td>
                
                <td class="p-6">
                  <span v-if="log.usuario" class="text-xs font-black text-on-surface">
                    {{ log.usuario.nombres }} {{ log.usuario.apellidos }}
                  </span>
                  <span v-else class="text-xs font-black text-on-surface/40 uppercase tracking-widest">
                    Sistema
                  </span>
                </td>

                <td class="p-6">
                  <div class="flex flex-col gap-2">
                    <span :class="['px-3 py-1.5 text-[9px] font-black rounded-xl uppercase tracking-widest w-fit shadow-none', getActionClass(log.accion)]">
                      {{ log.accion }}
                    </span>
                    <div class="flex items-center gap-1.5 ml-1">
                      <span class="text-[10px] font-black text-on-surface/40 tracking-tighter uppercase">{{ log.entidad }}</span>
                      <div v-if="log.entidad_id" class="flex items-center gap-1 group/id">
                        <span class="px-2 py-0.5 rounded-lg bg-on-surface/5 text-on-surface/40 text-[9px] font-black">#{{ log.entidad_id }}</span>
                        <button @click.stop="copyToClipboard(log.entidad_id)" class="opacity-0 group-hover/id:opacity-100 transition-opacity text-accent-neon hover:scale-110" title="Copiar ID">
                          <span class="material-symbols-outlined text-[14px]">content_copy</span>
                        </button>
                      </div>
                    </div>
                  </div>
                </td>

                <td class="p-6">
                  <div class="flex items-center gap-3 group/ip">
                    <div class="w-8 h-8 rounded-lg bg-on-surface/5 flex items-center justify-center text-on-surface/30 group-hover/ip:bg-accent-neon/10 group-hover/ip:text-accent-neon transition-all">
                      <span class="material-symbols-outlined text-sm">lan</span>
                    </div>
                    <div class="flex flex-col">
                      <span class="text-xs font-mono text-on-surface/60 font-black group-hover/ip:text-on-surface transition-colors">{{ log.direccion_ip || '0.0.0.0' }}</span>
                      <div class="flex items-center gap-1.5">
                        <span class="px-1.5 py-0.5 rounded-md bg-on-surface/5 text-[8px] font-black uppercase tracking-tight text-on-surface/30 group-hover/ip:text-on-surface/50">{{ log.metodo_request }}</span>
                        <span class="w-1 h-1 rounded-full bg-on-surface/10"></span>
                        <span class="text-[8px] text-on-surface/10 font-bold uppercase group-hover/ip:text-accent-neon/40">Request OK</span>
                      </div>
                    </div>
                  </div>
                </td>

                <td class="p-6">
                  <p class="text-xs text-on-surface/50 leading-relaxed max-w-xs line-clamp-2 italic font-medium group-hover:text-on-surface/70 transition-colors">
                    "{{ log.descripcion || 'Sin descripción detallada' }}"
                  </p>
                </td>

                <td class="p-6 text-right">
                  <button 
                    @click="openDetails(log)" 
                    class="w-10 h-10 rounded-xl bg-accent-neon/10 flex items-center justify-center text-accent-neon hover:bg-accent-neon hover:text-black transition-all duration-300 shadow-sm hover:shadow-neon-sm ml-auto"
                  >
                    <span class="material-symbols-outlined text-lg">open_in_new</span>
                  </button>
                </td>
              </tr>
            </template>

            <tr v-if="filteredLogs.length === 0 && !loading">
              <td colspan="6" class="p-32 text-center">
                <div class="flex flex-col items-center gap-6 animate-float">
                  <div class="w-24 h-24 rounded-full bg-on-surface/5 flex items-center justify-center text-on-surface/10">
                    <span class="material-symbols-outlined text-6xl">search_off</span>
                  </div>
                  <div>
                    <h4 class="text-xl font-black text-on-surface font-lexend">Silencio en la red</h4>
                    <p class="text-sm font-bold text-on-surface/30 uppercase tracking-[0.2em] mt-2">No hay registros que coincidan con tus parámetros</p>
                  </div>
                  <button @click="resetFilters" class="btn-premium glass-card px-8">Restablecer Filtros</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

    <!-- Pagination -->
    <div class="flex items-center justify-between px-8 py-4 bg-on-surface/[0.03] rounded-[40px] !border-none">
      <div class="flex flex-col">
        <p class="text-[10px] font-black text-on-surface/30 uppercase tracking-widest">
          Mostrando {{ Math.min((currentPage - 1) * itemsPerPage + 1, filteredLogs.length) }} - {{ Math.min(currentPage * itemsPerPage, filteredLogs.length) }} 
          de {{ filteredLogs.length }} eventos
        </p>
      </div>
      
      <div class="flex items-center gap-4">
        <div class="flex items-center gap-2 mr-4">
           <span class="text-[10px] font-black text-on-surface/20 uppercase">Por página:</span>
           <select v-model="itemsPerPage" @change="currentPage = 1" class="bg-transparent text-[10px] font-black text-on-surface/40 border-none outline-none cursor-pointer">
             <option :value="10">10</option>
             <option :value="20">20</option>
             <option :value="50">50</option>
             <option :value="100">100</option>
           </select>
        </div>

        <div class="flex gap-2">
          <button 
            @click="currentPage--" 
            :disabled="currentPage === 1"
            class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:bg-accent-neon hover:text-black disabled:opacity-20 transition-all shadow-sm"
          >
            <span class="material-symbols-outlined text-sm">chevron_left</span>
          </button>
          
          <div class="flex items-center px-4 bg-on-surface/5 rounded-xl">
            <span class="text-[10px] font-black text-on-surface tracking-widest">{{ currentPage }} <span class="text-on-surface/20">/</span> {{ totalPages || 1 }}</span>
          </div>

          <button 
            @click="currentPage++" 
            :disabled="currentPage >= totalPages"
            class="w-10 h-10 rounded-xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:bg-accent-neon hover:text-black disabled:opacity-20 transition-all shadow-sm"
          >
            <span class="material-symbols-outlined text-sm">chevron_right</span>
          </button>
        </div>
      </div>
    </div>

    <!-- Detail Modal -->
    <transition name="modal-pop">
      <div v-if="selectedLog" class="fixed inset-0 z-[400] flex items-center justify-center p-4 sm:p-10">
        <div class="absolute inset-0 bg-background/80 backdrop-blur-3xl transition-opacity" @click="selectedLog = null"></div>
        
        <div class="relative w-full max-w-5xl h-full max-h-[90vh] flex flex-col glass-card-premium rounded-[40px] overflow-hidden shadow-2xl animate-scale-in border-none">
          <!-- Modal Header -->
          <div class="p-10 flex items-center justify-between bg-on-surface/[0.02]">
            <div class="flex items-center gap-6">
              <div :class="['w-16 h-16 rounded-[24px] flex items-center justify-center shadow-2xl group transition-all', getActionBgClass(selectedLog.accion)]">
                <span class="material-symbols-outlined text-white text-3xl group-hover:scale-110 transition-transform">{{ getActionIcon(selectedLog.accion) }}</span>
              </div>
              <div>
                <div class="flex items-center gap-3">
                  <h3 class="text-3xl font-black text-on-surface font-lexend tracking-tighter">{{ selectedLog.accion }}</h3>
                  <span class="px-3 py-1 rounded-full bg-accent-neon/10 text-accent-neon text-[10px] font-black tracking-widest">REF: {{ selectedLog.id }}</span>
                </div>
                <p class="text-[10px] font-bold text-on-surface/40 uppercase tracking-[0.3em] mt-1">{{ selectedLog.entidad }} // Identificador: #{{ selectedLog.entidad_id || 'Global' }}</p>
              </div>
            </div>
            <button @click="selectedLog = null" class="w-14 h-14 rounded-3xl bg-on-surface/5 flex items-center justify-center text-on-surface/40 hover:bg-red-500 hover:text-white hover:rotate-90 transition-all duration-500">
              <span class="material-symbols-outlined text-2xl">close</span>
            </button>
          </div>

          <!-- Modal Body -->
          <div class="flex-1 overflow-y-auto p-10 space-y-12 custom-scrollbar bg-gradient-to-b from-transparent to-accent-neon/[0.01]">
            <!-- Contextual Information -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
              <div class="glass-card p-6 bg-on-surface/[0.02] border-none shadow-none">
                <p class="text-[10px] font-black text-on-surface/20 uppercase tracking-widest mb-4 flex items-center gap-2">
                  <span class="material-symbols-outlined text-sm">person</span> Responsable
                </p>
                <div v-if="selectedLog.usuario" class="flex flex-col gap-1">
                  <span class="text-sm font-black text-on-surface">{{ selectedLog.usuario.nombres }} {{ selectedLog.usuario.apellidos }}</span>
                  <span class="text-[11px] text-accent-neon font-bold font-mono">{{ selectedLog.usuario.correo }}</span>
                  <span class="text-[9px] text-on-surface/40 font-bold uppercase mt-2 bg-on-surface/5 w-fit px-2 py-0.5 rounded-md">ID: {{ selectedLog.usuario_id }}</span>
                </div>
                <div v-else class="flex flex-col gap-1 opacity-40">
                  <span class="text-sm font-black text-on-surface italic">Agente de Sistema</span>
                  <span class="text-[10px] font-bold uppercase tracking-tighter">Proceso Interno Lms</span>
                </div>
              </div>

              <div class="glass-card p-6 bg-on-surface/[0.02] border-none shadow-none">
                <p class="text-[10px] font-black text-on-surface/20 uppercase tracking-widest mb-4 flex items-center gap-2">
                  <span class="material-symbols-outlined text-sm">terminal</span> Origen de Petición
                </p>
                <div class="flex flex-col gap-2">
                  <div class="flex items-center gap-2">
                    <span class="text-xs font-black font-mono text-on-surface">{{ selectedLog.direccion_ip }}</span>
                    <span class="w-1.5 h-1.5 rounded-full bg-accent-neon animate-pulse"></span>
                  </div>
                  <p class="text-[9px] text-on-surface/40 font-bold leading-relaxed break-all font-mono">{{ selectedLog.user_agent }}</p>
                </div>
              </div>

              <div class="glass-card p-6 bg-on-surface/[0.02] border-none shadow-none">
                <p class="text-[10px] font-black text-on-surface/20 uppercase tracking-widest mb-4 flex items-center gap-2">
                  <span class="material-symbols-outlined text-sm">schedule</span> Cronología
                </p>
                <div class="flex flex-col gap-1">
                  <span class="text-sm font-black text-on-surface">{{ formatDateLong(selectedLog.fecha_creacion) }}</span>
                  <span class="text-xl font-black text-accent-neon font-lexend">{{ formatTime(selectedLog.fecha_creacion) }}</span>
                  <p class="text-[9px] text-on-surface/30 font-bold uppercase mt-2">{{ getTimeAgo(selectedLog.fecha_creacion) }}</p>
                </div>
              </div>
            </div>

            <!-- Activity Narrative -->
            <div class="space-y-6">
              <div class="flex items-center gap-4">
                <h4 class="text-[10px] font-black text-on-surface/30 uppercase tracking-[0.3em] whitespace-nowrap">Narrativa de Actividad</h4>
                <div class="h-px flex-1 bg-on-surface/5"></div>
              </div>
              
              <div class="bg-accent-neon/[0.03] p-8 rounded-[32px] relative overflow-hidden group/desc border-none">
                <div class="absolute left-0 top-0 bottom-0 w-1.5 bg-accent-neon shadow-neon-sm"></div>
                <span class="material-symbols-outlined absolute -right-4 -bottom-4 text-9xl text-accent-neon opacity-[0.03] rotate-12 transition-transform group-hover/desc:scale-110 group-hover/desc:rotate-0 duration-1000">sticky_note_2</span>
                
                <p class="text-lg font-medium leading-relaxed text-on-surface/80 italic relative z-10">
                  "{{ selectedLog.descripcion }}"
                </p>
                
                <div class="mt-8 flex items-center gap-6 relative z-10">
                  <div class="flex flex-col">
                    <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Método</span>
                    <span class="text-xs font-black text-accent-neon font-mono">{{ selectedLog.metodo_request }}</span>
                  </div>
                  <div class="w-px h-6 bg-on-surface/10"></div>
                  <div class="flex flex-col">
                    <span class="text-[9px] font-black text-on-surface/30 uppercase tracking-widest">Endpoint</span>
                    <span class="text-xs font-black text-on-surface/60 font-mono">{{ selectedLog.endpoint }}</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- Data Snapshot Analysis -->
            <div class="space-y-8">
              <div class="flex items-center gap-4">
                <h4 class="text-[10px] font-black text-on-surface/30 uppercase tracking-[0.3em] whitespace-nowrap">Análisis de Datos (Snapshots)</h4>
                <div class="h-px flex-1 bg-on-surface/5"></div>
              </div>

              <!-- Visual Diff Viewer (New) -->
              <div v-if="diffAnalysis" class="glass-card-premium p-10 space-y-8 bg-gradient-to-br from-accent-neon/[0.03] to-transparent border-none">
                <div class="flex items-center justify-between">
                  <div class="flex items-center gap-4">
                    <div class="w-12 h-12 rounded-2xl bg-accent-neon/20 flex items-center justify-center text-accent-neon shadow-neon-sm">
                      <span class="material-symbols-outlined text-2xl">difference</span>
                    </div>
                    <div>
                      <h4 class="text-lg font-black text-on-surface font-lexend uppercase tracking-tight">Cambios Detectados</h4>
                      <p class="text-[10px] font-bold text-on-surface/30 uppercase tracking-[0.2em] mt-0.5">Detección automática de discrepancias en JSON</p>
                    </div>
                  </div>
                  <div class="flex flex-col items-end">
                    <span class="px-4 py-1.5 rounded-full bg-accent-neon text-black text-[10px] font-black uppercase tracking-widest shadow-neon-sm">{{ diffAnalysis.length }} Modificaciones</span>
                  </div>
                </div>
                
                <div class="grid grid-cols-1 gap-6">
                  <div v-for="change in diffAnalysis" :key="change.key" 
                       class="group/diffitem p-8 rounded-[32px] bg-background/40 hover:bg-on-surface/[0.01] transition-all duration-500 shadow-xl border-none">
                    <div class="flex items-center justify-between mb-6">
                      <div class="flex items-center gap-3">
                        <div class="w-2 h-8 rounded-full bg-accent-neon shadow-neon-sm transition-transform group-hover/diffitem:scale-y-125"></div>
                        <span class="text-sm font-black text-on-surface uppercase tracking-[0.3em] font-lexend">{{ change.key }}</span>
                      </div>
                      <div class="flex items-center gap-2">
                        <button @click="copyToClipboard(change.old)" class="p-2.5 rounded-xl hover:bg-red-500/10 text-red-500/30 hover:text-red-500 transition-all" title="Copiar anterior">
                          <span class="material-symbols-outlined text-sm">history</span>
                        </button>
                        <button @click="copyToClipboard(change.new)" class="p-2.5 rounded-xl hover:bg-green-500/10 text-green-500/30 hover:text-green-500 transition-all" title="Copiar nuevo">
                          <span class="material-symbols-outlined text-sm">content_copy</span>
                        </button>
                      </div>
                    </div>
                    
                    <div class="grid grid-cols-1 md:grid-cols-[1fr,auto,1fr] gap-6 items-center">
                      <div class="p-6 rounded-2xl bg-red-500/[0.03] relative group/old overflow-hidden min-h-[100px] border-none">
                        <span class="text-[9px] font-black text-red-500/40 uppercase tracking-widest block mb-3">Valor Anterior</span>
                        <pre class="text-[11px] text-red-500/80 font-mono whitespace-pre-wrap break-all leading-relaxed">{{ typeof change.old === 'object' ? JSON.stringify(change.old, null, 2) : (change.old || '(Vacio)') }}</pre>
                      </div>
                      
                      <div class="flex items-center justify-center">
                        <div class="w-10 h-10 rounded-full bg-on-surface/5 flex items-center justify-center text-on-surface/20 group-hover/diffitem:text-accent-neon group-hover/diffitem:bg-accent-neon/10 transition-all duration-500 rotate-90 md:rotate-0">
                          <span class="material-symbols-outlined text-xl">double_arrow</span>
                        </div>
                      </div>
                      
                      <div class="p-6 rounded-2xl bg-green-500/[0.03] relative group/new overflow-hidden min-h-[100px] border-none">
                        <span class="text-[9px] font-black text-green-500/40 uppercase tracking-widest block mb-3">Valor Nuevo</span>
                        <pre class="text-[11px] text-green-500 font-mono whitespace-pre-wrap break-all leading-relaxed font-bold">{{ typeof change.new === 'object' ? JSON.stringify(change.new, null, 2) : (change.new || '(Vacio)') }}</pre>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="grid grid-cols-1 lg:grid-cols-2 gap-10">
                <!-- Previous State -->
                <div class="space-y-4">
                  <div class="flex items-center justify-between">
                    <div class="flex items-center gap-2">
                      <div class="w-2 h-2 rounded-full bg-red-500 shadow-[0_0_8px_rgba(239,68,68,0.5)]"></div>
                      <h4 class="text-[10px] font-black text-red-500 uppercase tracking-widest">Estado Completo Anterior</h4>
                    </div>
                  </div>
                  <div class="bg-[#050505] rounded-[32px] p-8 font-mono text-[11px] leading-relaxed overflow-x-auto min-h-[250px] shadow-inner relative group/code border-none">
                    <button @click="copyToClipboard(selectedLog.valores_anteriores)" v-if="selectedLog.valores_anteriores" class="absolute right-4 top-4 w-8 h-8 rounded-lg bg-white/5 flex items-center justify-center opacity-0 group-hover/code:opacity-100 hover:bg-white/10 transition-all">
                      <span class="material-symbols-outlined text-sm">content_copy</span>
                    </button>
                    <pre v-if="selectedLog.valores_anteriores" class="text-on-surface/40">{{ JSON.stringify(selectedLog.valores_anteriores, null, 2) }}</pre>
                    <div v-else class="h-full flex flex-col items-center justify-center gap-4 opacity-10 py-20">
                      <span class="material-symbols-outlined text-6xl">history</span>
                      <p class="text-[10px] font-black uppercase tracking-widest">Sin registro previo</p>
                    </div>
                  </div>
                </div>

                <!-- New State -->
                <div class="space-y-4">
                  <div class="flex items-center justify-between">
                    <div class="flex items-center gap-2">
                      <div class="w-2 h-2 rounded-full bg-green-500 shadow-[0_0_8px_rgba(34,197,94,0.5)]"></div>
                      <h4 class="text-[10px] font-black text-green-500 uppercase tracking-widest">Estado Completo Nuevo</h4>
                    </div>
                  </div>
                  <div class="bg-[#050505] rounded-[32px] p-8 font-mono text-[11px] leading-relaxed overflow-x-auto min-h-[250px] shadow-inner relative group/code border-none">
                    <button @click="copyToClipboard(selectedLog.valores_nuevos)" v-if="selectedLog.valores_nuevos" class="absolute right-4 top-4 w-8 h-8 rounded-lg bg-white/5 flex items-center justify-center opacity-0 group-hover/code:opacity-100 hover:bg-white/10 transition-all">
                      <span class="material-symbols-outlined text-sm">content_copy</span>
                    </button>
                    <pre v-if="selectedLog.valores_nuevos" class="text-green-500/60">{{ JSON.stringify(selectedLog.valores_nuevos, null, 2) }}</pre>
                    <div v-else class="h-full flex flex-col items-center justify-center gap-4 opacity-10 py-20">
                      <span class="material-symbols-outlined text-6xl">data_object</span>
                      <p class="text-[10px] font-black uppercase tracking-widest">Sin mutación resultante</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Modal Footer -->
          <div class="p-8 bg-on-surface/[0.04] flex items-center justify-between">
            <p class="text-[10px] font-bold text-on-surface/20 uppercase tracking-[0.2em]">Registro generado por AuditoriaInterceptor v2.0</p>
            <button @click="selectedLog = null" class="btn-premium px-12 !py-4 shadow-neon-sm">Finalizar Revisión</button>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from '@/services/api'
import { useNotificationStore } from '@/stores/notificationStore'
import { useModalStore } from '@/stores/modalStore'

const logs = ref([])
const loading = ref(true)
const selectedLog = ref(null)
const notificationStore = useNotificationStore()
const modalStore = useModalStore()

// Filter states
const searchQuery = ref('')
const filterAction = ref('all')
const filterDateStart = ref('')
const filterDateEnd = ref('')
const showDatePicker = ref(false)

// Pagination
const currentPage = ref(1)
const itemsPerPage = ref(20)

const hasDateFilter = computed(() => {
  return filterDateStart.value || filterDateEnd.value
})

const filteredLogs = computed(() => {
  if (!logs.value) return []
  
  return logs.value.filter(log => {
    // Search filter
    const query = searchQuery.value.toLowerCase()
    const matchesSearch = !query || 
      log.accion?.toLowerCase().includes(query) ||
      (log.usuario && (log.usuario.nombres + ' ' + log.usuario.apellidos).toLowerCase().includes(query)) ||
      log.entidad?.toLowerCase().includes(query) ||
      log.descripcion?.toLowerCase().includes(query) ||
      String(log.entidad_id).includes(query) ||
      log.direccion_ip?.includes(query) ||
      String(log.id).includes(query)

    // Action/Method filter
    const matchesAction = filterAction.value === 'all' || 
      (filterAction.value === 'POST' && log.metodo_request === 'POST') ||
      (filterAction.value === 'PUT' && ['PUT', 'PATCH'].includes(log.metodo_request)) ||
      (filterAction.value === 'DELETE' && log.metodo_request === 'DELETE') ||
      (filterAction.value === 'LOGIN' && (log.accion.includes('LOGIN') || log.endpoint.includes('login')))

    // Date filter
    let matchesDate = true
    if (filterDateStart.value && filterDateEnd.value) {
      const logDate = new Date(log.fecha_creacion).toISOString().split('T')[0]
      matchesDate = logDate >= filterDateStart.value && logDate <= filterDateEnd.value
    } else if (filterDateStart.value) {
      const logDate = new Date(log.fecha_creacion).toISOString().split('T')[0]
      matchesDate = logDate >= filterDateStart.value
    } else if (filterDateEnd.value) {
      const logDate = new Date(log.fecha_creacion).toISOString().split('T')[0]
      matchesDate = logDate <= filterDateEnd.value
    }

    return matchesSearch && matchesAction && matchesDate
  }).sort((a, b) => new Date(b.fecha_creacion) - new Date(a.fecha_creacion))
})

const hasFilters = computed(() => {
  return searchQuery.value || filterDateStart.value || filterDateEnd.value || filterAction.value !== 'all'
})

const totalPages = computed(() => Math.ceil(filteredLogs.value.length / itemsPerPage.value))

const paginatedLogs = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage.value
  const end = start + itemsPerPage.value
  return filteredLogs.value.slice(start, end)
})

const groupedLogs = computed(() => {
  const groups = {}
  paginatedLogs.value.forEach(log => {
    const date = formatDate(log.fecha_creacion)
    if (!groups[date]) groups[date] = []
    groups[date].push(log)
  })
  return groups
})

const fetchLogs = async () => {
  loading.value = true
  try {
    const res = await api.get('/auditoria')
    logs.value = res.data
  } catch (error) {
    console.error('Error fetching logs:', error)
    notificationStore.addNotification({
      title: 'Fallo de Sincronización',
      message: 'No se pudo recuperar el historial de auditoría desde el servidor.',
      type: 'error'
    })
  } finally {
    loading.value = false
  }
}

// Stats computations
// Stats computations
const totalLogs = computed(() => logs.value.length)
const stats = computed(() => {
  const creations = logs.value.filter(l => l.metodo_request === 'POST').length
  const updates = logs.value.filter(l => ['PUT', 'PATCH'].includes(l.metodo_request)).length
  const deletions = logs.value.filter(l => l.metodo_request === 'DELETE').length
  
  const today = new Date().toISOString().split('T')[0]
  const creationsToday = logs.value.filter(l => l.metodo_request === 'POST' && l.fecha_creacion.startsWith(today)).length
  
  const updatesPct = totalLogs.value > 0 ? Math.round((updates / totalLogs.value) * 100) : 0
  
  return { creations, updates, deletions, creationsToday, updatesPct }
})

const diffAnalysis = computed(() => {
  if (!selectedLog.value || !selectedLog.value.valores_anteriores || !selectedLog.value.valores_nuevos) return null
  
  const oldVal = selectedLog.value.valores_anteriores
  const newVal = selectedLog.value.valores_nuevos
  const changes = []
  
  const allKeys = new Set([...Object.keys(oldVal), ...Object.keys(newVal)])
  allKeys.forEach(key => {
    const vOld = oldVal[key]
    const vNew = newVal[key]
    if (JSON.stringify(vOld) !== JSON.stringify(vNew)) {
      changes.push({
        key,
        old: vOld,
        new: vNew
      })
    }
  })
  
  return changes.length > 0 ? changes : null
})

const topStats = computed(() => {
  const userCounts = {}
  const entityCounts = {}
  
  logs.value.forEach(log => {
    if (log.usuario) {
      const name = `${log.usuario.nombres} ${log.usuario.apellidos}`
      userCounts[name] = (userCounts[name] || 0) + 1
    }
    entityCounts[log.entidad] = (entityCounts[log.entidad] || 0) + 1
  })
  
  const topUser = Object.entries(userCounts).sort((a, b) => b[1] - a[1])[0] || ['Sistema', 0]
  const topEntity = Object.entries(entityCounts).sort((a, b) => b[1] - a[1])[0] || ['N/A', 0]
  
  return { topUser, topEntity }
})

const activityChart = computed(() => {
  const days = {}
  const now = new Date()
  for (let i = 9; i >= 0; i--) {
    const d = new Date()
    d.setDate(now.getDate() - i)
    days[d.toISOString().split('T')[0]] = 0
  }
  
  logs.value.forEach(log => {
    const date = log.fecha_creacion.split('T')[0]
    if (days[date] !== undefined) {
      days[date]++
    }
  })
  
  const max = Math.max(...Object.values(days), 1)
  return Object.entries(days).map(([date, count]) => ({
    date,
    count,
    height: (count / max) * 100
  }))
})



const resetFilters = () => {
  searchQuery.value = ''
  filterDateStart.value = ''
  filterDateEnd.value = ''
  filterAction.value = 'all'
  showDatePicker.value = false
}

const setQuickDate = (period) => {
  const now = new Date()
  const today = now.toISOString().split('T')[0]
  
  if (period === 'today') {
    filterDateStart.value = today
    filterDateEnd.value = today
  } else if (period === 'week') {
    const lastWeekDate = new Date()
    lastWeekDate.setDate(now.getDate() - 7)
    filterDateStart.value = lastWeekDate.toISOString().split('T')[0]
    filterDateEnd.value = today
  } else if (period === 'month') {
    const lastMonthDate = new Date()
    lastMonthDate.setMonth(now.getMonth() - 1)
    filterDateStart.value = lastMonthDate.toISOString().split('T')[0]
    filterDateEnd.value = today
  }
}

const isQuickDateActive = (period) => {
  const now = new Date()
  const today = now.toISOString().split('T')[0]
  if (period === 'today') {
    return filterDateStart.value === today && filterDateEnd.value === today
  }
  if (period === 'week') {
    const lastWeekDate = new Date()
    lastWeekDate.setDate(now.getDate() - 7)
    const lastWeek = lastWeekDate.toISOString().split('T')[0]
    return filterDateStart.value === lastWeek && filterDateEnd.value === today
  }
  if (period === 'month') {
    const lastMonthDate = new Date()
    lastMonthDate.setMonth(now.getMonth() - 1)
    const lastMonth = lastMonthDate.toISOString().split('T')[0]
    return filterDateStart.value === lastMonth && filterDateEnd.value === today
  }
  return false
}

const formatDate = (dateStr) => {
  return new Date(dateStr).toLocaleDateString('es-ES', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  })
}

const formatDateShort = (dateStr) => {
  return new Date(dateStr).toLocaleDateString('es-ES', {
    day: '2-digit',
    month: '2-digit'
  })
}

const formatDateLong = (dateStr) => {
  return new Date(dateStr).toLocaleDateString('es-ES', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  })
}

const formatTime = (dateStr) => {
  return new Date(dateStr).toLocaleTimeString('es-ES', {
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit'
  })
}

const getTimeAgo = (dateStr) => {
  const seconds = Math.floor((new Date() - new Date(dateStr)) / 1000)
  if (seconds < 60) return 'Hace un momento'
  const minutes = Math.floor(seconds / 60)
  if (minutes < 60) return `Hace ${minutes} min`
  const hours = Math.floor(minutes / 60)
  if (hours < 24) return `Hace ${hours} h`
  return 'Hace más de un día'
}

const openDetails = (log) => {
  selectedLog.value = log
}

const copyToClipboard = (data) => {
  if (!data) return
  navigator.clipboard.writeText(JSON.stringify(data, null, 2))
  notificationStore.addNotification({
    title: 'Copiado',
    message: 'JSON copiado al portapapeles',
    type: 'success'
  })
}

const exportToCSV = () => {
  if (filteredLogs.value.length === 0) return

  const headers = ['Fecha', 'Hora', 'Usuario', 'Correo', 'Accion', 'Entidad', 'ID_Entidad', 'IP', 'Metodo', 'Endpoint', 'Descripcion']
  const rows = filteredLogs.value.map(log => [
    formatDate(log.fecha_creacion),
    formatTime(log.fecha_creacion),
    log.usuario ? `${log.usuario.nombres} ${log.usuario.apellidos}` : 'Sistema',
    log.usuario ? log.usuario.correo : 'N/A',
    log.accion,
    log.entidad,
    log.entidad_id || '',
    log.direccion_ip || '',
    log.metodo_request || '',
    log.endpoint || '',
    log.descripcion || ''
  ])

  const csvContent = "data:text/csv;charset=utf-8," 
    + headers.join(',') + "\n"
    + rows.map(e => e.map(cell => `"${String(cell).replace(/"/g, '""')}"`).join(",")).join("\n")

  const encodedUri = encodeURI(csvContent)
  const link = document.createElement("a")
  link.setAttribute("href", encodedUri)
  link.setAttribute("download", `auditoria_export_${new Date().getTime()}.csv`)
  document.body.appendChild(link)
  link.click()
  document.body.removeChild(link)
}

const confirmClearAll = () => {
  modalStore.openModal({
    title: '¿Purgar Bitácora Completa?',
    message: 'Esta acción eliminará permanentemente todos los registros de auditoría almacenados. No se recomienda a menos que el volumen de datos esté afectando el rendimiento.',
    confirmText: 'Sí, Purgar Todo',
    cancelText: 'Cancelar',
    type: 'danger',
    onConfirm: async () => {
      try {
        loading.value = true
        await api.delete('/auditoria/all/clear')
        notificationStore.addNotification({
          title: 'Purgado Exitoso',
          message: 'Se ha limpiado la base de datos de auditoría.',
          type: 'success'
        })
        logs.value = []
      } catch (error) {
        console.error('Error clearing logs:', error)
        notificationStore.addNotification({
          title: 'Error Crítico',
          message: 'Fallo al intentar limpiar la bitácora.',
          type: 'error'
        })
      } finally {
        loading.value = false
      }
    }
  })
}

// UI Helpers
const getActionClass = (accion) => {
  const a = accion.toLowerCase()
  if (a.includes('post') || a.includes('crear') || a.includes('create')) return 'bg-green-500/10 text-green-500'
  if (a.includes('delete') || a.includes('eliminar') || a.includes('remove')) return 'bg-red-500/10 text-red-500'
  if (a.includes('put') || a.includes('patch') || a.includes('actualizar') || a.includes('update')) return 'bg-blue-500/10 text-blue-500 border-blue-500/20'
  if (a.includes('login')) return 'bg-accent-neon/10 text-accent-neon'
  return 'bg-on-surface/5 text-on-surface/40'
}

const getActionBgClass = (accion) => {
  const a = accion.toLowerCase()
  if (a.includes('post') || a.includes('crear') || a.includes('create')) return 'bg-green-500'
  if (a.includes('delete') || a.includes('eliminar') || a.includes('remove')) return 'bg-red-500'
  if (a.includes('put') || a.includes('patch') || a.includes('actualizar') || a.includes('update')) return 'bg-blue-500'
  return 'bg-accent-neon'
}

const getActionIcon = (accion) => {
  const a = accion.toLowerCase()
  if (a.includes('crear') || a.includes('create')) return 'add_circle'
  if (a.includes('eliminar') || a.includes('delete')) return 'delete_forever'
  if (a.includes('actualizar') || a.includes('update')) return 'published_with_changes'
  if (a.includes('login')) return 'login'
  return 'info'
}

onMounted(() => {
  fetchLogs()
})
</script>

<style scoped>
.animate-fade-in {
  animation: fadeIn 0.8s cubic-bezier(0.16, 1, 0.3, 1);
}

.animate-scale-in {
  animation: scaleIn 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}

@keyframes scaleIn {
  from { opacity: 0; transform: scale(0.9) translateY(40px); }
  to { opacity: 1; transform: scale(1) translateY(0); }
}

.animate-pulse-slow {
  animation: pulseSlow 3s infinite;
}

@keyframes pulseSlow {
  0%, 100% { opacity: 1; transform: scaleX(1); }
  50% { opacity: 0.6; transform: scaleX(0.98); }
}

.animate-float {
  animation: float 6s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: rgba(var(--on-surface-rgb), 0.01);
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(var(--accent-neon-rgb), 0.1);
  border-radius: 10px;
}

.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background: rgba(var(--accent-neon-rgb), 0.3);
}

.modal-pop-enter-active, .modal-pop-leave-active {
  transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
}

.modal-pop-enter-from, .modal-pop-leave-to {
  opacity: 0;
  transform: scale(0.95);
}

.btn-icon-premium {
  width: 2.5rem;
  height: 2.5rem;
  border-radius: 0.75rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: var(--surface-glass);
  color: var(--on-surface-variant);
  transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
  border: 1px solid var(--input-border);
}

.btn-icon-premium:hover {
  background-color: var(--accent-neon);
  color: #000;
  box-shadow: 0 0 20px rgba(6, 182, 212, 0.4);
  transform: translateY(-2px);
  border-color: transparent;
}

/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
</style>
