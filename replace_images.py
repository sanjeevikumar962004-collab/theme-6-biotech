import os
import re

html_path = 'index.html'
images_dir = 'images'

# Read HTML
with open(html_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Get available stock images (exclude whitelogo and hero 1)
stock_images = [f"images/{img}" for img in os.listdir(images_dir) if img.startswith('pexels-') and img.endswith('.webp')]
stock_images.sort()

# Specifically replace the hero BANNER
content = re.sub(
    r'https://cdn\.prod\.website-files\.com/[^\s"\'\>]+?_BANNER\.avif',
    'images/hero 1.webp',
    content
)

# Replace all other CDN images (jpg, jpeg, png, webp, avif)
# We will use a function to pull from the stock_images list nicely
img_idx = 0
def repl_image(match):
    global img_idx
    url = match.group(0)
    # Ignore SVG, MP4, WEBM
    if url.lower().endswith(('.svg', '.mp4', '.webm')):
        return url
    
    # We found a target image url
    replacement = stock_images[img_idx % len(stock_images)]
    img_idx += 1
    return replacement

# Find anything that looks like the CDN URL and ends in an image extension
pattern = r'https://cdn\.prod\.website-files\.com/[^\s"\'\>\)]+\.(?:jpg|jpeg|png|webp|avif)'

content = re.sub(pattern, repl_image, content, flags=re.IGNORECASE)

# Write back
with open(html_path, 'w', encoding='utf-8') as f:
    f.write(content)

print(f"Replaced {img_idx} remote images with local ones from the images directory.")
