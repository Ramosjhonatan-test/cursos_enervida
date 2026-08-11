<template>
  <div class="max-w-[1600px] mx-auto min-h-screen flex flex-col p-4 md:p-6 lg:p-8">
    <!-- Header -->
    <div class="panel-hero p-6 mb-8">
      <div class="flex flex-col md:flex-row justify-between items-center gap-6">
        <div class="flex items-center gap-4">
          <router-link to="/admin/certificados" class="p-3 bg-on-surface/5 hover:bg-on-surface/10 rounded-2xl transition-all text-on-surface/60 active:scale-95">
            <span class="material-symbols-outlined">arrow_back</span>
          </router-link>
          <div>
            <h2 class="text-2xl md:text-4xl font-black text-on-surface font-lexend tracking-tighter">
              Editor de <span class="text-accent-neon italic">Certificado</span>
            </h2>
            <p class="text-on-surface/40 font-bold uppercase tracking-widest text-[10px] mt-1">{{ curso?.titulo || 'Cargando...' }}</p>
          </div>
        </div>
        <div class="flex items-center gap-4">
          <!-- Canvas Controls -->
          <div class="flex items-center gap-2 bg-on-surface/5 rounded-2xl p-1">
            <div class="w-px h-4 bg-on-surface/10 mx-1"></div>
            <div class="w-px h-4 bg-on-surface/10 mx-1"></div>
            <button @click="canvasScale = Math.max(0.1, canvasScale - 0.1)" class="p-2 hover:bg-on-surface/10 rounded-xl text-on-surface/60 transition-colors">
              <span class="material-symbols-outlined text-sm">zoom_out</span>
            </button>
            <span class="text-[10px] font-black w-12 text-center text-on-surface/40">{{ Math.round(canvasScale * 100) }}%</span>
            <button @click="canvasScale = Math.min(2, canvasScale + 0.1)" class="p-2 hover:bg-on-surface/10 rounded-xl text-on-surface/60 transition-colors">
              <span class="material-symbols-outlined text-sm">zoom_in</span>
            </button>
          </div>

          <div class="flex gap-3">
            <button v-if="plantillaId" @click="previewPdf" :disabled="saving" class="btn-premium bg-on-surface/5 hover:bg-on-surface/10 !text-on-surface !px-6 flex items-center gap-2 group">
              <span class="material-symbols-outlined text-xl group-hover:scale-110 transition-transform">picture_as_pdf</span>
              Vista Previa Real
            </button>
            <button @click="saveTemplate" :disabled="saving || (!backgroundUrl && elements.length === 0)" class="btn-premium btn-primary-neon !px-10 flex items-center gap-2 group">
              <span class="material-symbols-outlined text-xl group-hover:rotate-180 transition-transform duration-500">{{ saving ? 'sync' : 'verified' }}</span>
              {{ saving ? 'Guardando...' : 'Publicar Plantilla' }}
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="flex flex-col lg:flex-row gap-8 flex-grow overflow-hidden">
      <!-- Left Sidebar: Tools & Layers -->
      <div class="w-full lg:w-96 flex flex-col gap-6 shrink-0 h-full overflow-y-auto custom-scrollbar pr-2">
        <!-- Page Settings -->
        <div class="glass-card p-6 rounded-[32px]">
          <h3 class="text-sm font-black text-on-surface mb-4 flex items-center gap-2 uppercase tracking-widest">
            <span class="material-symbols-outlined text-accent-neon">settings_overscan</span>
            Ajustes de Página
          </h3>
          
          <div class="grid grid-cols-2 gap-3 mb-4">
            <div class="col-span-2">
                <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Tamaño de Hoja</p>
                <div class="flex flex-wrap gap-2">
                    <button v-for="(fmt, key) in pageFormats" :key="key"
                            @click="applyFormat(key)"
                            :class="selectedFormat === key ? 'bg-accent-neon text-primary' : 'bg-on-surface/5 text-on-surface/40'"
                            class="flex-1 py-2 px-3 rounded-xl text-[10px] font-black uppercase transition-all">
                        {{ fmt.name }}
                    </button>
                </div>
            </div>
            <div>
                <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Orientación</p>
                <button @click="toggleOrientation" class="w-full py-2 bg-on-surface/5 hover:bg-on-surface/10 rounded-xl text-[10px] font-black text-on-surface uppercase flex items-center justify-center gap-2">
                    <span class="material-symbols-outlined text-sm">{{ orientation === 'landscape' ? 'landscape' : 'portrait' }}</span>
                    {{ orientation === 'landscape' ? 'Horizontal' : 'Vertical' }}
                </button>
            </div>
            <div>
                <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Resolución</p>
                <div class="flex items-center gap-2 bg-on-surface/5 p-2 rounded-xl">
                    <span class="text-[9px] font-black text-on-surface/40">300 DPI</span>
                    <span class="material-symbols-outlined text-sm text-green-500">check_circle</span>
                </div>
            </div>
          </div>

          <div class="pt-4">
            <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-3">Imagen de Fondo</p>
            <div v-if="!backgroundUrl" class="border-2 border-dashed rounded-2xl p-6 text-center hover:border-accent-neon/30 transition-all cursor-pointer relative overflow-hidden group bg-on-surface/[0.02]">
                <input type="file" @change="handleFileUpload" class="absolute inset-0 opacity-0 cursor-pointer" accept="image/*" />
                <span class="material-symbols-outlined text-3xl text-on-surface/10 group-hover:text-accent-neon/40 transition-colors">add_photo_alternate</span>
                <p class="text-[9px] text-on-surface/40 font-black uppercase mt-2 tracking-widest">Subir Fondo</p>
            </div>
            <div v-else class="relative rounded-xl overflow-hidden group aspect-video shadow-lg">
                <img :src="getFullUrl(backgroundUrl)" class="w-full h-full object-cover" />
                <div class="absolute inset-0 bg-black/80 opacity-0 group-hover:opacity-100 transition-all flex items-center justify-center gap-2 backdrop-blur-sm">
                    <label class="p-2 bg-white/10 hover:bg-accent-neon/20 rounded-xl cursor-pointer transition-colors border-white/5">
                        <input type="file" @change="handleFileUpload" class="hidden" accept="image/*" />
                        <span class="material-symbols-outlined text-white text-sm">sync</span>
                    </label>
                    <button @click="backgroundUrl = ''" class="p-2 bg-red-500/10 hover:bg-red-500/30 rounded-xl text-red-400 transition-colors">
                        <span class="material-symbols-outlined text-sm">delete</span>
                    </button>
                </div>
            </div>
          </div>
        </div>

        <!-- Toolset -->
        <div class="glass-card p-4 rounded-[32px] flex flex-wrap gap-2">
            <button @click="addElement('text')" class="flex-1 min-w-[80px] p-4 bg-on-surface/5 hover:bg-accent-neon/10 rounded-2xl transition-all group">
                <span class="material-symbols-outlined text-on-surface/40 group-hover:text-accent-neon block mb-1">text_fields</span>
                <span class="text-[9px] font-black uppercase tracking-tighter text-on-surface/60">Texto</span>
            </button>
            <button @click="triggerImageUpload" class="flex-1 min-w-[80px] p-4 bg-on-surface/5 hover:bg-accent-neon/10 rounded-2xl transition-all group">
                <span class="material-symbols-outlined text-on-surface/40 group-hover:text-accent-neon block mb-1">signature</span>
                <span class="text-[9px] font-black uppercase tracking-tighter text-on-surface/60">Firma/Logo</span>
                <input type="file" ref="imageElementInput" class="hidden" @change="handleAddImageElement" accept="image/*" />
            </button>
            <button @click="addElement('qr')" class="flex-1 min-w-[80px] p-4 bg-on-surface/5 hover:bg-accent-neon/10 rounded-2xl transition-all group">
                <span class="material-symbols-outlined text-on-surface/40 group-hover:text-accent-neon block mb-1">qr_code_2</span>
                <span class="text-[9px] font-black uppercase tracking-tighter text-on-surface/60">Código QR</span>
            </button>
        </div>

        <!-- Layers List -->
        <div class="glass-card p-6 rounded-[32px] flex-grow overflow-hidden flex flex-col min-h-[300px]">
          <h3 class="text-sm font-black text-on-surface mb-6 flex items-center gap-2 uppercase tracking-widest">
            <span class="material-symbols-outlined text-accent-neon">layers</span>
            Capas del Diseño
          </h3>
          
          <div class="space-y-2 overflow-y-auto pr-2 custom-scrollbar flex-grow">
  <div v-for="(el, index) in elements" :key="el.id" 
       class="group p-3 rounded-xl transition-all duration-150 cursor-pointer flex items-center justify-between gap-3"
       :class="[
         selectedId === el.id 
           ? 'bg-accent-neon/10 border border-accent-neon/30 dark:bg-accent-neon/20' 
           : 'bg-gray-200/60 dark:bg-white/5 hover:bg-gray-200 dark:hover:bg-white/10 border border-transparent',
         el.hidden ? 'opacity-40' : ''
       ]"
       @click="selectedId = el.id">
    
    <!-- Lado Izquierdo: Candado + Icono tipo + Nombre de Capa -->
    <div class="flex items-center gap-2.5 min-w-0">
      <!-- Botón Bloquear/Desbloquear -->
      <button @click.stop="el.locked = !el.locked" 
              class="transition-colors p-0.5 rounded hover:bg-black/5 dark:hover:bg-white/10 shrink-0" 
              :class="el.locked ? 'text-accent-neon' : 'text-gray-400 dark:text-white/30 hover:text-gray-600 dark:hover:text-white/60'">
        <span class="material-symbols-outlined text-base">{{ el.locked ? 'lock' : 'lock_open' }}</span>
      </button>

      <!-- Icono de tipo de capa -->
      <span class="material-symbols-outlined text-lg shrink-0 transition-colors" 
            :class="selectedId === el.id ? 'text-accent-neon' : 'text-gray-400 dark:text-white/40'">
        {{ el.type === 'text' ? 'title' : el.type === 'image' ? 'image' : 'qr_code' }}
      </span>

      <!-- Nombre o contenido de la capa -->
      <span class="text-xs font-medium truncate"
            :class="selectedId === el.id ? 'font-semibold text-gray-900 dark:text-white' : 'text-gray-700 dark:text-white/80'">
        {{ el.type === 'text' ? (el.content || 'Texto vacío') : el.type === 'image' ? 'Firma/Imagen' : 'QR Validación' }}
      </span>
    </div>

    <!-- Lado Derecho: Acciones al hacer Hover (Visibilidad, Capas y Eliminar) -->
    <div class="flex items-center gap-0.5 opacity-0 group-hover:opacity-100 transition-opacity shrink-0">
      <!-- Ocultar/Mostrar -->
      <button @click.stop="el.hidden = !el.hidden" 
              class="p-1 rounded hover:bg-black/5 dark:hover:bg-white/10 text-gray-400 dark:text-white/40 hover:text-accent-neon transition-colors"
              :title="el.hidden ? 'Mostrar capa' : 'Ocultar capa'">
        <span class="material-symbols-outlined text-sm">{{ el.hidden ? 'visibility_off' : 'visibility' }}</span>
      </button>

      <!-- Bajar Capa -->
      <button @click.stop="moveLayer(index, -1)" 
              :disabled="index === 0" 
              title="Bajar capa" 
              class="p-1 rounded hover:bg-black/5 dark:hover:bg-white/10 text-gray-400 dark:text-white/40 hover:text-accent-neon disabled:opacity-20 transition-colors">
        <span class="material-symbols-outlined text-sm">keyboard_arrow_down</span>
      </button>

      <!-- Subir Capa -->
      <button @click.stop="moveLayer(index, 1)" 
              :disabled="index === elements.length - 1" 
              title="Subir capa" 
              class="p-1 rounded hover:bg-black/5 dark:hover:bg-white/10 text-gray-400 dark:text-white/40 hover:text-accent-neon disabled:opacity-20 transition-colors">
        <span class="material-symbols-outlined text-sm">keyboard_arrow_up</span>
      </button>

      <!-- Eliminar Capa -->
      <button @click.stop="removeElement(index)" 
              class="p-1 rounded hover:bg-red-500/10 text-gray-400 dark:text-white/40 hover:text-red-500 transition-colors"
              title="Eliminar capa">
        <span class="material-symbols-outlined text-sm">delete</span>
      </button>
    </div>

  </div>
</div>
        </div>
      </div>

      <!-- Main Canvas Area -->
      <div class="flex-grow flex flex-col gap-6 min-w-0 h-full">
        <div ref="mainCanvasWrapper" class="glass-card rounded-[48px] relative overflow-hidden bg-black/40 flex items-center justify-center p-4 md:p-8 flex-grow shadow-2xl min-h-[400px]">
            <!-- Scaling Container -->
            <div :style="canvasScaleStyle" class="relative shadow-[0_40px_100px_rgba(0,0,0,0.5)] bg-white origin-center transition-all duration-300 group"
                 ref="editorContainer">
                

                <!-- Background Layer -->
                <img v-if="backgroundUrl" 
                     :src="getFullUrl(backgroundUrl)" 
                     class="w-full h-full pointer-events-none select-none absolute inset-0 z-0 object-fill" 
                     style="object-fit: fill" />
                <div v-else class="absolute inset-0 bg-white z-0"></div>

                <!-- Layer Rendering -->
                <div v-for="(el, index) in elements" :key="el.id"
                     v-show="!el.hidden"
                     class="absolute cursor-move select-none border-2 transition-all"
                     :class="[
                        selectedId === el.id ? 'border-accent-neon ring-4 ring-accent-neon/20 z-20 shadow-xl' : 'border-transparent hover:border-accent-neon/30',
                        el.locked ? 'cursor-not-allowed border-dashed' : ''
                     ]"
                     :style="{
                        left: el.x + 'px',
                        top: el.y + 'px',
                        fontSize: el.type === 'text' ? el.size + 'px' : 'inherit',
                        color: el.type === 'text' ? el.color : 'inherit',
                        fontFamily: el.fontFamily || 'sans-serif',
                        fontWeight: el.bold ? 'bold' : 'normal',
                        fontStyle: el.italic ? 'italic' : 'normal',
                        textAlign: el.textAlign || 'left',
                        letterSpacing: (el.letterSpacing || 0) + 'px',
                        width: el.width + 'px',
                        height: el.height ? el.height + 'px' : 'auto',
                        transform: `rotate(${el.rotate || 0}deg)`,
                        opacity: (el.opacity ?? 100) / 100,
                        zIndex: index + 10
                     }"
                     @mousedown="!el.locked && startDrag($event, el)">
                    
                    <template v-if="el.type === 'text'">
                        <div class="whitespace-pre-wrap break-words w-full h-full flex flex-col justify-start" :style="{ lineHeight: '1.2' }">
                            {{ renderText(el.content) }}
                        </div>
                    </template>
                    
                    <template v-else-if="el.type === 'image'">
                        <img :src="getFullUrl(el.url)" class="w-full h-full object-contain pointer-events-none" />
                    </template>

                    <template v-else-if="el.type === 'qr'">
                        <div class="w-full h-full bg-white rounded-sm overflow-hidden border border-black/5">
                            <img :src="getDemoQrPlaceholder()" class="w-full h-full object-contain pointer-events-none" />
                        </div>
                    </template>
                    <!-- Control Label -->
                    <div v-if="selectedId === el.id" class="absolute -top-8 left-0 flex gap-1 animate-in slide-in-from-bottom">
                        <span class="bg-accent-neon text-primary text-[9px] font-black px-2 py-1 rounded-lg uppercase shadow-lg flex items-center gap-1">
                            <span class="material-symbols-outlined text-[10px]">{{ el.locked ? 'lock' : 'drag_pan' }}</span>
                            {{ el.type }} {{ Math.round(el.width) }}x{{ Math.round(el.height) }}
                        </span>
                    </div>

                    <!-- Resize Handles -->
                    <template v-if="selectedId === el.id && !el.locked">
                        <!-- Right handle (for width/wrapping) -->
                        <div class="absolute top-1/2 -right-2 -translate-y-1/2 w-3 h-8 bg-accent-neon rounded-full cursor-ew-resize z-30 shadow-neon-sm"
                             @mousedown.stop="startResize($event, el, 'width')"></div>
                        
                        <!-- Bottom handle (height) -->
                        <div class="absolute -bottom-2 left-1/2 -translate-x-1/2 w-8 h-3 bg-accent-neon rounded-full cursor-ns-resize z-30 shadow-neon-sm"
                             @mousedown.stop="startResize($event, el, 'height')"></div>

                        <!-- Corner handle (proportional) -->
                        <div class="absolute -bottom-2 -right-2 w-4 h-4 bg-accent-neon border-2 border-primary rounded-full cursor-nwse-resize z-30 shadow-neon-sm hover:scale-125 transition-transform"
                             @mousedown.stop="startResize($event, el, 'corner')"></div>
                    </template>
                </div>
            </div>
        </div>

        <!-- Properties Panel (Floating at bottom if selection exists) -->
        <transition name="slide-up">
            <div v-if="selectedElement" class="glass-card rounded-[32px] p-6 flex flex-wrap items-center gap-8 shadow-2xl relative z-50">
                <div class="flex items-center gap-3 pr-8">
                    <div class="w-10 h-10 rounded-2xl bg-accent-neon/10 flex items-center justify-center text-accent-neon">
                        <span class="material-symbols-outlined">{{ selectedElement.type === 'text' ? 'text_fields' : selectedElement.type === 'image' ? 'image' : 'qr_code' }}</span>
                    </div>
                    <div>
                        <p class="text-[9px] font-black text-accent-neon uppercase tracking-widest">Editando Capa</p>
                        <p class="text-xs font-bold text-on-surface uppercase">{{ selectedElement.type }}</p>
                    </div>
                </div>

                <!-- Text Specific Controls -->
                <template v-if="selectedElement.type === 'text'">
                    <div class="flex-grow min-w-[200px]">
                        <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Contenido (Multilinea)</p>
                        <div class="flex flex-col gap-2">
                            <textarea v-model="selectedElement.content" class="input-cyber !py-2 !px-4 !rounded-xl text-sm min-h-[80px] w-full resize-none" placeholder="Texto..."></textarea>
                            <div class="grid grid-cols-2 gap-2">
                                <div>
                                    <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-1">Ancho (px)</p>
                                    <input type="number" v-model="selectedElement.width" class="input-cyber !py-2 !px-3 !rounded-xl text-xs w-full" />
                                </div>
                                <div>
                                    <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-1">Alto (px)</p>
                                    <input type="number" v-model="selectedElement.height" class="input-cyber !py-2 !px-3 !rounded-xl text-xs w-full" />
                                </div>
                            </div>
                            <div class="flex flex-wrap gap-1">
                                <button v-for="tag in ['{{estudiante}}', '{{curso}}', '{{categoria}}', '{{nivel}}', '{{tipo_curso}}', '{{fecha}}', '{{codigo}}', '{{instructor}}', '{{ci}}', '{{telefono}}']" :key="tag" 
                                        @click="selectedElement.content += tag"
                                        class="px-2 py-1 bg-accent-neon/10 hover:bg-accent-neon/20 rounded-lg text-[11px] font-black text-accent-solar transition-colors ">
                                    {{ tag.slice(2, -2) }}
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="w-48">
                        <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Tipografía Profesional</p>
                        <select v-model="selectedElement.fontFamily"
                                class="input-cyber !py-2 !px-4 !rounded-xl text-xs w-full appearance-none"
                                style="background-color: var(--surface-container); color: var(--on-surface);">
                            <optgroup label="Fuentes comunes">
                                <option v-for="font in standardFonts" :key="font.family" :value="font.family" :style="{ fontFamily: font.family, color: 'var(--on-surface)' }">
                                    {{ font.name }}
                                </option>
                            </optgroup>
                            <optgroup label="Fuentes compatibles PDF">
                                <option value="Helvetica" style="font-family: Helvetica, Arial, sans-serif;">Helvetica</option>
                                <option value="Times-Roman" style="font-family: 'Times New Roman', Times, serif;">Times New Roman</option>
                                <option value="Courier" style="font-family: 'Courier New', Courier, monospace;">Courier</option>
                            </optgroup>
                            <optgroup label="Google Fonts (Elegantes)">
                                <option v-for="font in googleFonts" :key="font.family" :value="font.family" :style="{ fontFamily: font.family, color: 'var(--on-surface)' }">
                                    {{ font.name }}
                                </option>
                            </optgroup>
                        </select>
                    </div>

                    <div class="flex items-center gap-4">
                        <div>
                            <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Talla</p>
                            <input type="number" v-model="selectedElement.size" class="input-cyber !py-2 !w-16 text-center !rounded-xl" />
                        </div>
                        <div>
                            <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Espaciado</p>
                            <input type="number" v-model="selectedElement.letterSpacing" class="input-cyber !py-2 !w-16 text-center !rounded-xl" step="0.5" />
                        </div>
                        <div>
                            <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Color</p>
                            <input type="color" v-model="selectedElement.color" class="w-10 h-10 rounded-xl overflow-hidden cursor-pointer bg-transparent border-0" />
                        </div>
                        <div class="flex gap-1 self-end mb-1">
                            <button @click="selectedElement.textAlign = 'left'" 
                                    :class="selectedElement.textAlign === 'left' || !selectedElement.textAlign ? 'bg-accent-neon text-primary' : 'bg-on-surface/5 text-on-surface/40'"
                                    class="w-10 h-10 rounded-xl flex items-center justify-center transition-all">
                                <span class="material-symbols-outlined">format_align_left</span>
                            </button>
                            <button @click="selectedElement.textAlign = 'center'" 
                                    :class="selectedElement.textAlign === 'center' ? 'bg-accent-neon text-primary' : 'bg-on-surface/5 text-on-surface/40'"
                                    class="w-10 h-10 rounded-xl flex items-center justify-center transition-all">
                                <span class="material-symbols-outlined">format_align_center</span>
                            </button>
                            <button @click="selectedElement.textAlign = 'right'" 
                                    :class="selectedElement.textAlign === 'right' ? 'bg-accent-neon text-primary' : 'bg-on-surface/5 text-on-surface/40'"
                                    class="w-10 h-10 rounded-xl flex items-center justify-center transition-all">
                                <span class="material-symbols-outlined">format_align_right</span>
                            </button>
                        </div>
                        <div class="flex gap-1 self-end mb-1">
                            <button @click="selectedElement.bold = !selectedElement.bold" 
                                    :class="selectedElement.bold ? 'bg-accent-neon text-primary' : 'bg-on-surface/5 text-on-surface/40'"
                                    class="w-10 h-10 rounded-xl flex items-center justify-center transition-all">
                                <span class="material-symbols-outlined">format_bold</span>
                            </button>
                            <button @click="selectedElement.italic = !selectedElement.italic" 
                                    :class="selectedElement.italic ? 'bg-accent-neon text-primary' : 'bg-on-surface/5 text-on-surface/40'"
                                    class="w-10 h-10 rounded-xl flex items-center justify-center transition-all">
                                <span class="material-symbols-outlined">format_italic</span>
                            </button>
                        </div>
                    </div>
                </template>

                <template v-else>
                    <div>
                        <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Ancho (px)</p>
                        <input type="number" v-model="selectedElement.width" class="input-cyber !py-2 !w-24 text-center !rounded-xl" />
                    </div>
                    <div v-if="selectedElement.type !== 'qr'">
                        <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Alto (px)</p>
                        <input type="number" v-model="selectedElement.height" class="input-cyber !py-2 !w-24 text-center !rounded-xl" />
                    </div>
                    <div v-if="selectedElement.type === 'qr'">
                        <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Color QR</p>
                        <input type="color" v-model="selectedElement.color" class="w-10 h-10 rounded-xl overflow-hidden cursor-pointer bg-transparent border-0" />
                    </div>
                </template>

                <!-- Common Controls: Rotate & Opacity -->
                <div class="w-32">
                    <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Rotación ({{ selectedElement.rotate || 0 }}°)</p>
                    <input type="range" v-model="selectedElement.rotate" min="0" max="360" class="w-full h-1.5 bg-on-surface/10 rounded-lg appearance-none cursor-pointer accent-accent-neon" />
                </div>
                <div class="w-32">
                    <p class="text-[10px] font-bold text-on-surface/40 uppercase mb-2">Opacidad ({{ selectedElement.opacity ?? 100 }}%)</p>
                    <input type="range" v-model="selectedElement.opacity" min="0" max="100" class="w-full h-1.5 bg-on-surface/10 rounded-lg appearance-none cursor-pointer accent-accent-neon" />
                </div>

                <!-- Alignment Controls -->
                <div class="flex gap-2 pl-8 ml-auto">
                    <button @click="alignCenter('h')" title="Centrar Horizontal" class="w-10 h-10 rounded-xl bg-on-surface/5 hover:bg-accent-neon/10 text-on-surface/40 hover:text-accent-neon transition-all">
                        <span class="material-symbols-outlined">format_align_center</span>
                    </button>
                    <button @click="alignCenter('v')" title="Centrar Vertical" class="w-10 h-10 rounded-xl bg-on-surface/5 hover:bg-accent-neon/10 text-on-surface/40 hover:text-accent-neon transition-all flex items-center justify-center">
                        <span class="material-symbols-outlined rotate-90">format_align_center</span>
                    </button>
                    <button @click="alignCenter('both')" title="Centrado Total" class="w-10 h-10 rounded-xl bg-accent-neon/10 hover:bg-accent-neon/20 text-accent-neon transition-all flex items-center justify-center">
                        <span class="material-symbols-outlined">filter_center_focus</span>
                    </button>
                    <button @click="selectedId = null" class="w-10 h-10 rounded-xl bg-on-surface/5 hover:bg-red-500/10 text-on-surface/40 hover:text-red-500 transition-all">
                        <span class="material-symbols-outlined">close</span>
                    </button>
                </div>
            </div>
        </transition>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed, onMounted, onUnmounted, watch } from 'vue';
import { useRoute } from 'vue-router';
import api from '@/services/api';
import { useNotificationStore } from '@/stores/notificationStore';

const notificationStore = useNotificationStore();
const generateId = () => Math.random().toString(36).substr(2, 9) + Date.now().toString(36);

const route = useRoute();
const cursoId = route.params.cursoId;
const curso = ref(null);
const backgroundUrl = ref('');

// Page Presets
const pageFormats = {
    A4: { width: 841.89, height: 595.28, name: 'A4' },
    Letter: { width: 792, height: 612, name: 'Carta' },
    Oficio: { width: 936, height: 612, name: 'Oficio' },
    Legal: { width: 1008, height: 612, name: 'Legal' },
    Custom: { width: 1000, height: 707, name: 'Libre' }
};

const selectedFormat = ref('A4');
const orientation = ref('landscape');

// Dimensions (Logical internal size)
const naturalWidth = ref(pageFormats.A4.width);
const naturalHeight = ref(pageFormats.A4.height);

// Professional Fonts
const standardFonts = [
    { name: 'Arial', family: 'Arial, Helvetica, sans-serif' },
    { name: 'Arial Black', family: 'Arial Black, Gadget, sans-serif' },
    { name: 'Helvetica', family: 'Helvetica, Arial, sans-serif' },
    { name: 'Times New Roman', family: 'Times New Roman, Times, serif' },
    { name: 'Georgia', family: 'Georgia, serif' },
    { name: 'Courier New', family: 'Courier New, Courier, monospace' },
    { name: 'Verdana', family: 'Verdana, Geneva, sans-serif' },
    { name: 'Tahoma', family: 'Tahoma, Geneva, sans-serif' },
    { name: 'Trebuchet MS', family: 'Trebuchet MS, Helvetica, sans-serif' },
    { name: 'Palatino', family: 'Palatino Linotype, Book Antiqua, Palatino, serif' }
];

const googleFonts = [
    { name: 'Roboto', family: 'Roboto' },
    { name: 'Montserrat', family: 'Montserrat' },
    { name: 'Playfair Display', family: 'Playfair Display' },
    { name: 'Great Vibes', family: 'Great Vibes' },
    { name: 'Dancing Script', family: 'Dancing Script' },
    { name: 'Cinzel', family: 'Cinzel' },
    { name: 'Inter', family: 'Inter' },
    { name: 'Lora', family: 'Lora' },
    { name: 'Alex Brush', family: 'Alex Brush' },
    { name: 'Pinyon Script', family: 'Pinyon Script' },
    { name: 'Open Sans', family: 'Open Sans' },
    { name: 'Sacramento', family: 'Sacramento' },
    { name: 'Parisienne', family: 'Parisienne' }
];

// Responsive Scaling
const mainCanvasWrapper = ref(null);
const canvasScale = ref(0.8);
const sampleQrUrl = ref('');
const sampleQrLoading = ref(false);

const canvasScaleStyle = computed(() => {
    return {
        width: `${naturalWidth.value}px`,
        height: `${naturalHeight.value}px`,
        transform: `scale(${canvasScale.value})`,
        flexShrink: '0',
        position: 'relative'
    };
});

const updateScale = () => {
    if (!mainCanvasWrapper.value) return;
    const padding = 64; // Horizontal padding
    const availableWidth = mainCanvasWrapper.value.clientWidth - padding;
    const availableHeight = mainCanvasWrapper.value.clientHeight - padding;
    
    const scaleX = availableWidth / naturalWidth.value;
    const scaleY = availableHeight / naturalHeight.value;
    
    canvasScale.value = Math.min(scaleX, scaleY, 1.2); // Limit max zoom
};

const handleResize = () => {
    updateScale();
};

const saving = ref(false);
const uploadingBg = ref(false);
const uploadProgress = ref(0);
const selectedId = ref(null);
const plantillaId = ref(null);
const elements = ref([]);

const selectedElement = computed(() => elements.value.find(el => el.id === selectedId.value));

const applyFormat = (key) => {
    selectedFormat.value = key;
    const fmt = pageFormats[key];

    if (orientation.value === 'landscape') {
        naturalWidth.value = fmt.width;
        naturalHeight.value = fmt.height;
    } else {
        naturalWidth.value = fmt.height;
        naturalHeight.value = fmt.width;
    }
    
    setTimeout(updateScale, 50);
};

const toggleOrientation = () => {
    orientation.value = orientation.value === 'landscape' ? 'portrait' : 'landscape';
    const currentHeight = naturalHeight.value;
    const currentWidth = naturalWidth.value;
    
    naturalWidth.value = currentHeight;
    naturalHeight.value = currentWidth;
    
    setTimeout(updateScale, 50);
};

const loadGoogleFonts = () => {
    if (document.getElementById('google-fonts-certificate')) return;
    const link = document.createElement('link');
    link.id = 'google-fonts-certificate';
    link.rel = 'stylesheet';
    const fontFamilies = googleFonts.map(f => f.family.replace(/ /g, '+')).join('|');
    link.href = `https://fonts.googleapis.com/css?family=${fontFamilies}:400,700,400italic,700italic&display=swap`;
    document.head.appendChild(link);
};

const fetchData = async () => {
  try {
    const res = await api.get(`/cursos/${cursoId}`);
    curso.value = res.data;
    
    const plantilla = curso.value.plantilla_certificado;
    
    if (plantilla) {
      plantillaId.value = plantilla.id;
      backgroundUrl.value = plantilla.background_url;
      if (plantilla.config) {
          if (plantilla.config.elements) elements.value = plantilla.config.elements;
          if (plantilla.config.logicalWidth) naturalWidth.value = plantilla.config.logicalWidth;
          if (plantilla.config.logicalHeight) naturalHeight.value = plantilla.config.logicalHeight;
          if (plantilla.config.selectedFormat) selectedFormat.value = plantilla.config.selectedFormat;
          if (plantilla.config.orientation) orientation.value = plantilla.config.orientation;
      }
    }
    // Initial scale calculation
    setTimeout(updateScale, 100);
  } catch (error) {
    console.error('Error fetching data:', error);
  }
};

const onImageLoad = (event) => {
  // Ya no redimensionamos el canvas basado en la imagen. 
  // La imagen se ajusta al tamaño de papel seleccionado (A4, Carta, etc.)
  updateScale();
};

const loadSampleQr = async () => {
    sampleQrLoading.value = true;
    try {
        const response = await api.get('/certificados/sample-qr', { responseType: 'blob' });
        const blob = new Blob([response.data], { type: response.data.type || 'image/svg+xml' });

        if (sampleQrUrl.value) {
            URL.revokeObjectURL(sampleQrUrl.value);
        }
        sampleQrUrl.value = URL.createObjectURL(blob);
    } catch (error) {
        console.warn('No se pudo cargar el QR de ejemplo', error);
        sampleQrUrl.value = '';
    } finally {
        sampleQrLoading.value = false;
    }
};

const getDemoQrPlaceholder = () => {
    if (sampleQrUrl.value) return sampleQrUrl.value;
    return `data:image/svg+xml;charset=UTF-8,${encodeURIComponent(`
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 200">
        <rect width="200" height="200" fill="#ffffff"/>
        <rect x="10" y="10" width="40" height="40" fill="#111111"/>
        <rect x="30" y="30" width="20" height="20" fill="#ffffff"/>
        <rect x="10" y="70" width="20" height="20" fill="#111111"/>
        <rect x="50" y="70" width="20" height="20" fill="#111111"/>
        <rect x="90" y="70" width="20" height="20" fill="#111111"/>
        <rect x="130" y="70" width="20" height="20" fill="#111111"/>
        <rect x="150" y="70" width="20" height="20" fill="#111111"/>
        <rect x="10" y="110" width="20" height="20" fill="#111111"/>
        <rect x="50" y="110" width="60" height="20" fill="#111111"/>
        <rect x="130" y="110" width="20" height="20" fill="#111111"/>
        <rect x="170" y="110" width="20" height="20" fill="#111111"/>
        <rect x="70" y="150" width="20" height="20" fill="#111111"/>
        <rect x="110" y="150" width="20" height="20" fill="#111111"/>
        <rect x="150" y="150" width="20" height="20" fill="#111111"/>
      </svg>` )}`;
};

const addElement = (type) => {
    const id = generateId();
    const base = {
        id,
        type,
        x: 100,
        y: 100,
    };

    if (type === 'text') {
        Object.assign(base, {
            content: 'Nuevo Texto',
            size: 32,
            width: 400,
            height: 50,
            color: '#1a1a1a',
            fontFamily: 'Helvetica',
            bold: false,
            italic: false,
            textAlign: 'left',
            letterSpacing: 0,
            rotate: 0,
            opacity: 100,
            locked: false,
            hidden: false
        });
    } else if (type === 'qr') {
        Object.assign(base, {
            size: 120,
            width: 120,
            height: 120,
            rotate: 0,
            opacity: 100
        });
    }

    elements.value.push(base);
    selectedId.value = id;
};

const imageElementInput = ref(null);
const triggerImageUpload = () => imageElementInput.value.click();

const handleAddImageElement = async (event) => {
    const file = event.target.files[0];
    if (!file) return;
    
    const formData = new FormData();
    formData.append('file', file);
    
    try {
        const res = await api.post('/uploads', formData, {
            headers: { 'Content-Type': 'multipart/form-data' }
        });
        
        const id = generateId();
        elements.value.push({
            id,
            type: 'image',
            url: res.data.url,
            x: 100,
            y: 100,
            width: 200,
            height: 120,
            rotate: 0,
            opacity: 100
        });
        selectedId.value = id;
    } catch (e) {
        notificationStore.addNotification({
            title: 'Error',
            message: 'Error al subir imagen de elemento',
            type: 'error'
        });
    }
};

const duplicateElement = (index) => {
    const original = elements.value[index];
    const copy = JSON.parse(JSON.stringify(original));
    copy.id = generateId();
    copy.x += 30;
    copy.y += 30;
    elements.value.push(copy);
    selectedId.value = copy.id;
};

const removeElement = (index) => {
    if (selectedId.value === elements.value[index].id) selectedId.value = null;
    elements.value.splice(index, 1);
};

const moveLayer = (index, direction) => {
    const newIndex = index + direction;
    if (newIndex < 0 || newIndex >= elements.value.length) return;
    const item = elements.value.splice(index, 1)[0];
    elements.value.splice(newIndex, 0, item);
};

const alignCenter = (axis) => {
    if (!selectedElement.value) return;
    const elWidth = selectedElement.value.type === 'text' ? 200 : selectedElement.value.width; 
    const elHeight = selectedElement.value.type === 'text' ? selectedElement.value.size : selectedElement.value.height;

    if (axis === 'h' || axis === 'both') {
        selectedElement.value.x = (naturalWidth.value / 2) - (elWidth / 2);
    }
    if (axis === 'v' || axis === 'both') {
        selectedElement.value.y = (naturalHeight.value / 2) - (elHeight / 2);
    }
};

const renderText = (content) => {
    if (!content) return '';
    return content
        .replace('{{estudiante}}', 'JUAN PÉREZ GARCÍA')
        .replace('{{curso}}', 'ENERGIAS RENOVABLES')
        .replace('{{categoria}}', 'TECNOLOGÍA')
        .replace('{{nivel}}', 'AVANZADO')
        .replace('{{tipo_curso}}', 'VIRTUAL')
        .replace('{{fecha}}', '04 de Mayo, 2026')
        .replace('{{codigo}}', 'EV01260004')
        .replace('{{instructor}}', 'LIC. ROBERTO CARLOS')
        .replace('{{ci}}', '12345678')
        .replace('{{telefono}}', '+591 77712345');
};

const previewPdf = () => {
    if (!plantillaId.value) return;
    const baseUrl = (import.meta.env.VITE_API_URL || 'http://localhost:3000').replace(/\/$/, '');
    const token = localStorage.getItem('access_token') || '';
    const timestamp = new Date().getTime();
    window.open(`${baseUrl}/certificados/preview/${plantillaId.value}?t=${timestamp}&token=${token}`, '_blank');
};

const startResize = (event, el, mode = 'corner') => {
    const startX = event.clientX;
    const startY = event.clientY;
    const initialWidth = el.width || 100;
    const initialHeight = el.height || 100;

    const onMouseMove = (e) => {
        const dx = (e.clientX - startX) / canvasScale.value;
        const dy = (e.clientY - startY) / canvasScale.value;

        if (mode === 'width' || mode === 'corner') {
            el.width = Math.max(20, initialWidth + dx);
            if (el.type === 'qr') {
                el.height = el.width;
                el.size = el.width;
            }
        }
        
        if (mode === 'height' || mode === 'corner') {
            if (el.type === 'image') {
                if (mode === 'corner') {
                    const ratio = initialHeight / initialWidth;
                    el.height = el.width * ratio;
                } else {
                    el.height = Math.max(20, initialHeight + dy);
                }
            } else if (el.type === 'qr') {
                const nextHeight = Math.max(20, initialHeight + dy);
                el.height = nextHeight;
                el.width = nextHeight;
                el.size = nextHeight;
            } else {
                el.height = Math.max(20, initialHeight + dy);
            }
        }
    };

    const onMouseUp = () => {
        window.removeEventListener('mousemove', onMouseMove);
        window.removeEventListener('mouseup', onMouseUp);
    };

    window.addEventListener('mousemove', onMouseMove);
    window.addEventListener('mouseup', onMouseUp);
};

const startDrag = (event, el) => {
    selectedId.value = el.id;
    
    const startX = event.clientX;
    const startY = event.clientY;
    const initialX = el.x;
    const initialY = el.y;
    
    const onMouseMove = (e) => {
        let dx = (e.clientX - startX) / canvasScale.value;
        let dy = (e.clientY - startY) / canvasScale.value;
        
        el.x = initialX + dx;
        el.y = initialY + dy;
    };
    
    const onMouseUp = () => {
        window.removeEventListener('mousemove', onMouseMove);
        window.removeEventListener('mouseup', onMouseUp);
    };
    
    window.addEventListener('mousemove', onMouseMove);
    window.addEventListener('mouseup', onMouseUp);
};

const saveTemplate = async () => {
    saving.value = true;
    try {
        const payload = {
            curso_id: Number(cursoId),
            nombre: `Plantilla - ${curso.value.titulo}`,
            background_url: backgroundUrl.value,
            config: { 
                elements: elements.value,
                logicalWidth: naturalWidth.value,
                logicalHeight: naturalHeight.value,
                selectedFormat: selectedFormat.value,
                orientation: orientation.value
            }
        };

        let response;
        if (plantillaId.value) {
            response = await api.patch(`/certificado-plantillas/${plantillaId.value}`, payload);
        } else {
            const checkRes = await api.get(`/certificado-plantillas/curso/${cursoId}`);
            if (checkRes.data && checkRes.data.id) {
                plantillaId.value = checkRes.data.id;
                response = await api.patch(`/certificado-plantillas/${plantillaId.value}`, payload);
            } else {
                response = await api.post('/certificado-plantillas', payload);
            }
        }

        if (response.data && response.data.id) {
            plantillaId.value = response.data.id;
        }

        notificationStore.addNotification({
            title: 'Éxito',
            message: 'Plantilla guardada y publicada correctamente',
            type: 'success'
        });
    } catch (e) {
        notificationStore.addNotification({
            title: 'Error',
            message: 'Error al guardar la plantilla',
            type: 'error'
        });
    } finally {
        saving.value = false;
    }
};

const handleFileUpload = async (event) => {
  const file = event.target.files[0];
  if (!file) return;
  const formData = new FormData();
  formData.append('file', file);
  
  uploadingBg.value = true;
  uploadProgress.value = 0;
  try {
    const res = await api.post('/uploads', formData, { 
      headers: { 'Content-Type': 'multipart/form-data' },
      onUploadProgress: (progressEvent) => {
        const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
        uploadProgress.value = percentCompleted;
      }
    });
    backgroundUrl.value = res.data.url;
  } catch (e) { 
    notificationStore.addNotification({
      title: 'Error',
      message: 'Error al subir fondo',
      type: 'error'
    });
  } finally {
    uploadingBg.value = false;
  }
};

const getFullUrl = (url) => {
  if (!url) return '';
  if (url.startsWith('http')) return url;
  const baseUrl = (import.meta.env.VITE_API_URL || 'http://localhost:3000').replace(/\/$/, '');
  return `${baseUrl}${url.startsWith('/') ? url : '/' + url}`;
};

const handleKeyDown = (e) => {
    if (selectedId.value) {
        if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;

        const el = selectedElement.value;
        if (!el) return;

        const step = e.shiftKey ? 10 : 1;

        if (e.key === 'Delete' || e.key === 'Backspace') {
            const index = elements.value.findIndex(el => el.id === selectedId.value);
            if (index !== -1) removeElement(index);
        } else if (e.key === 'ArrowLeft') {
            el.x -= step;
        } else if (e.key === 'ArrowRight') {
            el.x += step;
        } else if (e.key === 'ArrowUp') {
            el.y -= step;
        } else if (e.key === 'ArrowDown') {
            el.y += step;
        } else if (e.ctrlKey && e.key === 'd') {
            e.preventDefault();
            const index = elements.value.findIndex(el => el.id === selectedId.value);
            duplicateElement(index);
        }
    }
};

onMounted(() => {
    fetchData();
    loadGoogleFonts();
    fetchData();
    loadGoogleFonts();
    loadSampleQr();
    window.addEventListener('keydown', handleKeyDown);
    window.addEventListener('resize', handleResize);
});

onUnmounted(() => {
    if (sampleQrUrl.value) {
        URL.revokeObjectURL(sampleQrUrl.value);
    }
    window.removeEventListener('keydown', handleKeyDown);
    window.removeEventListener('resize', handleResize);
});
</script>

<style scoped>
.input-cyber {
    background-color: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 1rem;
    padding: 0.5rem 1rem;
    color: inherit;
    transition: all 0.3s ease;
}
.input-cyber:focus {
    outline: none;
    border-color: #00ffcc;
}

.slide-up-enter-active, .slide-up-leave-active {
    transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
}
.slide-up-enter-from, .slide-up-leave-to {
    transform: translateY(100px);
    opacity: 0;
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

input[type=number] {
  -moz-appearance: textfield;
}

.custom-scrollbar::-webkit-scrollbar {
  width: 5px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background: rgba(0, 255, 204, 0.1);
  border-radius: 10px;
}
</style>