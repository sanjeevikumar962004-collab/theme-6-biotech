/* Biotech Preloader Logic */
(function() {
    window.addEventListener('load', function() {
        const preloader = document.getElementById('rt-preloader');
        if (preloader) {
            // Ensure preloader stays for at least 800ms for branding
            setTimeout(() => {
                preloader.classList.add('fade-out');
                // Remove from DOM after transition
                setTimeout(() => {
                    preloader.remove();
                }, 600);
            }, 800);
        }
    });

    // Fallback if load event takes too long
    setTimeout(() => {
        const preloader = document.getElementById('rt-preloader');
        if (preloader) {
            preloader.classList.add('fade-out');
            setTimeout(() => preloader.remove(), 600);
        }
    }, 5000);
})();
