$utf8NoBom = New-Object System.Text.UTF8Encoding($False)
$dir = "d:\new themes\n bio"

# 1. Update login.html "Sign Up" placement
$loginPath = "$dir\login.html"
$login = Get-Content -Raw $loginPath -Encoding UTF8

# Remove the old signup link from header
$login = [regex]::Replace($login, '(?s)<a href="signup\.html" class="signup-link">.*?</a>', '')

# Remove the old auth-footer (the bottom "Sign up")
$login = [regex]::Replace($login, '(?s)<div class="auth-footer" data-aos="fade-up" data-aos-delay="400">.*?</div>', '')

# Replace forgot link with a stacked forgot & signup block
$newLinksBlock = @"
<div style="text-align: right; margin-top: -12px; margin-bottom: 32px; display: flex; flex-direction: column; gap: 8px; align-items: flex-end;">
                <a href="forgot.html" class="forgot-link" style="margin:0;">Forgot password?</a>
                <a href="signup.html" class="forgot-link" style="margin:0;">Sign Up</a>
            </div>
"@

$login = [regex]::Replace($login, '<a href="forgot\.html" class="forgot-link">Forgot password\?</a\>', $newLinksBlock)

[System.IO.File]::WriteAllText($loginPath, $login, $utf8NoBom)


# 2. Update forgot.html routing logic
$forgotPath = "$dir\forgot.html"
$forgot = Get-Content -Raw $forgotPath -Encoding UTF8
$forgot = $forgot.Replace("form.style.display = 'none';", "window.location.href = '404.html';")
$forgot = $forgot.Replace("box.style.display = 'flex';", "")
[System.IO.File]::WriteAllText($forgotPath, $forgot, $utf8NoBom)


# 3. Update all unlinked buttons (href="#") across the entire directory
$htmlFiles = Get-ChildItem -Path $dir -Filter "*.html"
foreach ($file in $htmlFiles) {
    if ($file.Name -ne "404.html") {
        $content = Get-Content -Raw $file.FullName -Encoding UTF8
        
        # We need to target href="#"
        if ($content -match 'href="#"') {
            $content = $content -replace 'href="#"', 'href="404.html"'
            [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
            Write-Host "Updated links in: $($file.Name)"
        }
    }
}

Write-Host "Auth modifications and 404 routings complete."
