import os
import re
import glob

images_dir = 'images'

# Get available stock images (exclude whitelogo and hero 1)
stock_images = [f"images/{img}" for img in os.listdir(images_dir) if img.startswith('pexels-') and img.endswith('.webp')]
stock_images.sort()

# Precompile pattern
# Match any cdn url ending in an image extension
pattern = re.compile(r'https://cdn\.prod\.website-files\.com/[^\s"\'\>\)\?]+\.(?:jpg|jpeg|png|webp|avif|svg)', re.IGNORECASE)

img_idx = 0
def repl_image(match):
    global img_idx
    url = match.group(0)
    # Ignore video files
    if url.lower().endswith(('.mp4', '.webm')):
        return url
    
    # Use stock image cyclically
    replacement = stock_images[img_idx % len(stock_images)]
    img_idx += 1
    return replacement

for html_path in glob.glob('*.html'):
    with open(html_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Specifically replace the hero BANNER
    content = re.sub(
        r'https://cdn\.prod\.website-files\.com/[^\s"\'\>]+?_BANNER\.avif',
        'images/hero 1.webp',
        content
    )

    content = pattern.sub(repl_image, content)

    # Write back
    with open(html_path, 'w', encoding='utf-8') as f:
        f.write(content)

print(f"Replaced {img_idx} remote images with local ones across all HTML files.")
