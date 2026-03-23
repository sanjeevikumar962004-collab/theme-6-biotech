$ErrorActionPreference = "Stop"

$htmlFiles = Get-ChildItem -Filter "*.html"
foreach ($file in $htmlFiles) {
    $text = Get-Content -Raw $file.FullName -Encoding UTF8
    
    $reversions = 0
    # Keep reverting as long as it contains the typical broken UTF8 signature (like Ã¢)
    # and we haven't looped too much.
    while ($text -match 'Ã' -or $text -match 'â') {
        if ($reversions -ge 5) { break }
        
        try {
            # The current text is the C# string resulting from UTF8 reading.
            # Convert it back to ANSI bytes
            $ansiBytes = [System.Text.Encoding]::GetEncoding(1252).GetBytes($text)
            
            # Those bytes were originally proper UTF-8 bytes. Decode them.
            $newText = [System.Text.Encoding]::UTF8.GetString($ansiBytes)
            
            # Check if this helped (if it still has valid strings)
            $text = $newText
            $reversions++
        } catch {
            break
        }
    }
    
    if ($reversions -gt 0) {
        $text | Set-Content -Path $file.FullName -Encoding UTF8 -NoNewline
        Write-Host "Reverted $($file.Name) $reversions times."
    }
}
Write-Host "Done."
