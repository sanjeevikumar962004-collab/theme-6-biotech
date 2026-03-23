$path = "d:\new themes\n bio\dashboard.html"
$content = Get-Content $path -Raw
$content = $content -replace "<h1>Research Control Center</h1>\s*<p>Biotech Division.*?Stackly HQ</p>", '<h1>Research Control Center</h1>
          <p id="userEmailDisplay">Biotech Division &middot; Stackly HQ</p>'

$script = @'
// Set User Email
(function(){
  const userEmail = localStorage.getItem('stacklyUserEmail');
  if(userEmail) {
    const el = document.getElementById('userEmailDisplay');
    if(el) el.innerHTML = `Signed in as <strong style="color:var(--text-main)">${userEmail}</strong> &middot; Stackly HQ`;
  }
})();
</script>
</body>
</html>
'@

$content = $content -replace "\s*\}\)\(\);\s*</script>\s*</body>\s*</html>", "`n  });`n})();`n$script"

Set-Content -Path $path -Value $content -Encoding UTF8

$path2 = "d:\new themes\n bio\admin.html"
$content2 = Get-Content $path2 -Raw
$content2 = $content2 -replace "<h1>Infrastructure Control <span class=`"hd-badge`">Admin</span></h1>\s*<p>sys\.stackly\.io.*?Core Region</p>", '<h1>Infrastructure Control <span class="hd-badge">Admin</span></h1>
          <p id="adminEmailDisplay">sys.stackly.io &middot; Core Region</p>'

$script2 = @'
// Set Admin Email
(function(){
  const userEmail = localStorage.getItem('stacklyUserEmail');
  if(userEmail) {
    const el = document.getElementById('adminEmailDisplay');
    if(el) el.innerHTML = `Admin <strong style="color:var(--text-main)">${userEmail}</strong> &middot; Core Region`;
  }
})();
</script>
</body>
</html>
'@

$content2 = $content2 -replace "\s*\}\)\(\);\s*</script>\s*</body>\s*</html>", "`n  });`n})();`n$script2"

Set-Content -Path $path2 -Value $content2 -Encoding UTF8
