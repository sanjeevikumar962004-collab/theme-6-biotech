$dir = "d:\new themes\n bio"
$files = Get-ChildItem -Path $dir -Filter "*.html"

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    
    # 1. Update logo in header
    # Find: <a [^>]*class="sh-logo"[^>]*> \s* <img src="[^"]+"
    $content = [regex]::Replace($content, '(<a[^>]*class="sh-logo"[^>]*>\s*<img[^>]*src=")([^"]+)("[^>]*>)', '${1}images/whitelogo.webp$3')
    
    # 2. Update Login link in header
    # Find: <a href="..." class="sh-client-btn">Login</a>
    $content = [regex]::Replace($content, '(<a[^>]*href=")[^"]+("[^>]*class="sh-client-btn"[^>]*>Login</a>)', '${1}login.html$2')

    if ($file.Name -eq "index.html") {
        # 3. Update + icon hrefs in the expert section
        $content = [regex]::Replace($content, '(<a\s+href=")/specialist/[^"]+(")', '${1}404.html$2')
        
        # 4. Update socials in the expert section
        $content = [regex]::Replace($content, '(<a[^>]*data-w-id="[^"]+"[^>]*href=")https://[^"]+("[^>]*target="_blank"[^>]*class="rt-doctor-social-media-icon-wrapper[^>]*>)', '${1}404.html$2')
    }

    [System.IO.File]::WriteAllText($file.FullName, $content)
}

Write-Output "Update complete."
