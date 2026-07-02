const fs = require('fs');
const path = require('path');

const viewsDir = path.join(__dirname, 'src/views');
const authFiles = ['LoginView.vue', 'RegisterView.vue', 'ForgotPasswordView.vue', 'ResetPasswordView.vue', 'VerifyEmailView.vue', 'StudentView.vue'];

authFiles.forEach(file => {
  const filePath = path.join(viewsDir, file);
  if (!fs.existsSync(filePath)) return;
  let content = fs.readFileSync(filePath, 'utf8');
  const original = content;

  // Replace glass-card class references
  content = content.replace(/class="glass-card /g, 'class="bg-[#13193e] border border-[#262d55] ');
  content = content.replace(/glass-card-premium/g, 'bg-[#13193e] border border-[#262d55]');
  
  // Replace old button styles  
  content = content.replace(/btn-premium btn-primary-neon/g, 'bg-[#8a3ffc] hover:bg-[#7c35e0] text-white font-medium rounded-lg');
  content = content.replace(/btn-premium btn-secondary-glass/g, 'bg-white/5 hover:bg-white/10 text-gray-300 font-medium rounded-lg border border-[#262d55]');
  
  // Replace input-cyber
  content = content.replace(/input-cyber/g, 'w-full bg-white/5 border border-[#262d55] rounded-lg px-4 py-2.5 text-sm text-gray-300 focus:ring-1 focus:ring-[#8a3ffc] outline-none placeholder:text-gray-500');

  if (content !== original) {
    fs.writeFileSync(filePath, content);
    console.log(`✅ Updated: ${file}`);
  } else {
    console.log(`⏭️ No changes: ${file}`);
  }
});

console.log('Done!');
