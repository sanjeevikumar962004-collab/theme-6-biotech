$files = @("index.html", "about.html", "blog.html", "contact2.html")

$old_header = @"
    <!-- ═══ HEADER (RESTORED) ═══ -->
    <div data-wf--rt-navbar-v2--variant="home-two" data-animation="default" data-collapse="medium" data-duration="400"
        data-easing="ease" data-easing2="ease" role="banner"
        class="rt-navbar-v2 w-variant-dc66bbc0-e9e8-4e3d-2de0-76f535d749e7 w-nav">
        <div class="rt-navbar-shadow"></div>
        <div class="rt-container-extra-large rt-position-relative w-container">
            <div class="w-layout-hflex rt-navbar-wrapper">
                <div class="w-layout-hflex rt-brand-logo-wrapper">
                    <a href="index.html" class="rt-brand w-nav-brand">
                        <img src="images/whitelogo.webp" alt="Stackly Logo" style="height: 18px; width: auto;" class="rt-brand-logo" />
                    </a>
                </div>
                <nav role="navigation" class="rt-nav-menu-v2 w-nav-menu">
                    <div class="w-layout-vflex rt-nav-link-main">
                        <div class="w-layout-hflex rt-nav-link-wrapper">
                            <div class="w-layout-hflex rt-nav-link">
                                <div data-delay="0" data-hover="true" data-w-id="afe2f1da-482a-96b7-6275-c2c9d55392d4"
                                    class="rt-drop-down w-dropdown">
                                    <div class="rt-drop-drown-toggle w-dropdown-toggle">
                                        <div class="rt-nav-link-text-v2">Home</div>
                                        <div class="w-layout-vflex rt-drop-down-arrow-icon">
                                            <img width="8" height="5" alt="Dropdown arrow White"
                                                src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/698033509f29c66f642d4ff4_Vector%20(40).svg"
                                                loading="lazy" />
                                        </div>
                                    </div>
                                    <nav class="rt-navigation-v2 w-dropdown-list">
                                        <a href="index.html" class="rt-drop-dwon-nav-link-v2 w-dropdown-link">Home one</a>
                                        <a href="/home-two" aria-current="page"
                                            class="rt-drop-dwon-nav-link-v2 w-dropdown-link w--current">Home two</a>
                                    </nav>
                                </div>
                            </div>
                            <div class="w-layout-hflex rt-nav-link">
                                <a href="about.html" class="rt-nav-link-text-v2 w-nav-link">About</a>
                            </div>
                            <div class="w-layout-hflex rt-nav-link">
                                <div data-delay="0" data-hover="true" data-w-id="afe2f1da-482a-96b7-6275-c2c9d55392e5"
                                    class="rt-drop-down w-dropdown">
                                    <div class="rt-drop-drown-toggle rt-drop-down-bottom-gap-down w-dropdown-toggle">
                                        <div class="rt-nav-link-text-v2">Pages</div>
                                        <div class="w-layout-vflex rt-drop-down-arrow-icon">
                                            <img width="8" height="5" alt="Dropdown arrow White"
                                                src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/698033509f29c66f642d4ff4_Vector%20(40).svg"
                                                loading="lazy" />
                                        </div>
                                    </div>
                                    <nav class="rt-navigation-v2 rt-drop-down-margin-off w-dropdown-list">
                                        <a href="dashboard.html" class="rt-drop-dwon-nav-link-v2 w-dropdown-link">Dashboard</a>
                                        <a href="admin.html" class="rt-drop-dwon-nav-link-v2 w-dropdown-link">Admin</a>
                                    </nav>
                                </div>
                            </div>
                            <div class="w-layout-hflex rt-nav-link">
                                <div data-delay="0" data-hover="true" data-w-id="afe2f1da-482a-96b7-6275-c2c9d55392f3"
                                    class="rt-drop-down w-dropdown">
                                    <div class="rt-drop-drown-toggle w-dropdown-toggle">
                                        <div class="rt-nav-link-text-v2">Blog</div>
                                        <div class="w-layout-vflex rt-drop-down-arrow-icon">
                                            <img width="8" height="5" alt="Dropdown arrow White"
                                                src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/698033509f29c66f642d4ff4_Vector%20(40).svg"
                                                loading="lazy" />
                                        </div>
                                    </div>
                                    <nav class="rt-navigation-v2 w-dropdown-list">
                                        <a href="blog.html" class="rt-drop-dwon-nav-link-v2 w-dropdown-link">Blog Grid</a>
                                    </nav>
                                </div>
                            </div>
                            <div class="w-layout-hflex rt-nav-link rt-nav-link-last-gap">
                                <a href="contact2.html" class="rt-nav-link-text-v2 w-nav-link">Contact</a>
                            </div>
                        </div>
                        <div data-w-id="afe2f1da-482a-96b7-6275-c2c9d5539303" class="w-layout-hflex rt-phone">
                            <div class="w-layout-vflex rt-phone-icon-wrapper rt-margin">
                                <img width="18" height="18" alt="Telephone Icon White"
                                    src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/6980340040def08f5fd4e476_Vector%20(41).svg"
                                    loading="lazy" class="rt-phone-icon" />
                            </div>
                            <div class="w-layout-vflex rt-phone-number-wrapper">
                                <a href="tel:8884567890" class="rt-link-decor-off w-inline-block">
                                    <div class="rt-button-text-style rt-text-color-white rt-font-weight-semi-bold rt-number-hover w-variant-dc66bbc0-e9e8-4e3d-2de0-76f535d749e7">
                                        (888) 123 4560</div>
                                </a>
                            </div>
                        </div>
                        <div class="w-layout-vflex rt-menu-tab-botom-content">
                            <div class="w-layout-hflex rt-bottom-button-wrapper">
                                <div class="w-layout-vflex rt-bottom-inner-wrapper">
                                    <a data-wf--rt-button--variant="base"
                                        href="contact2.html"
                                        class="rt-button rt-overflow-hidden w-inline-block">
                                        <div class="w-layout-hflex rt-text-button-wrapper rt-button-text">
                                            <div class="rt-text-color-white rt-1">Schedule appointment</div>
                                            <div class="rt-text-color-white rt-change-text rt-2">Schedule appointment</div>
                                        </div>
                                        <div class="rt-button-overlay"></div>
                                    </a>
                                </div>
                            </div>
                            <div class="w-layout-vflex rt-nav-bottom-content">
                                <div class="w-layout-hflex rt-nav-botton-social-icon-wrapper">
                                    <a href="https://facebook.com" target="_blank" class="rt-social-icon w-inline-block">
                                        <div class="w-layout-hflex rt-nav-social-icon">
                                            <img width="11" height="16" alt="" src="https://cdn.prod.website-files.com/696f017270bc35c55e784979/6985adfaaef9ef7e15b10623_6936a9fdfd2db0b87d8552bd_FB%20logo.svg" loading="lazy" />
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </nav>
                <div id="w-node-afe2f1da-482a-96b7-6275-c2c9d5539309-d55392cb"
                    class="w-layout-hflex rt-navbar-button-v2">
                    <div class="rt-tab-display-off rt-nav-button-wrapper rt-overflow-hidden">
                        <div class="w-layout-vflex rt-button-wrapper-nav">
                            <a data-wf--rt-button-v2--variant="buttuon-background-white" href="contact2.html" class="rt-button-v5 w-variant-e593684a-dc2b-c21b-f96e-fdd3c673092a w-inline-block">
                                <div class="w-layout-hflex rt-text-button-wrapper rt-button-text">
                                    <div class="rt-body-font-color rt-1">Appointment</div>
                                    <div class="rt-body-font-color rt-change-text rt-2">Appointment</div>
                                </div>
                                <div class="rt-button-overlay"></div>
                            </a>
                        </div>
                        <div class="w-layout-vflex rt-nav-button-wrapper-v2">
                            <a data-wf--rt-button--variant="base" href="contact2.html" class="rt-button rt-overflow-hidden w-inline-block">
                                <div class="w-layout-hflex rt-text-button-wrapper rt-button-text">
                                    <div class="rt-text-color-white rt-1">Appointment</div>
                                    <div class="rt-text-color-white rt-change-text rt-2">Appointment</div>
                                </div>
                                <div class="rt-button-overlay"></div>
                            </a>
                        </div>
                    </div>
                    <div data-w-id="afe2f1da-482a-96b7-6275-c2c9d553930c" class="rt-mobile-list-botton w-nav-button">
                        <div class="w-layout-vflex rt-nav-open-mobile-button">
                            <div class="rt-hamburger-line-v2"></div>
                            <div class="rt-hamburger-line-v2 rt-2"></div>
                            <div class="rt-hamburger-line-v2 rt-line-three"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
"@

foreach ($file in $files) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText((Resolve-Path $file).Path)
        $content = $content -replace '(?s)<header class="stackly-header">.*?</header>', $old_header
        [System.IO.File]::WriteAllText((Resolve-Path $file).Path, $content)
        Write-Host "Updated $file"
    }
}
