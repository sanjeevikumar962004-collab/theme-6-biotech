$dash = "d:\new themes\n bio\dashboard.html"
$c = Get-Content $dash -Raw
$c = $c -replace '\}\);\s*\}\);\s*\}\)\(\);', '});`n})();'
$c = $c.Replace("Â·", "&middot;")
$c = $c.Replace("ðŸ§¬", "🧬")
$c = $c.Replace("ðŸ’Š", "💊")
$c = $c.Replace("ðŸ”¬", "🔬")
$c = $c.Replace("ðŸ§ª", "🧫")
[System.IO.File]::WriteAllText($dash, $c, [System.Text.Encoding]::UTF8)

$adm = "d:\new themes\n bio\admin.html"
$c2 = Get-Content $adm -Raw
$c2 = $c2 -replace '\}\);\s*\}\);\s*\}\)\(\);', '});`n})();'
$c2 = $c2.Replace("Â·", "&middot;")
$c2 = $c2.Replace("ðŸ§¬", "🧬")
$c2 = $c2.Replace("ðŸ’Š", "💊")
$c2 = $c2.Replace("ðŸ”¬", "🔬")
$c2 = $c2.Replace("ðŸ§ª", "🧫")
[System.IO.File]::WriteAllText($adm, $c2, [System.Text.Encoding]::UTF8)

Write-Host "Done!"
