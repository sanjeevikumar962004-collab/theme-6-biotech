$files = "index.html", "about.html", "blog.html", "contact2.html", "service.html"
$newLinks = @"
          <div class="mf-links">
            <h4>Navigation</h4>
            <a href="index.html">Home</a>
            <a href="about.html">About</a>
            <a href="blog.html">Blog</a>
            <a href="service.html">Services</a>
            <a href="contact2.html">Contact</a>
            <a href="contact2.html">Login</a>
          </div>
"@

$pattern = '(?si)<div class="mf-links">\s*<h4>Navigation</h4>\s*<a href="index\.html">Home</a>.*?</div\s*>'
$utf8NoBom = New-Object System.Text.UTF8Encoding($False)

foreach ($file in $files) {
    if (Test-Path $file) {
        $path = (Resolve-Path $file).Path
        $content = [System.IO.File]::ReadAllText($path, $utf8NoBom)
        $content = [regex]::Replace($content, $pattern, $newLinks)
        [System.IO.File]::WriteAllText($path, $content, $utf8NoBom)
        Write-Host "Updated footer links in $file"
    }
}
