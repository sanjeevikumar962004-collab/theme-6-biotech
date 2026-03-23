const fs = require('fs');
const path = require('path');

const dir = 'd:/new themes/n bio';
const files = fs.readdirSync(dir).filter(f => f.endsWith('.html'));

files.forEach(file => {
    const filePath = path.join(dir, file);
    let content = fs.readFileSync(filePath, 'utf8');

    // 1. Update logo in header
    // The logo could be <img src="images/logo.png" or similar inside sh-logo or similar
    // Wait, the header in index.html is:
    // <a href="index.html" class="sh-logo">
    //     <img src="images/whitelogo.webp" alt="Stackly Logo" />
    // </a>
    // We can regex replace the img src completely if it's right after sh-logo
    content = content.replace(/(<a[^>]*class="sh-logo"[^>]*>\s*<img[^>]*src=")([^"]+)("[^>]*>)/g, '$1images/whitelogo.webp$3');

    // 2. Update Login link
    // <a href="contact2.html" class="sh-client-btn">Login</a> -> <a href="login.html" class="sh-client-btn">Login</a>
    content = content.replace(/(<a[^>]*href=")[^"]+("[^>]*class="sh-client-btn"[^>]*>Login<\/a>)/g, '$1login.html$2');

    // 3. For index.html, update expert section
    if (file === 'index.html') {
        // Update + icon hrefs: <a href="/specialist/...
        content = content.replace(/(<a\s+href=")\/specialist\/([^"]+)(")/g, '$1404.html$3');
        
        // Update socials in the expert section
        // We know they are inside a <div class="w-layout-hflex rt-doctor-social-media-warpper">
        // The easiest regex is: replace all instagram, dribbble, x links to 404.html if they are in the social wrapper
        // But simpler: just string replace the specific lines or regex the href="https://..." when next to target="_blank" class="rt-doctor-social-media-icon-wrapper...
        content = content.replace(/(<a[^>]*data-w-id="[^"]+"[^>]*href=")https:\/\/[^"]+("[^>]*target="_blank"[^>]*class="rt-doctor-social-media-icon-wrapper[^>]*>)/g, '$1404.html$2');
    }

    fs.writeFileSync(filePath, content, 'utf8');
});

console.log('Update complete.');
