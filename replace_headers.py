import os
import re

html_files = ['index.html', 'about.html', 'blog.html', 'contact2.html']
files_dir = r"d:\new themes\n bio"

new_header = """    <!-- === NEW MODERN HEADER === -->
    <header class="stackly-header">
        <div class="sh-container">
            <a href="index.html" class="sh-logo">
                <img src="images/whitelogo.webp" alt="Stackly Logo" />
            </a>
            <nav class="sh-nav">
                <a href="index.html">Home</a>
                <a href="about.html">About</a>
                <a href="blog.html">Blog</a>
                <a href="contact2.html">Contact</a>
                <a href="contact2.html" class="sh-client-btn">Login</a>
            </nav>
            <div class="sh-mobile-menu">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </header>"""

for file in html_files:
    filepath = os.path.join(files_dir, file)
    if os.path.exists(filepath):
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Regex to find the Webflow header bloc. It starts with <!-- === NEW MODERN HEADER === -->
        # and ends right before <main> or similar body content. We'll use a broad non-greedy regex.
        # Alternatively, find the first occurrence of <main> and replace everything between <body> and <main>
        
        # In index.html, it's between <!-- === NEW MODERN HEADER === --> and <main>
        # Let's replace the block robustly:
        
        pattern = re.compile(r'(<!-- === NEW MODERN HEADER === -->).*?(?=<main>|<div class="rt-home-v2|<section)', re.IGNORECASE | re.DOTALL)
        
        if pattern.search(content):
            new_content = pattern.sub(new_header + '\n    ', content)
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Successfully replaced header in {file}")
        else:
            print(f"Could not find matching header section in {file}")

