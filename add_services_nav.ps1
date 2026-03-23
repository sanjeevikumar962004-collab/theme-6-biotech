$files = @("index.html", "about.html", "blog.html", "contact2.html", "service.html")

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = Get-Content -Raw $file -Encoding UTF8
        
        # 1. Add Services link to header
        # Find: <a href="contact2.html">Contact</a>
        # Replace with: <a href="service.html">Services</a>`n                <a href="contact2.html">Contact</a>
        $findHeader = '<a href="contact2.html">Contact</a>'
        $replaceHeader = '<a href="service.html">Services</a>' + "`r`n                " + '<a href="contact2.html">Contact</a>'
        $content = $content.Replace($findHeader, $replaceHeader)
        
        # 2. Add Services link to footer (if the modern footer exists)
        # Find: <a href="/contact2">Contact Us</a>  OR <a href="contact2.html">Contact</a>
        # Let's check footer structure usually it's in mf-links
        # I'll just add it after <a href="/about">About Us</a> or similar...
        
        Set-Content -Path $file -Value $content -Encoding UTF8
        Write-Host "Updated header nav in $file"
    }
}
