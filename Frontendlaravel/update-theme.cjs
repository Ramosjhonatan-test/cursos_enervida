const fs = require('fs');
let css = fs.readFileSync('src/assets/main.css', 'utf8');

const newDark = `html.dark {
    --background: #0b0e29;
    --on-surface: #e2e8f0;
    --on-surface-variant: #94a3b8;
    --primary: #0b0e29;
    --accent-neon: #8a3ffc;
    --accent-solar: #f1c21b;
    --surface-container: #0f1435;
    --surface-card: #13193e;
    --glass-bg: #13193e;
    --glass-border: #262d55;
    --input-bg: #0b0e29;
    --input-border: #262d55;
    --shadow-premium: 0 1px 3px rgba(0, 0, 0, 0.3);
    --primary-container: #1e2a5e;
    --secondary-container: #262d55;
    --tertiary-container: #0f1435;
    --on-primary-container: #8a3ffc;
    --on-secondary-container: #ff7eb6;
    --on-tertiary-container: #33b1ff;
    --accent-pink: #ff7eb6;
    --accent-cyan: #33b1ff;
    --accent-green: #42be65;
  }`;

css = css.replace(/html\.dark \{[\s\S]*?\}/, newDark);
fs.writeFileSync('src/assets/main.css', css);
console.log('Dark theme updated with exact template colors!');
