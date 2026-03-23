const fs = require('fs');

const files = ['dashboard.html', 'admin.html'];

const replacements = [
    { target: 'â€”', repl: '—' },
    { target: 'â€“', repl: '–' },
    { target: 'â€™', repl: "'" },
    { target: 'â€˜', repl: "'" },
    { target: 'â€œ', repl: '"' },
    { target: 'â€ ', repl: '"' },
    { target: 'â€º', repl: '›' },
    { target: 'Ã—', repl: '×' },
    { target: 'Â·', repl: '·' },
    { target: 'ðŸ”¬', repl: '🔬' },
    { target: 'ðŸ’Š', repl: '💊' },
    { target: 'ðŸ§¬', repl: '🧬' },
    { target: 'ðŸ ¥', repl: '🏥' },
    { target: 'ðŸ¤ ', repl: '🤝' },
    { target: 'ðŸŒ ', repl: '🌍' },
    { target: 'â™»ï¸ ', repl: '♻️' },
    { target: 'âš¡', repl: '⚡' },
    { target: 'ðŸ †', repl: '🏆' },
    { target: 'ðŸ§ª', repl: '🧫' },
    { target: 'âœ…', repl: '✅' },
    { target: 'ðŸŽ“', repl: '🎓' },
    { target: 'ðŸ’¡', repl: '💡' },
    { target: '  });\n  });\n})();', repl: '  });\n})();' },
    { target: '  });\r\n  });\r\n})();', repl: '  });\r\n})();' }
];

for(const file of files) {
  let content = fs.readFileSync(file, 'utf8');
  for (const r of replacements) {
      content = content.split(r.target).join(r.repl);
  }
  fs.writeFileSync(file, content, 'utf8');
}
console.log('Fixed syntax and encoding.');
