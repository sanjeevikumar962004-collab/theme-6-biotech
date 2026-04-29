/**
 * Stackly – Biotech Company
 * Main JavaScript – Extracted from Webflow inline scripts
 */

// Load Google Fonts via WebFont Loader
WebFont.load({
    google: {
        families: ["Plus Jakarta Sans:300,400,500,600,700"]
    }
});

// Webflow JS-detection classes (touch / js mod detection)
(function (o, c) {
    var n = c.documentElement,
        t = " w-mod-";
    n.className += t + "js";
    ("ontouchstart" in o || (o.DocumentTouch && c instanceof DocumentTouch)) &&
        (n.className += t + "touch");
})(window, document);
