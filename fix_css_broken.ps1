$path = "d:\new themes\n bio\dashboard.html"
$c = Get-Content $path -Raw
$broken = @"
  .bento{
    grid-column:1 / -1 !important;
    border-radius:16px;padding:20px;
}
.profile-chip:hover { background: #f4f4f5; border-color: var(--border-active); }
"@

$fixed = @"
  .bento{
    grid-column:1 / -1 !important;
    border-radius:16px;padding:20px;
  }
  .block-hero{padding:24px}
  .hero-content h2{font-size:22px}
  .kpi-val{font-size:28px}
  
  .block-table{overflow-x:auto}
  .tb-modern{min-width:500px}
}
.profile-chip {
  display: flex; align-items: center; gap: 10px; padding: 6px 12px 6px 6px;
  background: transparent; border-radius: 12px; cursor: pointer; border: 1px solid transparent; transition: all 0.2s; margin-left:8px;
}
.profile-chip:hover { background: #f4f4f5; border-color: var(--border-active); }
"@

$c = $c.Replace($broken, $fixed)
[System.IO.File]::WriteAllText($path, $c, [System.Text.Encoding]::UTF8)
Write-Host "Restored CSS in dashboard.html"
