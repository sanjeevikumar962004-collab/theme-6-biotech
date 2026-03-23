$ErrorActionPreference = "Stop"

$stockImages = Get-ChildItem -Path "images" -Filter "pexels-*.webp" | Select-Object -ExpandProperty Name | Sort-Object
$stockImages = $stockImages | ForEach-Object { "images/$_" }

# Allow parentheses in URLs
$pattern = 'https://cdn\.prod\.website-files\.com/[^\s""''<>\?]+\.(jpg|jpeg|png|webp|avif|svg)'

foreach ($htmlFile in Get-ChildItem -Filter "*.html") {
    $content = Get-Content -Path $htmlFile.FullName -Raw

    # Replace the hero BANNER specifically if it exists
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, 'https://cdn\.prod\.website-files\.com/[^\s""''<>]+?_BANNER\.avif', 'images/hero 1.webp', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

    $global:idx = 0
    $evaluator = [System.Text.RegularExpressions.MatchEvaluator] {
        param([System.Text.RegularExpressions.Match]$match)
        $url = $match.Value
        if ($url -match '(?i)\.(mp4|webm)$') {
            return $url
        }
        $replacement = $stockImages[$global:idx % $stockImages.Count]
        $global:idx++
        return $replacement
    }

    $regex = [System.Text.RegularExpressions.Regex]::new($pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    $content = $regex.Replace($content, $evaluator)

    Set-Content -Path $htmlFile.FullName -Value $content -Encoding UTF8
    Write-Output "[$($htmlFile.Name)] Replaced $global:idx remote images."
}
