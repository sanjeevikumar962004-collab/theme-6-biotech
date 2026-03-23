$utf8NoBom = New-Object System.Text.UTF8Encoding($False)
$dashPath = "d:\new themes\n bio\dashboard.html"
$admPath = "d:\new themes\n bio\admin.html"
$loginPath = "d:\new themes\n bio\login.html"

# 1. Update login.html "Sign Up" text
$login = Get-Content -Raw $loginPath -Encoding UTF8
$login = $login.Replace('>Request Access<', '>Sign Up<')
[System.IO.File]::WriteAllText($loginPath, $login, $utf8NoBom)

# 2. Add Profile Chip to Dashboards
$dash = Get-Content -Raw $dashPath -Encoding UTF8
$adm = Get-Content -Raw $admPath -Encoding UTF8

# Remove old inserted span
$dash = [regex]::Replace($dash, '(?i)<span id="navUserEmail"[^>]*></span>', '')
$adm = [regex]::Replace($adm, '(?i)<span id="navUserEmail"[^>]*></span>', '')

$profileCss = @"
.profile-chip {
  display: flex; align-items: center; gap: 10px; padding: 6px 12px 6px 6px;
  background: transparent; border-radius: 12px; cursor: pointer; border: 1px solid transparent; transition: all 0.2s; margin-left:8px;
}
.profile-chip:hover { background: #f4f4f5; border-color: var(--border-active); }
.pc-icon {
  width: 34px; height: 34px; border-radius: 8px; background: #e0e7ff; color: #4f46e5;
  display: flex; align-items: center; justify-content: center;
}
.pc-icon svg { width: 18px; height: 18px; stroke-width: 2; }
.pc-text { display: flex; flex-direction: column; text-align: left; }
.pc-name { font-weight: 700; font-size: 13px; color: var(--text-main); line-height:1.2; }
.pc-email { font-weight: 500; font-size: 11px; color: var(--text-dim); }
.pc-chevron { width: 14px; height: 14px; color: var(--text-dim); margin-left: 4px; }
"@

$profileHtml = @"
        <div class="profile-chip">
          <div class="pc-icon">
            <svg fill="none" viewBox="0 0 24 24" stroke="currentColor"><path d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path></svg>
          </div>
          <div class="pc-text">
            <div class="pc-name" id="profileName">Researcher</div>
            <div class="pc-email" id="headerProfileEmail">user@stackly.io</div>
          </div>
          <svg class="pc-chevron" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
        </div>
"@

# Inject CSS
if ($dash -notmatch "\.profile-chip \{") {
    $dash = [regex]::Replace($dash, '(?i)</style>', "$profileCss`r`n</style>")
}
if ($adm -notmatch "\.profile-chip \{") {
    $adm = [regex]::Replace($adm, '(?i)</style>', "$profileCss`r`n</style>")
}

# Inject HTML
if ($dash -notmatch "profile-chip") {
    $dash = [regex]::Replace($dash, '(?i)</button>\s*</div>\s*</header>', ("</button>`r`n$profileHtml`r`n</div>`r`n</header>"))
}
if ($adm -notmatch "profile-chip") {
    $adm = [regex]::Replace($adm, '(?i)</button>\s*</div>\s*</header>', ("</button>`r`n$profileHtml`r`n</div>`r`n</header>"))
}

# Update script logic
$newScript = @"
<script>
  (function(){
    const emailStr = localStorage.getItem('stacklyUserEmail');
    if(emailStr && document.getElementById('headerProfileEmail')) {
      document.getElementById('headerProfileEmail').innerText = emailStr;
      
      // Attempt to extract name from email
      if(emailStr.includes('@')) {
        let namePart = emailStr.split('@')[0];
        namePart = namePart.replace(/[._]/g, ' ');
        // capitalize
        namePart = namePart.replace(/\b\w/g, l => l.toUpperCase());
        document.getElementById('profileName').innerText = namePart;
      }
    }
  })();
</script>
"@

$dash = [regex]::Replace($dash, '(?s)<script>\s*\(function\(\)\{\s*const emailStr = localStorage\.getItem[^<]*?</script>', $newScript)
$adm = [regex]::Replace($adm, '(?s)<script>\s*\(function\(\)\{\s*const emailStr = localStorage\.getItem[^<]*?</script>', $newScript)

[System.IO.File]::WriteAllText($dashPath, $dash, $utf8NoBom)
[System.IO.File]::WriteAllText($admPath, $adm, $utf8NoBom)

Write-Host "Top-right profile chip successfully generated on dashboards."
