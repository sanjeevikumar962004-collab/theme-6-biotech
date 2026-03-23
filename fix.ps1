$content = [System.IO.File]::ReadAllText("d:\new themes\n bio\index.html")

# Fix specialist links
$content = [regex]::Replace($content, 'href="/specialist/[^"]+"', 'href="404.html"')

# Fix social links next to target="_blank" and class="rt-doctor-social-media-icon-wrapper..."
$content = [regex]::Replace($content, 'href="https://[^"]+"\starget="_blank"\s+class="rt-doctor-social-media-icon-wrapper[^"]*"', 'href="404.html" target="_blank" class="rt-doctor-social-media-icon-wrapper w-inline-block"')

[System.IO.File]::WriteAllText("d:\new themes\n bio\index.html", $content)
Write-Output "Done"
