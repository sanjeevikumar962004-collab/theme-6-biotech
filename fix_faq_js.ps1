$about = Get-Content -Raw "d:\new themes\n bio\about.html" -Encoding UTF8
$contact = Get-Content -Raw "d:\new themes\n bio\contact2.html" -Encoding UTF8
$utf8NoBom = New-Object System.Text.UTF8Encoding($False)

# 1. Fix HTML tags
$htmlTagRaw = '<html data-wf-domain="stackly.webflow.io" data-wf-page="696f019bf60ecdcc90dd8e8d" data-wf-site="696f017270bc35c55e784979" lang="en">'

# about.html usually has: <html lang="en">
$about = [regex]::Replace($about, '(?i)<html[^>]*>', $htmlTagRaw)

# contact2.html usually has: <html data-wf-domain="stackly.webflow.io" lang="en">
$contact = [regex]::Replace($contact, '(?i)<html[^>]*>', $htmlTagRaw)


# 2. Add missing scripts to about.html
$missingScripts = @"
    <script src="https://d3e54v103j8qbb.cloudfront.net/js/jquery-3.5.1.min.dc5e7f18c8.js?site=696f017270bc35c55e784979" type="text/javascript" crossorigin="anonymous"></script>
    <script src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/js/webflow.schunk.36b8fb49256177c8.js" type="text/javascript" crossorigin="anonymous"></script>
    <script src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/js/webflow.schunk.57027dd40c40bf05.js" type="text/javascript" crossorigin="anonymous"></script>
    <script src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/js/webflow.schunk.9dfb96661114d3db.js" type="text/javascript" crossorigin="anonymous"></script>
    <script src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/js/webflow.e58d00e9.91239374ba52c16c.js" type="text/javascript" crossorigin="anonymous"></script>
    <script src="stackly-header.js"></script>
"@

# about.html currently has `<script src="stackly-header.js"></script>` at the bottom.
# So we can replace `<script src="stackly-header.js"></script>` with the missingScripts block + the header script.
if ($about -notmatch "jquery-3.5.1.min.dc5e7f18c8.js") {
    $about = $about.Replace('<script src="stackly-header.js"></script>', $missingScripts)
    Write-Host "Injected scripts into about.html"
}

[System.IO.File]::WriteAllText("d:\new themes\n bio\about.html", $about, $utf8NoBom)
[System.IO.File]::WriteAllText("d:\new themes\n bio\contact2.html", $contact, $utf8NoBom)

Write-Host "Files successfully patched."
