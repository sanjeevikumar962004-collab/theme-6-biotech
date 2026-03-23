$files = @("index.html", "about.html", "blog.html", "contact2.html")
$newHeader = @"
    <!-- === NEW MODERN HEADER === -->
    <!-- === RESTORED MOD HEADER === -->
    <header class="stackly-header">
        <div class="sh-container">
            <a href="index.html" class="sh-logo">
                <img src="images/whitelogo.webp" alt="Stackly Logo" />
            </a>
            <nav class="sh-nav">
                <a href="index.html">Home</a>
                <a href="about.html">About</a>
                <a href="blog.html">Blog</a>
                <a href="contact2.html">Contact</a>
                <a href="contact2.html" class="sh-client-btn">Login</a>
            </nav>
            <div class="sh-mobile-menu">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </header>
"@

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content -Raw $file -Encoding UTF8
        # Find everything between <!-- === NEW MODERN HEADER === --> and <main>
        
        $pattern1 = '(?si)<!-- === NEW MODERN HEADER === -->.*?<main>'
        $pattern2 = '(?si)<!-- === NEW MODERN HEADER === -->.*?<section '
        $pattern3 = '(?si)<div data-wf--rt-navbar-v2--variant="home-two".*?</div>\s*</div>\s*</div>\s*</div>\s*</div>\s*</div>'

        if ($content -match $pattern1) {
            $content = $content -replace $pattern1, ($newHeader + "`r`n    <main>")
            Set-Content -Path $file -Value $content -Encoding UTF8
            Write-Host "Replaced pattern1 in $file"
        } elseif ($content -match $pattern2) {
            $content = $content -replace $pattern2, ($newHeader + "`r`n    <section ")
            Set-Content -Path $file -Value $content -Encoding UTF8
            Write-Host "Replaced pattern2 in $file"
        } elseif ($content -match $pattern3) {
            $content = $content -replace $pattern3, ($newHeader + "`r`n")
            Set-Content -Path $file -Value $content -Encoding UTF8
            Write-Host "Replaced pattern3 in $file"
        } else {
            Write-Host "Could not find matching header section in $file"
        }
    }
}
