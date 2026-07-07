# Windows tiling-WM bootstrap (komorebi + whkd + Flow Launcher).
# Run from a normal PowerShell; accept the UAC prompts that pop up for
# komorebi / whkd installers.
#   pwsh -ExecutionPolicy Bypass -File windows\install.ps1

$ErrorActionPreference = 'Stop'

function Has-Winget { (Get-Command winget -ErrorAction SilentlyContinue) -ne $null }
if (-not (Has-Winget)) { throw "winget not found. Install App Installer from the Microsoft Store first." }

# Uninstall the previous-generation stack if present (idempotent on fresh boxes).
Write-Host "==> Uninstalling GlazeWM / Zebar (if installed)" -ForegroundColor DarkGray
winget uninstall --id glzr-io.glazewm --silent 2>$null | Out-Null

Write-Host "==> Installing komorebi (UAC prompt expected)" -ForegroundColor Cyan
winget install --id LGUG2Z.komorebi -e --silent --accept-source-agreements --accept-package-agreements

Write-Host "==> Installing whkd" -ForegroundColor Cyan
winget install --id LGUG2Z.whkd -e --silent --accept-source-agreements --accept-package-agreements

Write-Host "==> Installing Flow Launcher" -ForegroundColor Cyan
winget install --id Flow-Launcher.Flow-Launcher -e --silent --accept-source-agreements --accept-package-agreements

# --- Deploy configs ---
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$KomoSrc   = Join-Path $ScriptDir 'komorebi\komorebi.json'
$WhkdSrc   = Join-Path $ScriptDir 'komorebi\whkdrc'
$AppsSrc   = Join-Path $ScriptDir 'komorebi\applications.json'

$KomoDest  = Join-Path $env:USERPROFILE 'komorebi.json'
$WhkdDir   = Join-Path $env:USERPROFILE '.config'
$WhkdDest  = Join-Path $WhkdDir 'whkdrc'
$AppsDir   = Join-Path $env:USERPROFILE '.config\komorebi'
$AppsDest  = Join-Path $AppsDir 'applications.json'

New-Item -ItemType Directory -Force -Path $WhkdDir, $AppsDir | Out-Null

Write-Host "==> Writing $KomoDest" -ForegroundColor Cyan
Copy-Item -Force -Path $KomoSrc -Destination $KomoDest
Write-Host "==> Writing $WhkdDest" -ForegroundColor Cyan
Copy-Item -Force -Path $WhkdSrc -Destination $WhkdDest
Write-Host "==> Writing $AppsDest" -ForegroundColor Cyan
Copy-Item -Force -Path $AppsSrc -Destination $AppsDest

# --- Stage helper scripts + Flow Launcher shortcuts ---
$ScriptsDir = Join-Path $env:USERPROFILE '.glzr\scripts'   # path kept for back-compat
New-Item -ItemType Directory -Force -Path $ScriptsDir | Out-Null
Copy-Item -Force -Path (Join-Path $ScriptDir 'start-wm.ps1') -Destination $ScriptsDir
Copy-Item -Force -Path (Join-Path $ScriptDir 'stop-wm.ps1')  -Destination $ScriptsDir
Copy-Item -Force -Path (Join-Path $ScriptDir 'pause-wm.ps1') -Destination $ScriptsDir
& (Join-Path $ScriptDir 'make-flow-shortcuts.ps1')

# --- Replace GlazeWM startup shortcut with Komorebi.lnk ---
$StartupDir = [Environment]::GetFolderPath('Startup')
Remove-Item (Join-Path $StartupDir 'GlazeWM.lnk') -ErrorAction SilentlyContinue

$KomoExe = @(
    "$env:ProgramFiles\komorebi\bin\komorebic.exe",
    "${env:ProgramFiles(x86)}\komorebi\bin\komorebic.exe",
    "$env:LOCALAPPDATA\Programs\komorebi\bin\komorebic.exe"
) | Where-Object { Test-Path $_ } | Select-Object -First 1

if ($KomoExe) {
    $StartupLnk = Join-Path $StartupDir 'Komorebi.lnk'
    $Wsh = New-Object -ComObject WScript.Shell
    $Sc  = $Wsh.CreateShortcut($StartupLnk)
    $Sc.TargetPath = $KomoExe
    $Sc.Arguments  = 'start --whkd'
    $Sc.Save()
    Write-Host "==> Startup shortcut: $StartupLnk" -ForegroundColor Cyan
} else {
    Write-Warning "komorebic.exe not located; skipping startup shortcut."
}

# --- Launch now ---
if ((Get-Process komorebi -ErrorAction SilentlyContinue)) {
    Write-Host "==> komorebi already running; reloading configuration" -ForegroundColor Cyan
    & komorebic.exe reload-configuration
} elseif ($KomoExe) {
    Write-Host "==> Starting komorebi + whkd" -ForegroundColor Cyan
    Start-Process -FilePath $KomoExe -ArgumentList 'start','--whkd' -WindowStyle Hidden
}

Write-Host ""
Write-Host "Done. Win+D → launcher, Win+Enter → terminal, Win+1..9 → workspaces." -ForegroundColor Green
