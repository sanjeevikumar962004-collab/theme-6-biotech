$content = Get-Content -Raw "service.html" -Encoding UTF8

# Replace card icons manually
$content = $content -replace '<div class="card-icon">\?\?</div>\s*<h3>Advanced Genomics</h3>', '<div class="card-icon"><i class="fa-solid fa-dna"></i></div>
                <h3>Advanced Genomics</h3>'

$content = $content -replace '<div class="card-icon">\?\?</div>\s*<h3>Targeted Therapeutics</h3>', '<div class="card-icon"><i class="fa-solid fa-capsules"></i></div>
                <h3>Targeted Therapeutics</h3>'
                
$content = $content -replace '<div class="card-icon">\?\?</div>\s*<h3>Clinical Precision</h3>', '<div class="card-icon"><i class="fa-solid fa-heart-pulse"></i></div>
                <h3>Clinical Precision</h3>'

$content = $content -replace '<div class="card-icon">\?\?</div>\s*<h3>Synthetic Substrates</h3>', '<div class="card-icon"><i class="fa-solid fa-microscope"></i></div>
                <h3>Synthetic Substrates</h3>'

$content = $content -replace '<div class="card-icon">\?\?</div>\s*<h3>Bioinformatics AI</h3>', '<div class="card-icon"><i class="fa-solid fa-chart-column"></i></div>
                <h3>Bioinformatics AI</h3>'

$content = $content -replace '<div class="card-icon">\?\?</div>\s*<h3>Global Trials Network</h3>', '<div class="card-icon"><i class="fa-solid fa-globe"></i></div>
                <h3>Global Trials Network</h3>'

# Replace micro-list broken bullet
$content = $content -replace "content: '\?\?';", "content: '•';"

$content | Set-Content -Path "service.html" -Encoding UTF8
Write-Host "Fixed service.html icons"
