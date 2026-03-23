$files = @("index.html", "about.html", "blog.html", "contact2.html")

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText((Resolve-Path $file).Path)
        
        # Replace the button text
        $content = $content -replace '>Schedule appointment<', '>Login<'
        $content = $content -replace '>Appointment<', '>Login<'
        
        # Replace the phone number text
        $content = $content -replace '\(888\) 123 4560', '123'
        
        # Replace the phone URI
        $content = $content -replace 'tel\:8881234560', 'tel:123'
        $content = $content -replace 'tel\:8884567890', 'tel:123'
        
        [System.IO.File]::WriteAllText((Resolve-Path $file).Path, $content)
        Write-Host "Updated $file"
    }
}
