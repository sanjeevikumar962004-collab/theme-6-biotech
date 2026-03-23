$ErrorActionPreference = "Stop"

$replacements = @{
    'â€“' = '–'
    'â€º' = '›'
    'â€”' = '—'
    'â†’' = '→'
    'â„¢' = '™'
    'Ã—' = '×'
    'Â·' = '·'
    'â€™' = "'"
    'â€˜' = "'"
    'â€œ' = '"'
    'â€ ' = '"'
}

foreach ($htmlFile in Get-ChildItem -Filter "*.html") {
    $content = Get-Content -Raw $htmlFile.FullName -Encoding UTF8
    $changed = $false

    foreach ($key in $replacements.Keys) {
        if ($content.Contains($key)) {
            $content = $content.Replace($key, $replacements[$key])
            $changed = $true
        }
    }

    if ($changed) {
        # Using [IO.File]::WriteAllText to guarantee UTF-8 NO BOM which is standard for web.
        [System.IO.File]::WriteAllText($htmlFile.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Fixed ANSI in $($htmlFile.Name)"
    }
}
Write-Host "Done ANSI fixes."
