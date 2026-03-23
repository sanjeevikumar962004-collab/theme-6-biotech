const fs = require('fs');
const path = require('path');

const imagesDir = 'images';

const stockImages = fs.readdirSync(imagesDir)
    .filter(img => img.startsWith('pexels-') && img.endsWith('.webp'))
    .map(img => `images/${img}`)
    .sort();

// Find all HTML files in the current directory
const files = fs.readdirSync('.').filter(file => file.endsWith('.html'));

files.forEach(htmlPath => {
    let content = fs.readFileSync(htmlPath, 'utf8');

    // Replace the hero BANNER
    content = content.replace(
        /https:\/\/cdn\.prod\.website-files\.com\/[^\s"'<>]+?_BANNER\.avif/g,
        'images/hero 1.webp'
    );

    let imgIdx = 0;
    // Replace all other CDN images including avif and svg
    const pattern = /https:\/\/cdn\.prod\.website-files\.com\/[^\s"'<>)\?]+\.(jpg|jpeg|png|webp|avif|svg)/gi;

    content = content.replace(pattern, (match) => {
        if (match.toLowerCase().endsWith('.mp4') || match.toLowerCase().endsWith('.webm')) {
            return match;
        }
        const replacement = stockImages[imgIdx % stockImages.length];
        imgIdx++;
        return replacement;
    });

    fs.writeFileSync(htmlPath, content, 'utf8');
    console.log(`[${htmlPath}] Replaced ${imgIdx} remote images with local webp ones.`);
});
