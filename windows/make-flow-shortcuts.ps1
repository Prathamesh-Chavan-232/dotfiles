# Drops "WM Start / WM Stop / WM Pause" .lnk shortcuts into the user Start Menu
# Programs folder. Flow Launcher's Program plugin indexes that folder by default,
# so the shortcuts surface when the user types "wm" in the launcher.
$ErrorActionPreference = 'Stop'

$StartMenu  = Join-Path $env:APPDATA 'Microsoft\Windows\Start Menu\Programs'
$ScriptsDir = Join-Path $env:USERPROFILE '.glzr\scripts'
$Pwsh       = "$env:WINDIR\System32\WindowsPowerShell\v1.0\powershell.exe"
$Icon       = "$env:ProgramFiles\komorebi\bin\komorebic.exe,0"
if (-not (Test-Path ($Icon -split ',')[0])) {
    $Icon = "$env:WINDIR\System32\imageres.dll,109"
}

$Wsh = New-Object -ComObject WScript.Shell

function New-Lnk($name, $script, $desc) {
    $lnk = Join-Path $StartMenu "$name.lnk"
    $sc  = $Wsh.CreateShortcut($lnk)
    $sc.TargetPath       = $Pwsh
    $sc.Arguments        = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$ScriptsDir\$script`""
    $sc.WorkingDirectory = $ScriptsDir
    $sc.IconLocation     = $Icon
    $sc.Description      = $desc
    $sc.Save()
    Write-Host "Created: $lnk"
}

New-Lnk 'WM Start' 'start-wm.ps1' 'Start komorebi + whkd + Flow Launcher; auto-hide taskbar'
New-Lnk 'WM Stop'  'stop-wm.ps1'  'Stop komorebi + whkd; restore taskbar (gaming mode)'
New-Lnk 'WM Pause' 'pause-wm.ps1' 'Toggle komorebi pause (tiling on/off without quitting)'
