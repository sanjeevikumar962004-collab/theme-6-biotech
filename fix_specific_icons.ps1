$ErrorActionPreference = "Stop"

$playIconHtml = "<i class=""fa-solid fa-play"" style=""color: #0d1b2a; font-size: 20px; padding-left: 2px;""></i>"
$rightArrowHtml = "<i class=""fa-solid fa-arrow-right rt-button-arrow"" style=""color: currentColor; font-size: 16px;""></i>"
$faqArrowHtml = "<i class=""fa-solid fa-chevron-down"" style=""color: currentColor; font-size: 14px;""></i>"

foreach ($htmlFile in Get-ChildItem -Filter "*.html") {
    $content = Get-Content -Raw $htmlFile.FullName -Encoding UTF8
    $changed = $false

    # Play Icon Replacement
    if ($content -match '<img[^>]*alt="Play video"[^>]*>') {
        $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?i)<img[^>]*alt="Play video"[^>]*>', $playIconHtml)
        $changed = $true
    }

    # Right Arrow Replacement (in buttons and Explore more)
    if ($content -match '<img[^>]*alt="arrow"[^>]*class="rt-button-arrow[^>]*>') {
        $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?i)<img[^>]*alt="arrow"[^>]*class="rt-button-arrow[^>]*>', $rightArrowHtml)
        $changed = $true
    }
    
    # FAQ Arrows Replacement
    # The original SVG was often class="rt-faq-one", "rt-faq-two", etc.
    if ($content -match '<img[^>]*class="rt-faq-(?:one|two|three|four|five)"[^>]*>') {
        $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?i)<img[^>]*class="rt-faq-(?:one|two|three|four|five)"[^>]*>', $faqArrowHtml)
        $changed = $true
    }
    
    # In case there are other alt="arrow" without full classes (like the 25+ experience section)
    # Looking at the HTML, the Explore More actually had alt="arrow". 
    # What about the 25+ experience picture? Let's aggressively replace any `<img[^>]*alt="arrow"[^>]*>` missing the class check
    if ($content -match '<img[^>]*alt="arrow"[^>]*>') {
        $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?i)<img[^>]*alt="arrow"[^>]*>', $rightArrowHtml)
        $changed = $true
    }
    
    # Footer Socials Links -> 404.html
    # We will find `<div class="mf-socials">...</div>` and replace `<a href="#">` or arbitrary URLs inside it to `404.html`
    if ($content -match 'class="mf-socials"') {
        # Using a MatchEvaluator to only replace hrefs inside mf-socials block
        $evaluator = [System.Text.RegularExpressions.MatchEvaluator] {
            param([System.Text.RegularExpressions.Match]$match)
            $socialsBlock = $match.Value
            return [System.Text.RegularExpressions.Regex]::Replace($socialsBlock, 'href="[^"]*"', 'href="404.html"')
        }
        $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?si)<div class="mf-socials">.*?</div>', $evaluator)
        $changed = $true
    }

    if ($changed) {
        Set-Content -Path $htmlFile.FullName -Value $content -Encoding UTF8
        Write-Host "Replaced icons/footer in $($htmlFile.Name)"
    }
}
Write-Host "Icon replacements complete."
