$files = @("index.html", "about.html", "blog.html", "contact2.html")

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText((Resolve-Path $file).Path)
        
        # Replace the phone number text
        $content = $content -replace '>123<', '>1234567890<'
        
        # Replace the phone URI
        $content = $content -replace 'tel\:123', 'tel:1234567890'
        
        # Inject the stackly-header.js if not present
        if ($content -notmatch 'stackly-header\.js') {
            $content = $content -replace '</body>', "<script src=`"stackly-header.js`"></script>`n</body>"
        }
        
        [System.IO.File]::WriteAllText((Resolve-Path $file).Path, $content)
        Write-Host "Updated $file"
    }
}
