$utf8NoBom = New-Object System.Text.UTF8Encoding($False)
$dir = "d:\new themes\n bio"

$signupPath = "$dir\signup.html"
$forgotPath = "$dir\forgot.html"

$signup = Get-Content -Raw $signupPath -Encoding UTF8
$forgot = Get-Content -Raw $forgotPath -Encoding UTF8

$roleCss = @"
        /* Role Toggle Segment */
        .role-toggle {
            display: flex; background: #f1f5f9; border-radius: 12px; padding: 6px; margin-bottom: 32px; position: relative;
        }
        .role-btn {
            flex: 1; text-align: center; padding: 12px 0; font-size: 14px; font-weight: 600; color: var(--text-dim);
            cursor: pointer; position: relative; z-index: 2; transition: color 0.3s;
        }
        .role-btn.active { color: var(--text-main); }
        .role-slider {
            position: absolute; top: 6px; left: 6px; height: calc(100% - 12px); width: calc(50% - 6px); background: #fff;
            border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); transition: transform 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94); z-index: 1;
        }
"@

$roleHtml = @"
        <div class="role-toggle" data-aos="fade-up" data-aos-delay="150">
            <div class="role-slider" id="roleSlider"></div>
            <div class="role-btn active" id="btnUser" onclick="selectRole('user')">Login as User</div>
            <div class="role-btn" id="btnAdmin" onclick="selectRole('admin')">Login as Admin</div>
        </div>
        <input type="hidden" id="authRole" value="user" />
"@

$roleJs = @"
    function selectRole(role) {
        document.getElementById('authRole').value = role;
        const slider = document.getElementById('roleSlider');
        const btnUser = document.getElementById('btnUser');
        const btnAdmin = document.getElementById('btnAdmin');
        if (role === 'admin') {
            slider.style.transform = 'translateX(100%)';
            btnUser.classList.remove('active');
            btnAdmin.classList.add('active');
        } else {
            slider.style.transform = 'translateX(0)';
            btnAdmin.classList.remove('active');
            btnUser.classList.add('active');
        }
    }
"@

# Inject CSS
if ($signup -notmatch "\.role-toggle \{") {
    $signup = $signup.Replace('/* Form Controls */', "$roleCss`n`n        /* Form Controls */")
}
if ($forgot -notmatch "\.role-toggle \{") {
    $forgot = $forgot.Replace('.form-group {', "$roleCss`n`n        .form-group {")
}

# Inject HTML
# in signup: under <div class="auth-header"...> ... </div>
if ($signup -notmatch "id=`"authRole`"") {
    $signup = [regex]::Replace($signup, '(?s)(<div class="auth-header"[^>]*>.*?</div>)', "`$1`n`n$roleHtml")
}
# in forgot: same
if ($forgot -notmatch "id=`"authRole`"") {
    $forgot = [regex]::Replace($forgot, '(?s)(<div class="auth-header"[^>]*>.*?</div>)', "`$1`n`n$roleHtml")
}

# Inject JS generic function
if ($signup -notmatch "function selectRole") {
    $signup = $signup.Replace('AOS.init({ duration: 800, once: true });', "AOS.init({ duration: 800, once: true });`n`n$roleJs")
}
if ($forgot -notmatch "function selectRole") {
    $forgot = $forgot.Replace('AOS.init({ duration: 800, once: true });', "AOS.init({ duration: 800, once: true });`n`n$roleJs")
}

# Modify signup logical routing
# From `window.location.href = 'dashboard.html';`
# To `const role = document.getElementById('authRole').value; window.location.href = role === 'admin' ? 'admin.html' : 'dashboard.html';`
$signupRedirect = @"
            const role = document.getElementById('authRole').value;
            window.location.href = role === 'admin' ? 'admin.html' : 'dashboard.html';
"@
$signup = [regex]::Replace($signup, "window\.location\.href\s*=\s*'dashboard\.html';", $signupRedirect)

# Modify forgot logical routing
# From `window.location.href = '404.html';`
# To the same routing
$forgotRedirect = @"
            const email = document.getElementById('txtEmail').value.trim();
            localStorage.setItem('stacklyUserEmail', email);
            const role = document.getElementById('authRole').value;
            window.location.href = role === 'admin' ? 'admin.html' : 'dashboard.html';
"@
$forgot = [regex]::Replace($forgot, "window\.location\.href\s*=\s*'404\.html';", $forgotRedirect)

[System.IO.File]::WriteAllText($signupPath, $signup, $utf8NoBom)
[System.IO.File]::WriteAllText($forgotPath, $forgot, $utf8NoBom)

Write-Host "Role functionality injected successfully into all auth pages."
