const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, 'src', 'views', 'admin', 'AdminEstudianteDetalle.vue');
let content = fs.readFileSync(filePath, 'utf8');

// 1. Add the Export button to the Modal Footer
content = content.replace(
  /<div class="p-6 border-t border-on-surface\/5 flex justify-end">/,
  `<div class="p-6 border-t border-slate-200/60 dark:border-white/5 flex justify-between items-center">
          <div class="flex items-center gap-2 bg-slate-200/50 dark:bg-white/5 p-1 rounded-2xl border border-slate-300/60 dark:border-white/10 shadow-sm dark:shadow-inner transition-colors duration-300">
            <button @click="exportIndividualPDF" :disabled="exportStatus.individualPdf !== 'idle'" class="relative h-10 px-3 sm:px-4 rounded-xl hover:bg-rose-500/15 dark:hover:bg-rose-500/20 text-slate-700 dark:text-white/80 hover:text-rose-600 dark:hover:text-rose-400 disabled:opacity-50 disabled:cursor-not-allowed font-bold text-[10px] sm:text-xs tracking-wider transition-all flex items-center justify-center min-w-[70px] sm:min-w-[85px] overflow-hidden" title="Exportar PDF Individual">
              <div v-if="exportStatus.individualPdf === 'idle'" class="flex items-center gap-1.5 transition-all">
                <span class="material-symbols-outlined text-[18px]">picture_as_pdf</span>
                <span class="hidden sm:inline">PDF</span>
              </div>
              <span v-else-if="exportStatus.individualPdf === 'loading'" class="material-symbols-outlined text-[18px] animate-spin text-rose-600 dark:text-rose-400">sync</span>
              <span v-else-if="exportStatus.individualPdf === 'success'" class="material-symbols-outlined text-[22px] text-emerald-500 animate-bounce">check_circle</span>
            </button>
          </div>`
);

// 2. Add imports
content = content.replace(
  /import api from '@\/services\/api'/,
  `import api from '@/services/api'
import pdfMake from 'pdfmake/build/pdfmake'
import * as pdfFonts from 'pdfmake/build/vfs_fonts'

pdfMake.vfs = pdfFonts.pdfMake ? pdfFonts.pdfMake.vfs : pdfMake.vfs`
);

// 3. Add exportStatus state and correctCount logic
content = content.replace(
  /const showModalDetail = ref\(false\)/,
  `const showModalDetail = ref(false)
const exportStatus = ref({
  individualPdf: 'idle'
})`
);

// 4. Inject pdf generation functions
const newFunctions = `
const correctCount = computed(() => {
  if (!selectedAttempt.value?.respuestas_seleccionadas || !selectedAttempt.value?.evaluacion?.preguntas) return 0
  return selectedAttempt.value.evaluacion.preguntas.filter(p =>
    isQuestionCorrect(p, selectedAttempt.value.respuestas_seleccionadas)
  ).length
})

const loadLogoToPngBase64 = (url) => {
  return new Promise((resolve, reject) => {
    const img = new Image();
    img.crossOrigin = 'Anonymous';
    img.onload = () => {
      const canvas = document.createElement('canvas');
      canvas.width = img.width;
      canvas.height = img.height;
      const ctx = canvas.getContext('2d');
      ctx.drawImage(img, 0, 0);
      resolve(canvas.toDataURL('image/png'));
    };
    img.onerror = (e) => reject(e);
    img.src = url;
  });
};

const exportIndividualPDF = async () => {
  if (!selectedAttempt.value || exportStatus.value.individualPdf !== 'idle') return;
  
  exportStatus.value.individualPdf = 'loading';

  try {
    let logoDataUrl = null;
    try {
      logoDataUrl = await loadLogoToPngBase64('/logo-dark.webp');
    } catch (e) {
      console.warn("No se pudo cargar logo", e);
    }

    const headerColumns = [];
    if (logoDataUrl) {
      headerColumns.push({ image: logoDataUrl, width: 130, alignment: 'left' });
    } else {
      headerColumns.push({ text: 'ENERVIDA', fontSize: 16, bold: true, color: '#2C3E50', alignment: 'left' });
    }

    headerColumns.push({
      width: '*',
      stack: [
        { text: 'REPORTE DE CALIFICACIÓN', style: 'pdfTitle' },
        { text: 'DOCUMENTO ACADÉMICO OFICIAL', style: 'pdfSubtitle' },
        { text: \`Fecha de emisión: \${new Date().toLocaleDateString('es-BO')}\`, style: 'pdfDate' }
      ],
      alignment: 'right',
      margin: [0, logoDataUrl ? 10 : 0, 0, 0]
    });

    const intento = selectedAttempt.value;
    const notaFinal = Math.round(intento.nota || 0) + '%';
    const notaMinima = Math.round(intento.evaluacion?.nota_aprobacion || 0) + '%';
    const estado = intento.aprobado ? 'APROBADO' : 'REPROBADO';
    const colorEstado = intento.aprobado ? '#27AE60' : '#E74C3C';
    
    const correctas = correctCount.value;
    const totalPreguntas = intento.evaluacion?.preguntas?.length || 0;

    const docDefinition = {
      pageSize: 'A4',
      pageOrientation: 'portrait',
      pageMargins: [40, 45, 40, 45],
      content: [
        { columns: headerColumns },
        { canvas: [{ type: 'line', x1: 0, y1: 12, x2: 515, y2: 12, lineWidth: 1.5, lineColor: '#2C3E50' }] },
        { text: '', margin: [0, 0, 0, 25] },
        
        // Datos del Estudiante y Curso
        {
          style: 'tableExample',
          table: {
            widths: ['50%', '50%'],
            body: [
              [
                { text: 'Estudiante', style: 'tableHeader' },
                { text: 'Curso / Evaluación', style: 'tableHeader' }
              ],
              [
                { stack: [
                  { text: \`\${estudiante.value?.nombres || ''} \${estudiante.value?.apellidos || ''}\`, bold: true },
                  { text: estudiante.value?.correo || '', color: '#7F8C8D', fontSize: 10 }
                ]},
                { stack: [
                  { text: intento.evaluacion?.curso?.titulo || '—', bold: true },
                  { text: intento.evaluacion?.titulo || '', color: '#7F8C8D', fontSize: 10 }
                ]}
              ],
              [
                { text: 'Fecha del Intento', style: 'tableHeader' },
                { text: 'Duración', style: 'tableHeader' }
              ],
              [
                { text: new Date(intento.fecha_fin || intento.fecha_inicio).toLocaleDateString('es-BO', { day: '2-digit', month: 'short', year: 'numeric' }), bold: true },
                { text: calculateDuration(intento.fecha_inicio, intento.fecha_fin), bold: true }
              ]
            ]
          },
          layout: 'lightHorizontalLines'
        },
        { text: '', margin: [0, 0, 0, 20] },
        
        // Resumen de Calificación
        {
          table: {
            widths: ['*', '*', '*'],
            body: [
              [
                { text: 'Nota Final', style: 'metricLabel' },
                { text: 'Nota Mínima', style: 'metricLabel' },
                { text: 'Estado', style: 'metricLabel' }
              ],
              [
                { text: notaFinal, style: 'metricValue', color: colorEstado },
                { text: notaMinima, style: 'metricValue' },
                { text: estado, style: 'metricValue', color: colorEstado }
              ]
            ]
          },
          layout: {
            defaultBorder: false,
            fillColor: function (rowIndex) {
              return rowIndex === 0 ? '#F8F9FA' : null;
            }
          },
          margin: [0, 0, 0, 30]
        },
        
        // Detalles de la evaluación
        { text: 'Detalles Estadísticos', style: 'sectionTitle' },
        {
          table: {
            widths: ['*', '*'],
            body: [
              [
                { text: 'Métrica', style: 'tableHeader' },
                { text: 'Resultado', style: 'tableHeader', alignment: 'right' }
              ],
              [ 'Preguntas Correctas', { text: \`\${correctas} / \${totalPreguntas}\`, alignment: 'right', bold: true } ],
              [ 'Porcentaje Obtenido', { text: notaFinal, alignment: 'right', bold: true } ],
              [ 'Resultado Académico', { text: estado, alignment: 'right', bold: true, color: colorEstado } ]
            ]
          },
          layout: 'lightHorizontalLines',
          margin: [0, 0, 0, 60]
        },
        
        // Firmas
        {
          columns: [
            {
              stack: [
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] },
                { text: 'Firma del Estudiante', bold: true, margin: [0, 5, 0, 0] },
                { text: 'CI / Identificación', fontSize: 9, color: '#7F8C8D' }
              ],
              alignment: 'center'
            },
            {
              stack: [
                { canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, lineColor: '#95A5A6' }] },
                { text: 'Firma Autorizada', bold: true, margin: [0, 5, 0, 0] },
                { text: 'Director Académico', fontSize: 9, color: '#7F8C8D' }
              ],
              alignment: 'center'
            }
          ]
        }
      ],
      styles: {
        pdfTitle: { fontSize: 16, bold: true, color: '#2C3E50' },
        pdfSubtitle: { fontSize: 11, bold: true, color: '#2980B9', margin: [0, 2, 0, 2] },
        pdfDate: { fontSize: 8.5, italics: true, color: '#7F8C8D' },
        tableHeader: { fontSize: 9, bold: true, color: '#7F8C8D', margin: [0, 5, 0, 5] },
        metricLabel: { fontSize: 9, bold: true, color: '#7F8C8D', alignment: 'center', margin: [0, 10, 0, 5] },
        metricValue: { fontSize: 24, bold: true, color: '#2C3E50', alignment: 'center', margin: [0, 5, 0, 15] },
        sectionTitle: { fontSize: 12, bold: true, color: '#2C3E50', margin: [0, 0, 0, 10] }
      },
      footer: (currentPage, pageCount) => {
        return {
          columns: [
            { text: 'Este documento es un reporte de control académico interno.', alignment: 'left', fontSize: 8, color: '#95A5A6' },
            { text: \`Página \${currentPage} de \${pageCount}\`, alignment: 'right', fontSize: 8, color: '#95A5A6' }
          ],
          margin: [40, 0, 40, 0]
        };
      }
    };

    exportStatus.value.individualPdf = 'success';
    
    setTimeout(() => {
      pdfMake.createPdf(docDefinition).download(\`Boleta_Calificacion_\${estudiante.value?.nombres || 'Estudiante'}.pdf\`);
      setTimeout(() => {
        exportStatus.value.individualPdf = 'idle';
      }, 500);
    }, 1200);

  } catch (error) {
    console.error("Error al exportar PDF individual:", error);
    exportStatus.value.individualPdf = 'idle';
  }
};
`;

content = content.replace(
  /const fetchEstudiante = async \(\) => {/,
  newFunctions + '\n\nconst fetchEstudiante = async () => {'
);

fs.writeFileSync(filePath, content, 'utf8');
console.log('Done replacement!');
