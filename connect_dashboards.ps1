$dashPath = "d:\new themes\n bio\dashboard.html"
$admPath = "d:\new themes\n bio\admin.html"

$dash = Get-Content -Raw $dashPath -Encoding UTF8
$adm = Get-Content -Raw $admPath -Encoding UTF8

$utf8NoBom = New-Object System.Text.UTF8Encoding($False)

# 1. Update dashboard.html header line & inject localstorage script
$dash = [regex]::Replace($dash, '(?i)<p>([^<]*Stackly\s?HQ[^<]*)</p>', '<p>$1<span id="navUserEmail" style="color:var(--p-blue);margin-left:12px;font-weight:700;"></span></p>')

$dashScript = @"
<script>
  (function(){
    const emailStr = localStorage.getItem('stacklyUserEmail');
    if(emailStr && document.getElementById('navUserEmail')) {
      document.getElementById('navUserEmail').innerText = '— ' + emailStr;
    }
  })();
</script>
</body>
"@
if ($dash -notmatch "navUserEmail") {
    $dash = $dash.Replace('</body>', $dashScript)
}

# 2. Update admin.html header line & inject localstorage script
$adm = [regex]::Replace($adm, '(?i)<p>([^<]*Core\s?Region[^<]*)</p>', '<p>$1<span id="navUserEmail" style="color:var(--p-teal);margin-left:12px;font-weight:700;"></span></p>')

$admScript = @"
<script>
  (function(){
    const emailStr = localStorage.getItem('stacklyUserEmail');
    if(emailStr && document.getElementById('navUserEmail')) {
      document.getElementById('navUserEmail').innerText = '— Session Bound: ' + emailStr;
    }
  })();
</script>
</body>
"@
if ($adm -notmatch "navUserEmail") {
    $adm = $adm.Replace('</body>', $admScript)
}

[System.IO.File]::WriteAllText($dashPath, $dash, $utf8NoBom)
[System.IO.File]::WriteAllText($admPath, $adm, $utf8NoBom)

Write-Host "Dashboards connected to Auth localstorage."
