$ErrorActionPreference = "Stop"

$faLink = "<link rel=""stylesheet"" href=""https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"">`n</head>"

$starHtml = "<div style=""display: flex; gap: 4px;""><i class=""fa-solid fa-star"" style=""color:#FBBF24; font-size:16px;""></i><i class=""fa-solid fa-star"" style=""color:#FBBF24; font-size:16px;""></i><i class=""fa-solid fa-star"" style=""color:#FBBF24; font-size:16px;""></i><i class=""fa-solid fa-star"" style=""color:#FBBF24; font-size:16px;""></i><i class=""fa-solid fa-star"" style=""color:#FBBF24; font-size:16px;""></i></div>"
$quoteHtml = "<i class=""fa-solid fa-quote-left"" style=""color:#00d2ff; font-size:28px; opacity: 0.8; margin-bottom:15px;""></i>"

$processIcons = @(
    "<i class=""fa-solid fa-flask-vial"" style=""color:#00d2ff; font-size:40px;""></i>",
    "<i class=""fa-solid fa-dna"" style=""color:#00d2ff; font-size:40px;""></i>",
    "<i class=""fa-solid fa-microscope"" style=""color:#00d2ff; font-size:40px;""></i>",
    "<i class=""fa-solid fa-network-wired"" style=""color:#00d2ff; font-size:40px;""></i>",
    "<i class=""fa-solid fa-vial-virus"" style=""color:#00d2ff; font-size:40px;""></i>",
    "<i class=""fa-solid fa-laptop-medical"" style=""color:#00d2ff; font-size:40px;""></i>"
)

foreach ($htmlFile in Get-ChildItem -Filter "*.html") {
    $content = Get-Content -Raw $htmlFile.FullName -Encoding UTF8
    
    # Inject FontAwesome if not present
    if (-not $content.Contains("font-awesome")) {
        $content = $content -replace "</head>", $faLink
    }
    
    # Replace Star Icon
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?i)<img[^>]*alt="Star"[^>]*>', $starHtml)
    
    # Replace Comma Icon
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?i)<img[^>]*alt="Comma Icon"[^>]*>', $quoteHtml)
    
    # Replace General "Icon" / "Icons"
    $idx = 0
    $evaluator = [System.Text.RegularExpressions.MatchEvaluator] {
        param([System.Text.RegularExpressions.Match]$match)
        $icon = $processIcons[$global:idx % $processIcons.Count]
        $global:idx++
        return $icon
    }
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '(?i)<img[^>]*alt="Icons?"[^>]*>', $evaluator)

    Set-Content -Path $htmlFile.FullName -Value $content -Encoding UTF8
    Write-Host "Injected icons into $($htmlFile.Name)"
}
Write-Host "Done setting up FontAwesome and restoring icons!"
