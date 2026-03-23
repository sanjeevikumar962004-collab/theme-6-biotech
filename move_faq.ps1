$blog = Get-Content -Raw "d:\new themes\n bio\blog.html" -Encoding UTF8

# Extract FAQ from blog.html
# It starts at <section class="rt-faq"> and ends before <!-- â• â• â•  FOOTER or <!-- === NEW MODERN FOOTER === -->
if ($blog -match '(?si)(<section class="rt-faq">.*?</section>)\s*<!-- === NEW MODERN FOOTER === -->') {
    $faqHtml = $matches[1]
    Write-Host "Found FAQ HTML from blog.html (length: $($faqHtml.Length))"
    
    # ----------------------------------------------------
    # Process about.html
    # ----------------------------------------------------
    $about = Get-Content -Raw "d:\new themes\n bio\about.html" -Encoding UTF8
    
    # In about.html, we want to keep everything up to the end of the "Our Journey" section
    # The "Our Journey" section is the timeline. 
    # Let's find: <!-- — AWARDS — --> and anything up to <!-- === NEW MODERN FOOTER === -->
    # Then replace that with the FAQ HTML.
    
    # Let's use regex to replace everything from <!-- — AWARDS — --> to right before the Footer.
    $aboutPattern = '(?si)<!-- — AWARDS — -->.*?(?=<!-- === NEW MODERN FOOTER === -->|<!-- — FOOTER — -->)'
    
    if ($about -match $aboutPattern) {
        $about = [regex]::Replace($about, $aboutPattern, "$faqHtml`r`n`r`n    ")
        Set-Content -Path "d:\new themes\n bio\about.html" -Value $about -Encoding UTF8
        Write-Host "Updated about.html"
    } else {
        # Maybe it's still using old encoded comments: <!-- â• â• â•  AWARDS â• â• â•  -->
        $altAboutPattern = '(?si)<!-- â• â• â•  AWARDS â• â• â•  -->.*?(?=<!-- === NEW MODERN FOOTER === -->)'
        if ($about -match $altAboutPattern) {
            $about = [regex]::Replace($about, $altAboutPattern, "$faqHtml`r`n`r`n    ")
            Set-Content -Path "d:\new themes\n bio\about.html" -Value $about -Encoding UTF8
            Write-Host "Updated about.html (alt pattern)"
        } else {
            Write-Host "Could not find AWARDS section in about.html"
        }
    }

    # ----------------------------------------------------
    # Process contact2.html
    # ----------------------------------------------------
    $contact = Get-Content -Raw "d:\new themes\n bio\contact2.html" -Encoding UTF8
    
    # In contact2.html, we want to replace <!-- FAQ MINI SECTION -->... </section> with the blog FAQ.
    $contactPattern = '(?si)<!-- FAQ MINI SECTION -->\s*<section class="c2-faq">.*?</section>'
    
    if ($contact -match $contactPattern) {
        $contact = [regex]::Replace($contact, $contactPattern, "$faqHtml")
        Set-Content -Path "d:\new themes\n bio\contact2.html" -Value $contact -Encoding UTF8
        Write-Host "Updated contact2.html"
    } else {
        Write-Host "Could not find FAQ MINI SECTION in contact2.html"
    }

} else {
    Write-Host "Could not extract FAQ from blog.html"
}
