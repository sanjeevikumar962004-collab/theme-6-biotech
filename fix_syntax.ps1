$dash = "d:\new themes\n bio\dashboard.html"
$c = Get-Content $dash -Raw
$c = $c -replace '\}\);\s*\}\);\s*\}\)\(\);', '});`n})();'
[System.IO.File]::WriteAllText($dash, $c, [System.Text.Encoding]::UTF8)

$adm = "d:\new themes\n bio\admin.html"
$c2 = Get-Content $adm -Raw
$c2 = $c2 -replace '\}\);\s*\}\);\s*\}\)\(\);', '});`n})();'
[System.IO.File]::WriteAllText($adm, $c2, [System.Text.Encoding]::UTF8)

Write-Host "Replaced successfully"
