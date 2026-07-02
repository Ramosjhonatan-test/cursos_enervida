const fs = require('fs');
const path = require('path');

const filesToFix = [
  'src/views/ForgotPasswordView.vue',
  'src/views/LoginView.vue',
  'src/views/RegisterView.vue',
  'src/views/ResetPasswordView.vue',
  'src/views/VerifyEmailView.vue',
];

filesToFix.forEach(file => {
  const filePath = path.join(__dirname, file);
  if (!fs.existsSync(filePath)) return;
  
  let content = fs.readFileSync(filePath, 'utf8');
  const original = content;

  // Since we removed glass-card, we can just safely remove this obsolete styling block
  // or revert its name to avoid CSS errors. Since it was defining background/border,
  // we can just remove the whole class block or change it back to .glass-card 
  // (which is no longer used in the template, so it's harmless, or we can just delete it).
  // Let's just change it back to .glass-card for safety.
  content = content.replace(/\.bg-\[#13193e\] border border-\[#262d55\]/g, '.glass-card');

  if (content !== original) {
    fs.writeFileSync(filePath, content);
    console.log(`✅ Cleaned CSS in: ${file}`);
  }
});
