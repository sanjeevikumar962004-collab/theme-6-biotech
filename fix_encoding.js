const fs = require('fs');
const path = require('path');

const dir = './';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.html'));

const replacements = [
    { target: 'â€”', repl: '—' },
    { target: 'â€“', repl: '–' },
    { target: 'â€™', repl: "'" },
    { target: 'â€˜', repl: "'" },
    { target: 'â€œ', repl: '"' },
    { target: 'â€ ', repl: '"' },
    { target: 'â€º', repl: '›' },
    { target: 'Ã—', repl: '×' },
    { target: 'Â·', repl: '·' }
];

for (const file of files) {
    let content = fs.readFileSync(path.join(dir, file), 'utf8');
    let original = content;
    
    for (const r of replacements) {
        content = content.split(r.target).join(r.repl);
    }
    
    if (content !== original) {
        fs.writeFileSync(path.join(dir, file), content, 'utf8');
        console.log(`Fixed encoding in ${file}`);
    }
}
console.log('Done fix_encoding.js');
