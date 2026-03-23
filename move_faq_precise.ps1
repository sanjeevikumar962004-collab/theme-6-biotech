$blog = Get-Content -Raw "d:\new themes\n bio\blog.html" -Encoding UTF8
$startFaq = $blog.IndexOf('<section class="rt-faq">')
$endFaq = $blog.IndexOf('<!-- === NEW MODERN FOOTER === -->')

# Fallback for endFaq if no NEW MODERN comment
if ($endFaq -lt 0) {
    $endFaq = $blog.IndexOf('<footer class="modern-footer">')
}

if ($startFaq -ge 0 -and $endFaq -gt $startFaq) {
    # Extracted FAQ
    $faqHtml = $blog.Substring($startFaq, $endFaq - $startFaq).Trim()
    
    # ------------- ABOUT.HTML -------------
    $about = Get-Content -Raw "d:\new themes\n bio\about.html" -Encoding UTF8
    $startAwards = $about.IndexOf('<!-- — AWARDS — -->')
    if ($startAwards -lt 0) { $startAwards = $about.IndexOf('<!-- â• â• â•  AWARDS â• â• â•  -->') }
    if ($startAwards -lt 0) { $startAwards = $about.IndexOf('<section class="sec sec--dark">') } # fallback
    
    $endAboutContent = $about.IndexOf('<!-- === NEW MODERN FOOTER === -->')
    if ($endAboutContent -lt 0) { $endAboutContent = $about.IndexOf('<footer class="modern-footer">') }

    if ($startAwards -ge 0 -and $endAboutContent -gt $startAwards) {
        $newAbout = $about.Substring(0, $startAwards) + "`r`n`r`n<!-- === FAQ FROM BLOG === -->`r`n" + $faqHtml + "`r`n`r`n" + $about.Substring($endAboutContent)
        $utf8NoBom = New-Object System.Text.UTF8Encoding($False)
        [System.IO.File]::WriteAllText("d:\new themes\n bio\about.html", $newAbout, $utf8NoBom)
        Write-Host "about.html updated successfully."
    } else {
        Write-Host "about bounds missed. Start($startAwards) End($endAboutContent)"
    }

    # ------------- CONTACT2.HTML -------------
    $contact = Get-Content -Raw "d:\new themes\n bio\contact2.html" -Encoding UTF8
    $startContactFaq = $contact.IndexOf('<!-- FAQ MINI SECTION -->')
    if ($startContactFaq -lt 0) { $startContactFaq = $contact.IndexOf('<section class="c2-faq">') }
    
    $endContactMain = $contact.IndexOf('</main>')
    if ($endContactMain -lt 0) { $endContactMain = $contact.IndexOf('<!-- === NEW MODERN FOOTER === -->') }
    
    if ($startContactFaq -ge 0 -and $endContactMain -gt $startContactFaq) {
        $newContact = $contact.Substring(0, $startContactFaq) + "`r`n`r`n<!-- === FAQ FROM BLOG === -->`r`n" + $faqHtml + "`r`n`r`n    " + $contact.Substring($endContactMain)
        $utf8NoBom = New-Object System.Text.UTF8Encoding($False)
        [System.IO.File]::WriteAllText("d:\new themes\n bio\contact2.html", $newContact, $utf8NoBom)
        Write-Host "contact2.html updated successfully."
    } else {
        Write-Host "contact bounds missed. Start($startContactFaq) End($endContactMain)"
    }
} else {
    Write-Host "FAQ extraction failed. Start($startFaq) End($endFaq)"
}
