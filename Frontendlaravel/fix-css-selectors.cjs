const fs = require('fs');
const path = require('path');

const longClass = 'w-full bg-white/5 border border-[#262d55] rounded-lg px-4 py-2.5 text-sm text-gray-300 focus:ring-1 focus:ring-[#8a3ffc] outline-none placeholder:text-gray-500';

// Files that have broken <style> blocks
const filesToFix = [
  'src/views/LoginView.vue',
  'src/views/RegisterView.vue', 
  'src/views/ForgotPasswordView.vue',
  'src/views/ResetPasswordView.vue',
  'src/views/VerifyEmailView.vue',
];

filesToFix.forEach(file => {
  const filePath = path.join(__dirname, file);
  if (!fs.existsSync(filePath)) return;
  let content = fs.readFileSync(filePath, 'utf8');
  const original = content;

  // Restore the CSS selectors - replace the mangled class name back to .input-cyber
  content = content.replace(
    new RegExp(`\\.${longClass.replace(/[.*+?^${}()|[\]\\\/]/g, '\\$&')}`, 'g'),
    '.input-cyber'
  );

  // In templates, keep using utility classes but shorten them with a simple class
  // Replace the super long class in templates with just 'input-darken'
  content = content.replace(
    new RegExp(longClass.replace(/[.*+?^${}()|[\]\\\/]/g, '\\$&'), 'g'),
    'input-darken'
  );

  if (content !== original) {
    fs.writeFileSync(filePath, content);
    console.log(`✅ Fixed: ${file}`);
  } else {
    console.log(`⏭️ No changes: ${file}`);
  }
});

// Also fix StudentView and admin files - replace long class with input-darken
const otherFiles = [
  'src/views/StudentView.vue',
  ...fs.readdirSync(path.join(__dirname, 'src/views/admin')).map(f => `src/views/admin/${f}`)
];

otherFiles.forEach(file => {
  const filePath = path.join(__dirname, file);
  if (!fs.existsSync(filePath)) return;
  let content = fs.readFileSync(filePath, 'utf8');
  const original = content;

  content = content.replace(
    new RegExp(longClass.replace(/[.*+?^${}()|[\]\\\/]/g, '\\$&'), 'g'),
    'input-darken'
  );

  if (content !== original) {
    fs.writeFileSync(filePath, content);
    console.log(`✅ Fixed: ${file}`);
  }
});

console.log('\nDone!');
