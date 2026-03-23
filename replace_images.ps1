$ErrorActionPreference = "Stop"

$content = Get-Content -Path "index.html" -Raw

$stockImages = Get-ChildItem -Path "images" -Filter "pexels-*.webp" | Select-Object -ExpandProperty Name | Sort-Object
$stockImages = $stockImages | ForEach-Object { "images/$_" }

# Replace the hero BANNER
$content = $content -replace "https://cdn\.prod\.website-files\.com/[^\s""'<>]+?_BANNER\.avif", "images/hero 1.webp"

# We must use regex replace with a evaluator to loop through images
$pattern = 'https://cdn\.prod\.website-files\.com/[^\s""''<>)]+\.(jpg|jpeg|png|webp|avif)'

$global:idx = 0
$evaluator = [System.Text.RegularExpressions.MatchEvaluator] {
    param([System.Text.RegularExpressions.Match]$match)
    $url = $match.Value
    if ($url -match '(?i)\.(svg|mp4|webm)$') {
        return $url
    }
    $replacement = $stockImages[$global:idx % $stockImages.Count]
    $global:idx++
    return $replacement
}

$regex = [System.Text.RegularExpressions.Regex]::new($pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
$content = $regex.Replace($content, $evaluator)

Set-Content -Path "index.html" -Value $content -Encoding UTF8
Write-Output "Replaced $global:idx remote images with local ones."
