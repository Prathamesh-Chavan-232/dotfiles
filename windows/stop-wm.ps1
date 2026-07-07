# Gaming-mode kill switch: stops komorebi + whkd and restores the
# Windows taskbar to always-visible. Prefer Win+Shift+P (pause) when only
# a single game needs the WM out of the way.
$ErrorActionPreference = 'SilentlyContinue'

$Komorebic = 'C:\Program Files\komorebi\bin\komorebic.exe'

# Graceful komorebi shutdown, then make sure both daemons are gone.
& $Komorebic stop
Start-Sleep -Milliseconds 500
Get-Process komorebi, whkd, Flow.Launcher -ErrorAction SilentlyContinue | Stop-Process -Force

# Restore always-visible taskbar.
$Key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'
$Settings = (Get-ItemProperty -Path $Key -Name Settings).Settings
$Settings[8] = 0x03
Set-ItemProperty -Path $Key -Name Settings -Value $Settings
Stop-Process -Name explorer -Force

Write-Host "Window manager stopped, taskbar restored. Run start-wm.ps1 to bring it back." -ForegroundColor Yellow
