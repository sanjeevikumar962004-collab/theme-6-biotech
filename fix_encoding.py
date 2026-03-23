import os

replacements = {
    'â€”': '—',
    'â€“': '–',
    'â€™': "'",
    'â€˜': "'",
    'â€œ': '"',
    'â€ ': '"',
    'â€º': '›',
    'Ã—': '×',
    'Â·': '·'
}

files = [f for f in os.listdir('.') if f.endswith('.html')]

for f in files:
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
    
    orig = content
    for k, v in replacements.items():
        content = content.replace(k, v)
        
    if content != orig:
        with open(f, 'w', encoding='utf-8') as file:
            file.write(content)
        print(f"Fixed encoding in {f}")

print("Done python fix")
