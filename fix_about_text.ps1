$path = "d:\new themes\n bio\about.html"
$content = Get-Content $path -Raw

# Replace CSS
$cssOld = ".tl::before{left:24px}`n  .tl-row{grid-template-columns:1fr;gap:0}"
$cssNew = ".tl::before{left:26px}`n  .tl-row{grid-template-columns:1fr;gap:0;position:relative;}`n  .tl-box{margin-left:72px;margin-bottom:20px;}`n  .tl-row > div:last-child {display:none;}"
$content = $content.Replace($cssOld, $cssNew)

$cssOld2 = ".tl-dot-col{justify-content:flex-start;padding-left:0;margin-bottom:14px;grid-row:1}"
$cssNew2 = ".tl-dot-col{justify-content:flex-start;padding-left:0;margin-bottom:14px;grid-row:1;position:absolute;left:0;top:-10px;}"
$content = $content.Replace($cssOld2, $cssNew2)

# Replace Texts
$content = $content.Replace("Pioneering the Future of<br/><em>Life-Changing Science</em>", "About<br/><em>Stackly Biotech</em>")
$content = $content.Replace("A team of visionary scientists, clinicians and innovators transforming healthcare through genomics, drug discovery and precision medicine.", "We are a team of scientists and innovators dedicated to transforming healthcare through advanced research and precision medicine.")
$content = $content.Replace("Advancing life sciences for a healthier world", "Advancing healthcare")
$content = $content.Replace("At Stackly, we believe the next generation of medicine starts at the molecular level. We accelerate biological discovery, develop life-saving therapeutics, and deliver precision solutions that transform patient outcomes.", "We accelerate biological discovery and develop precision solutions that transform patient outcomes for a better tomorrow.")
$content = $content.Replace("A world where every disease has a molecular answer", "Precision answers for every disease")
$content = $content.Replace("We envision a future where personalised medicine is the standard of care. Through genomic insights and AI-driven analysis, we aim to match the right therapy to the right patient at exactly the right time.", "We envision a future where personalised medicine is the standard of care. We aim to match the right therapy to the right patient at exactly the right time.")

Set-Content -Path $path -Value $content -Encoding UTF8
