(function() {
    const header = document.querySelector('.stackly-header');
    
    // Header Scroll Logic
    if (header) {
        let lastScrollY = window.scrollY;
        let ticking = false;

        // Set initial state
        header.classList.add('nav-at-top');

        function updateHeader() {
            const currentScrollY = window.scrollY;
            
            // Remove all state classes first
            header.classList.remove('nav-at-top', 'nav-scrolled-down', 'nav-scrolled-up');

            // At the very top, transparent and visible
            if (currentScrollY <= 50) {
                header.classList.add('nav-at-top');
            } 
            // Scrolling down: hide the header and make background dark
            else if (currentScrollY > lastScrollY) {
                header.classList.add('nav-scrolled-down');
            } 
            // Scrolling up: show the header with dark background
            else {
                header.classList.add('nav-scrolled-up');
            }

            lastScrollY = currentScrollY;
            ticking = false;
        }

        window.addEventListener('scroll', () => {
            if (!ticking) {
                window.requestAnimationFrame(updateHeader);
                ticking = true;
            }
        });

        // Initial check
        updateHeader();
    }

    // Mobile Menu Toggle Logic
    const mobileMenuBtn = document.querySelector('.sh-mobile-menu');
    const navMenu = document.querySelector('.sh-nav');
    
    if (mobileMenuBtn && navMenu) {
        mobileMenuBtn.addEventListener('click', () => {
            navMenu.classList.toggle('active');
            mobileMenuBtn.classList.toggle('open');
            
            // Prevent body scrolling when menu is open
            if(navMenu.classList.contains('active')) {
                document.body.style.overflow = 'hidden';
            } else {
                document.body.style.overflow = '';
            }
        });

        // Close menu on link click
        navMenu.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                navMenu.classList.remove('active');
                mobileMenuBtn.classList.remove('open');
                document.body.style.overflow = '';
            });
        });
    }

    // Set Active Link Based on Current URL
    const currentPath = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('.sh-nav a:not(.sh-client-btn)');
    
    navLinks.forEach(link => {
        const linkPath = link.getAttribute('href');
        if (linkPath === currentPath) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });

    // Global Form Interceptor for Contact and Newsletter Forms
    document.addEventListener('submit', function(e) {
        if (e.target && e.target.tagName === 'FORM') {
            const action = e.target.getAttribute('action');
            if (action === '404.html' || e.target.classList.contains('mf-form') || e.target.classList.contains('c2-form') || e.target.classList.contains('nl-form')) {
                e.preventDefault();
                e.stopPropagation();
                window.location.href = '404.html';
            }
        }
    }, true);

})();
