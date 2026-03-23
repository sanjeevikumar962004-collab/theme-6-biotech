$files = Get-ChildItem -Path "d:\new themes\n bio\" -Filter "*.html"

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
    'ðŸ”¬' = '🔬'
    'ðŸ’Š' = '💊'
    'ðŸ§¬' = '🧬'
    'ðŸ ¥' = '🏥'
    'ðŸ¤ ' = '🤝'
    'ðŸŒ ' = '🌍'
    'â™»ï¸ ' = '♻️'
    'âš¡' = '⚡'
    'ðŸ †' = '🏆'
    'ðŸ§ª' = '🧫'
    'âœ…' = '✅'
    'ðŸŽ“' = '🎓'
    'ðŸ’¡' = '💡'
}

foreach ($file in $files) {
    # Read as UTF8
    $content = Get-Content -Raw $file.FullName -Encoding UTF8
    $changed = $false

    foreach ($key in $replacements.Keys) {
        if ($content.Contains($key)) {
            $content = $content.Replace($key, $replacements[$key])
            $changed = $true
        }
    }

    if ($changed) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        Write-Host "Fixed encodings in $($file.Name)"
    }
}
Write-Host "Done."
