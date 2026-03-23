import os

files = ["d:/new themes/n bio/dashboard.html", "d:/new themes/n bio/admin.html"]

replacements = {
    'â€“': '–', 'â€º': '›', 'â€”': '—', 'â†’': '→', 'â„¢': '™', 'Ã—': '×', 'Â·': '·',
    'â€™': "'", 'â€˜': "'", 'â€œ': '"', 'â€ ': '"',
    'ðŸ”¬': '🔬', 'ðŸ’Š': '💊', 'ðŸ§¬': '🧬', 'ðŸ ¥': '🏥', 'ðŸ¤ ': '🤝', 'ðŸŒ ': '🌍',
    'â™»ï¸ ': '♻️', 'âš¡': '⚡', 'ðŸ †': '🏆', 'ðŸ§ª': '🧫', 'âœ…': '✅', 'ðŸŽ“': '🎓', 'ðŸ’¡': '💡',
    "  });\n  });\n})();": "  });\n})();",
    "  });\r\n  });\r\n})();": "  });\r\n})();"
}

for filepath in files:
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for k, v in replacements.items():
        content = content.replace(k, v)
        
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

print("Fixes applied.")
