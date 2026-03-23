const fs = require('fs');
const path = require('path');

const htmlPath = 'index.html';
const imagesDir = 'images';

let content = fs.readFileSync(htmlPath, 'utf8');

const stockImages = fs.readdirSync(imagesDir)
    .filter(img => img.startsWith('pexels-') && img.endsWith('.webp'))
    .map(img => `images/${img}`)
    .sort();

// Replace the hero BANNER
content = content.replace(
    /https:\/\/cdn\.prod\.website-files\.com\/[^\s"'<>]+?_BANNER\.avif/g,
    'images/hero 1.webp'
);

let imgIdx = 0;
// Replace all other CDN images
const pattern = /https:\/\/cdn\.prod\.website-files\.com\/[^\s"'<>)]+\.(jpg|jpeg|png|webp|avif)/gi;

content = content.replace(pattern, (match) => {
    if (match.toLowerCase().endsWith('.svg') || match.toLowerCase().endsWith('.mp4') || match.toLowerCase().endsWith('.webm')) {
        return match;
    }
    const replacement = stockImages[imgIdx % stockImages.length];
    imgIdx++;
    return replacement;
});

fs.writeFileSync(htmlPath, content, 'utf8');
console.log(`Replaced ${imgIdx} remote images with local ones from the images directory.`);
