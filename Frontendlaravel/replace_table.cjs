const fs = require('fs');
const path = require('path');
const filePath = path.join(__dirname, 'src', 'views', 'admin', 'AdminEstudianteDetalle.vue');
let c = fs.readFileSync(filePath, 'utf8');

// --- 1. Replace the full evaluation table section ---
const oldTable = `        <!-- Evaluation Attempts -->
        <div class="glass-card p-10 rounded-[40px]">
          <h4 class="text-xl font-black font-lexend tracking-tighter italic mb-10">Historial de <span class="text-accent-neon">Evaluaciones</span></h4>
           

          <div class="glass-card-premium ">
            <table class="w-full text-left rounded-[10px] overflow-hidden">
              <thead>
                <tr class="bg-on-surface/[0.03]">
                  <th class="pb-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Evaluación</th>
                  <th class="pb-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Nota</th>
                  <th class="pb-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Estado</th>
                  <th class="pb-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Fecha</th>
                  <th class="pb-6 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-right">Detalle</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="intento in estudiante.intentos_evaluacion" :key="intento.id" class="group hover:bg-on-surface/5 transition-colors">
                  <td class="py-6">
                    <p class="text-xs font-black text-on-surface group-hover:text-accent-neon transition-colors">{{ intento.evaluacion.titulo }}</p>
                  </td>
                  <td class="py-6">
                    <span :class="['text-sm font-black', intento.aprobado ? 'text-green-500' : 'text-red-500']">{{ intento.nota || '0.00' }}</span>
                  </td>
                  <td class="py-6">
                    <span :class="['px-3 py-1 text-[9px] font-black rounded-full uppercase tracking-widest', intento.aprobado ? 'bg-green-500/10 text-green-500' : 'bg-red-500/10 text-red-500']">
                      {{ intento.aprobado ? 'Aprobado' : 'Reprobado' }}
                    </span>
                  </td>
                  <td class="py-6 text-[10px] text-on-surface/40 font-bold uppercase">{{ new Date(intento.fecha_fin || intento.fecha_inicio).toLocaleDateString() }}</td>
                  <td class="py-6 text-right">
                    <button @click="showAttemptDetail(intento)" class="px-3 py-1.5 bg-accent-neon/10 text-accent-neon text-[9px] font-black rounded-lg hover:bg-accent-neon hover:text-primary transition-all uppercase tracking-wider">
                      Ver Respuestas
                    </button>
                  </td>
                </tr>
                <tr v-if="!estudiante.intentos_evaluacion?.length">
                  <td colspan="5" class="py-20 text-center text-on-surface/20">
                    <p class="text-[10px] font-black uppercase tracking-widest">No ha realizado evaluaciones aún</p>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>`;

const newTable = `        <!-- Evaluation Attempts -->
        <div class="glass-card-premium rounded-[20px] overflow-hidden shadow-2xl !border-none">
          <div class="px-8 pt-8 pb-4 flex items-center justify-between">
            <h4 class="text-xl font-black font-lexend tracking-tighter italic">Historial de <span class="text-accent-neon">Evaluaciones</span></h4>
            <span class="px-3 py-1 bg-accent-neon/10 text-accent-neon text-[10px] font-black rounded-full">{{ estudiante.intentos_evaluacion?.length || 0 }} intentos</span>
          </div>
          <div class="overflow-x-auto">
            <table class="w-full min-w-[700px] text-left border-separate border-spacing-0">
              <thead>
                <tr class="border-b border-on-surface/5">
                  <th class="px-8 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Evaluación / Curso</th>
                  <th class="px-6 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Nota</th>
                  <th class="px-6 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Estado</th>
                  <th class="px-6 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest">Fecha</th>
                  <th class="px-6 pb-5 pt-2 text-[10px] font-black text-on-surface/40 uppercase tracking-widest text-right">Acciones</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="intento in estudiante.intentos_evaluacion" :key="intento.id" class="group border-b border-on-surface/5 hover:bg-on-surface/[0.03] transition-colors">
                  <td class="px-8 py-5">
                    <p class="text-xs font-black text-on-surface group-hover:text-accent-neon transition-colors">{{ intento.evaluacion.titulo }}</p>
                    <p class="text-[10px] text-on-surface/40 font-bold mt-0.5">{{ intento.evaluacion?.curso?.titulo || '—' }}</p>
                  </td>
                  <td class="px-6 py-5">
                    <span :class="['text-sm font-black', intento.aprobado ? 'text-green-500' : 'text-red-500']">{{ Math.round(intento.nota || 0) }}%</span>
                  </td>
                  <td class="px-6 py-5">
                    <span :class="['px-3 py-1 text-[9px] font-black rounded-full uppercase tracking-widest', intento.aprobado ? 'bg-green-500/10 text-green-500' : 'bg-red-500/10 text-red-500']">
                      {{ intento.aprobado ? 'Aprobado' : 'Reprobado' }}
                    </span>
                  </td>
                  <td class="px-6 py-5 text-[10px] text-on-surface/40 font-bold uppercase">{{ new Date(intento.fecha_fin || intento.fecha_inicio).toLocaleDateString() }}</td>
                  <td class="px-6 py-5 text-right">
                    <div class="flex items-center justify-end gap-2">
                      <button @click="showAttemptDetail(intento)" class="px-3 py-1.5 bg-accent-neon/10 text-accent-neon text-[9px] font-black rounded-lg hover:bg-accent-neon hover:text-primary transition-all uppercase tracking-wider">Ver</button>
                      <button @click="exportRowPDF(intento)" :disabled="pdfLoadingId === intento.id" class="px-3 py-1.5 bg-rose-500/10 text-rose-400 text-[9px] font-black rounded-lg hover:bg-rose-500 hover:text-white transition-all uppercase tracking-wider flex items-center gap-1 disabled:opacity-40" title="Exportar PDF">
                        <span v-if="pdfLoadingId === intento.id" class="material-symbols-outlined text-[12px] animate-spin">sync</span>
                        <span v-else class="material-symbols-outlined text-[12px]">picture_as_pdf</span>
                        PDF
                      </button>
                    </div>
                  </td>
                </tr>
                <tr v-if="!estudiante.intentos_evaluacion?.length">
                  <td colspan="5" class="px-8 py-20 text-center text-on-surface/20">
                    <span class="material-symbols-outlined text-4xl mb-3 block">quiz</span>
                    <p class="text-[10px] font-black uppercase tracking-widest">No ha realizado evaluaciones aún</p>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>`;

// Normalize line endings for matching
const oldNorm = oldTable.replace(/\r\n/g, '\n');
c = c.replace(/\r\n/g, '\n'); // normalize entire file
if (c.includes(oldNorm)) {
  c = c.replace(oldNorm, newTable);
  console.log('Table replaced!');
} else {
  // try partial match
  const marker = '<!-- Evaluation Attempts -->';
  const endMarker = '</div>\n      </div>\n    </div>';
  const start = c.indexOf(marker);
  const end = c.indexOf(endMarker, start) + endMarker.length;
  if (start !== -1) {
    c = c.slice(0, start) + newTable + '\n    </div>\n  </div>\n' + c.slice(end);
    console.log('Table replaced via marker!');
  } else {
    console.error('Could not find table!');
    process.exit(1);
  }
}

// --- 2. Add pdfLoadingId ref ---
c = c.replace(
  'const exportStatus = ref({\n  individualPdf: \'idle\'\n})',
  'const exportStatus = ref({\n  individualPdf: \'idle\'\n})\nconst pdfLoadingId = ref(null)'
);

// --- 3. Add exportRowPDF function after exportIndividualPDF ---
const exportRowPDFFn = `
const exportRowPDF = async (intento) => {
  if (pdfLoadingId.value) return;
  pdfLoadingId.value = intento.id;
  try {
    let logoDataUrl = null;
    try { logoDataUrl = await loadLogoToPngBase64('/logo-dark.webp'); } catch(e) {}
    const headerColumns = [];
    if (logoDataUrl) {
      headerColumns.push({ image: logoDataUrl, width: 130, alignment: 'left' });
    } else {
      headerColumns.push({ text: 'ENERVIDA', fontSize: 16, bold: true, color: '#2C3E50' });
    }
    headerColumns.push({
      width: '*',
      stack: [
        { text: 'REPORTE DE CALIFICACIÓN', style: 'pdfTitle' },
        { text: 'DOCUMENTO ACADÉMICO OFICIAL', style: 'pdfSubtitle' },
        { text: \`Fecha de emisión: \${new Date().toLocaleDateString('es-BO')}\`, style: 'pdfDate' }
      ],
      alignment: 'right', margin: [0, logoDataUrl ? 10 : 0, 0, 0]
    });
    const nota = Math.round(intento.nota || 0) + '%';
    const notaMin = Math.round(intento.evaluacion?.nota_aprobacion || 0) + '%';
    const estado = intento.aprobado ? 'APROBADO' : 'REPROBADO';
    const colorEstado = intento.aprobado ? '#27AE60' : '#E74C3C';
    const docDefinition = {
      pageSize: 'A4', pageOrientation: 'portrait', pageMargins: [40, 45, 40, 45],
      content: [
        { columns: headerColumns },
        { canvas: [{ type: 'line', x1: 0, y1: 12, x2: 515, y2: 12, lineWidth: 1.5, lineColor: '#2C3E50' }] },
        { text: '', margin: [0, 0, 0, 25] },
        {
          table: {
            widths: ['50%', '50%'],
            body: [
              [{ text: 'Estudiante', style: 'tableHeader' }, { text: 'Curso / Evaluación', style: 'tableHeader' }],
              [
                { stack: [{ text: \`\${estudiante.value?.nombres || ''} \${estudiante.value?.apellidos || ''}\`, bold: true }, { text: estudiante.value?.correo || '', color: '#7F8C8D', fontSize: 10 }] },
                { stack: [{ text: intento.evaluacion?.curso?.titulo || '—', bold: true }, { text: intento.evaluacion?.titulo || '', color: '#7F8C8D', fontSize: 10 }] }
              ],
              [{ text: 'Fecha del Intento', style: 'tableHeader' }, { text: 'Duración', style: 'tableHeader' }],
              [
                { text: new Date(intento.fecha_fin || intento.fecha_inicio).toLocaleDateString('es-BO', { day: '2-digit', month: 'short', year: 'numeric' }), bold: true },
                { text: calculateDuration(intento.fecha_inicio, intento.fecha_fin), bold: true }
              ]
            ]
          }, layout: 'lightHorizontalLines'
        },
        { text: '', margin: [0, 0, 0, 20] },
        {
          table: {
            widths: ['*', '*', '*'],
            body: [
              [{ text: 'Nota Final', style: 'metricLabel' }, { text: 'Nota Mínima', style: 'metricLabel' }, { text: 'Estado', style: 'metricLabel' }],
              [{ text: nota, style: 'metricValue', color: colorEstado }, { text: notaMin, style: 'metricValue' }, { text: estado, style: 'metricValue', color: colorEstado }]
            ]
          },
          layout: { defaultBorder: false, fillColor: (r) => r === 0 ? '#F8F9FA' : null },
          margin: [0, 0, 0, 60]
        },
        {
          columns: [
            { stack: [{ canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] }, { text: 'Firma del Estudiante', bold: true, margin: [0, 5, 0, 0] }, { text: 'CI / Identificación', fontSize: 9, color: '#7F8C8D' }], alignment: 'center' },
            { stack: [{ canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] }, { text: 'Firma Autorizada', bold: true, margin: [0, 5, 0, 0] }, { text: 'Director Académico', fontSize: 9, color: '#7F8C8D' }], alignment: 'center' }
          ]
        }
      ],
      styles: {
        pdfTitle: { fontSize: 16, bold: true, color: '#2C3E50' },
        pdfSubtitle: { fontSize: 11, bold: true, color: '#2980B9', margin: [0, 2, 0, 2] },
        pdfDate: { fontSize: 8.5, italics: true, color: '#7F8C8D' },
        tableHeader: { fontSize: 9, bold: true, color: '#7F8C8D', margin: [0, 5, 0, 5] },
        metricLabel: { fontSize: 9, bold: true, color: '#7F8C8D', alignment: 'center', margin: [0, 10, 0, 5] },
        metricValue: { fontSize: 24, bold: true, color: '#2C3E50', alignment: 'center', margin: [0, 5, 0, 15] }
      },
      footer: (currentPage, pageCount) => ({ columns: [{ text: 'Reporte de control académico interno.', alignment: 'left', fontSize: 8, color: '#95A5A6' }, { text: \`Página \${currentPage} de \${pageCount}\`, alignment: 'right', fontSize: 8, color: '#95A5A6' }], margin: [40, 0, 40, 0] })
    };
    pdfMake.createPdf(docDefinition).download(\`Boleta_\${estudiante.value?.nombres || 'Estudiante'}_\${intento.evaluacion?.titulo || ''}.pdf\`);
  } catch(e) {
    console.error('Error PDF:', e);
  } finally {
    pdfLoadingId.value = null;
  }
};
`;

c = c.replace(
  '\n\n\nconst fetchEstudiante = async () => {',
  exportRowPDFFn + '\n\nconst fetchEstudiante = async () => {'
);

fs.writeFileSync(filePath, c, 'utf8');
console.log('Done!');
