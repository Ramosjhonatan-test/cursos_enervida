const fs = require('fs');
const path = require('path');

const adminDir = path.join(__dirname, 'src/views/admin');

const files = fs.readdirSync(adminDir).filter(f => f.endsWith('.vue'));

let totalChanges = 0;

files.forEach(file => {
  const filePath = path.join(adminDir, file);
  let content = fs.readFileSync(filePath, 'utf8');
  const original = content;

  // Replace glass-card-premium with Darken card style
  content = content.replace(/glass-card-premium\s+p-(\d+)\s+rounded-\[\d+px\]\s+border-accent-neon\/\d+/g, 
    'bg-[#13193e] rounded-xl border border-[#262d55]');

  // Replace glass-card p-X rounded-[Xpx] border-accent-neon/X
  content = content.replace(/glass-card\s+p-(\d+)\s+rounded-\[\d+px\]\s+border-accent-neon\/\d+/g, 
    (match, padding) => `bg-[#13193e] rounded-xl border border-[#262d55]`);

  // Replace glass-card p-X rounded-[Xpx] border-on-surface/X
  content = content.replace(/glass-card\s+p-(\d+)\s+rounded-\[\d+px\]\s+border-on-surface\/\d+/g, 
    (match, padding) => `bg-[#13193e] rounded-xl border border-[#262d55]`);

  // Replace glass-card rounded-[Xpx] overflow-hidden border-accent-neon/X
  content = content.replace(/glass-card\s+rounded-\[\d+px\]\s+overflow-hidden\s+border-accent-neon\/\d+/g, 
    'bg-[#13193e] rounded-xl overflow-hidden border border-[#262d55]');

  // Replace glass-card rounded-[Xpx] border-on-surface/X overflow-hidden
  content = content.replace(/glass-card\s+rounded-\[\d+px\]\s+border-on-surface\/\d+\s+overflow-hidden/g, 
    'bg-[#13193e] rounded-xl border border-[#262d55] overflow-hidden');

  // Replace glass-card p-X rounded-3xl border-accent-neon/X
  content = content.replace(/glass-card\s+p-(\d+)\s+rounded-3xl\s+border-accent-neon\/\d+/g, 
    'bg-[#13193e] rounded-xl border border-[#262d55]');

  // Replace remaining glass-card-premium references
  content = content.replace(/glass-card-premium/g, 'bg-[#13193e] border border-[#262d55]');

  // Replace glass-card with bg card (standalone)
  content = content.replace(/glass-card\s+p-(\d+)\s+sm:p-(\d+)\s+rounded-\[\d+px\]\s+sm:rounded-\[\d+px\]\s+border-accent-neon\/\d+/g,
    'bg-[#13193e] rounded-xl border border-[#262d55]');
    
  content = content.replace(/glass-card\s+p-(\d+)\s+rounded-\[\d+px\]\s+md:rounded-\[\d+px\]\s+border-accent-neon\/\d+/g,
    'bg-[#13193e] rounded-xl border border-[#262d55]');

  // Replace remaining standalone glass-card
  content = content.replace(/glass-card\s+p-(\d+)\s+rounded-\[\d+px\]/g,
    'bg-[#13193e] rounded-xl border border-[#262d55]');

  // Fix any remaining glass-card references
  content = content.replace(/class="glass-card /g, 'class="bg-[#13193e] border border-[#262d55] ');

  // Replace old button styles
  content = content.replace(/btn-premium btn-primary-neon/g, 'bg-[#8a3ffc] hover:bg-[#7c35e0] text-white font-medium rounded-lg');
  content = content.replace(/btn-premium btn-secondary-glass/g, 'bg-white/5 hover:bg-white/10 text-gray-300 font-medium rounded-lg border border-[#262d55]');

  // Replace old font-black tracking-widest headers
  content = content.replace(/text-3xl font-black text-on-surface font-lexend tracking-tighter/g, 'text-xl font-bold text-white');
  
  // Replace input-cyber
  content = content.replace(/input-cyber/g, 'w-full bg-white/5 border border-[#262d55] rounded-lg px-4 py-2.5 text-sm text-gray-300 focus:ring-1 focus:ring-[#8a3ffc] outline-none placeholder:text-gray-500');

  if (content !== original) {
    fs.writeFileSync(filePath, content);
    totalChanges++;
    console.log(`✅ Updated: ${file}`);
  } else {
    console.log(`⏭️ No changes: ${file}`);
  }
});

// Also update StudentView
const studentPath = path.join(__dirname, 'src/views/StudentView.vue');
let studentContent = fs.readFileSync(studentPath, 'utf8');
const studentOrig = studentContent;

studentContent = studentContent.replace(/glass-card-premium/g, 'bg-[#13193e] border border-[#262d55]');
studentContent = studentContent.replace(/class="glass-card /g, 'class="bg-[#13193e] border border-[#262d55] ');
studentContent = studentContent.replace(/btn-premium btn-primary-neon/g, 'bg-[#8a3ffc] hover:bg-[#7c35e0] text-white font-medium rounded-lg');
studentContent = studentContent.replace(/btn-premium btn-secondary-glass/g, 'bg-white/5 hover:bg-white/10 text-gray-300 font-medium rounded-lg border border-[#262d55]');
studentContent = studentContent.replace(/input-cyber/g, 'w-full bg-white/5 border border-[#262d55] rounded-lg px-4 py-2.5 text-sm text-gray-300 focus:ring-1 focus:ring-[#8a3ffc] outline-none placeholder:text-gray-500');

if (studentContent !== studentOrig) {
  fs.writeFileSync(studentPath, studentContent);
  console.log('✅ Updated: StudentView.vue');
}

console.log(`\nDone! ${totalChanges} admin files updated.`);
