$path = "d:\new themes\n bio\dashboard.html"
$c = Get-Content $path -Raw
$c = $c.Replace("  });`r`n  });`r`n})();", "  });`r`n})();")
$c = $c.Replace("  });`n  });`n})();", "  });`n})();")
$c = $c.Replace("Â·", "&middot;")
$c = $c.Replace("ðŸ§¬", "🧬")
$c = $c.Replace("ðŸ’Š", "💊")
$c = $c.Replace("ðŸ”¬", "🔬")
$c = $c.Replace("ðŸ§ª", "🧫")
[System.IO.File]::WriteAllText($path, $c, [System.Text.Encoding]::UTF8)

$path2 = "d:\new themes\n bio\admin.html"
$c2 = Get-Content $path2 -Raw
$c2 = $c2.Replace("  });`r`n  });`r`n})();", "  });`r`n})();")
$c2 = $c2.Replace("  });`n  });`n})();", "  });`n})();")
$c2 = $c2.Replace("Â·", "&middot;")
$c2 = $c2.Replace("ðŸ§¬", "🧬")
$c2 = $c2.Replace("ðŸ’Š", "💊")
$c2 = $c2.Replace("ðŸ”¬", "🔬")
$c2 = $c2.Replace("ðŸ§ª", "🧫")
[System.IO.File]::WriteAllText($path2, $c2, [System.Text.Encoding]::UTF8)

Write-Host "Replaced successfully"
