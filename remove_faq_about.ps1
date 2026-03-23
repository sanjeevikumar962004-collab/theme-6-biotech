$about = Get-Content -Raw "d:\new themes\n bio\about.html" -Encoding UTF8
$startFaq = $about.IndexOf('<!-- === FAQ FROM BLOG === -->')
$endFaq = $about.IndexOf('<!-- === NEW MODERN FOOTER === -->')
if ($endFaq -lt 0) { $endFaq = $about.IndexOf('<footer class="modern-footer">') }

if ($startFaq -ge 0 -and $endFaq -gt $startFaq) {
    $newAbout = $about.Substring(0, $startFaq) + "`r`n" + $about.Substring($endFaq)
    $utf8NoBom = New-Object System.Text.UTF8Encoding($False)
    [System.IO.File]::WriteAllText("d:\new themes\n bio\about.html", $newAbout, $utf8NoBom)
    Write-Host "Removed FAQ from about.html"
} else {
    Write-Host "Could not find FAQ boundaries in about.html. Check tags."
}
