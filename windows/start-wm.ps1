# Boots komorebi + whkd, hides the Windows taskbar, ensures Flow Launcher runs.
# Uses full paths + augments PATH so it works even when launched from a process
# (e.g. Flow Launcher) that was started before komorebi/whkd were installed and
# therefore has a stale PATH.
$ErrorActionPreference = 'SilentlyContinue'

$KomoBin = 'C:\Program Files\komorebi\bin'
$WhkdBin = 'C:\Program Files\whkd\bin'
$Komorebic = Join-Path $KomoBin 'komorebic.exe'
$Whkd      = Join-Path $WhkdBin 'whkd.exe'

# Make sure child processes (and whkd's spawned commands) can find komorebic.
$env:PATH = "$KomoBin;$WhkdBin;$env:PATH"

# Start the window manager.
if (-not (Get-Process komorebi -ErrorAction SilentlyContinue)) {
    Start-Process -FilePath $Komorebic -ArgumentList 'start' -WindowStyle Hidden
    Start-Sleep -Seconds 3
}

# Start the hotkey daemon (inherits the augmented PATH above).
if (-not (Get-Process whkd -ErrorAction SilentlyContinue)) {
    Start-Process -FilePath $Whkd -WindowStyle Hidden
}

# Auto-hide the Windows taskbar (byte 8 of StuckRects3.Settings).
$Key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'
$Settings = (Get-ItemProperty -Path $Key -Name Settings).Settings
$Settings[8] = 0x02
Set-ItemProperty -Path $Key -Name Settings -Value $Settings
Stop-Process -Name explorer -Force

# Make sure Flow Launcher is up.
if (-not (Get-Process Flow.Launcher -ErrorAction SilentlyContinue)) {
    Start-Process -FilePath "$env:LOCALAPPDATA\FlowLauncher\Flow.Launcher.exe"
}

Start-Sleep -Seconds 2
Get-Process komorebi, whkd, Flow.Launcher -ErrorAction SilentlyContinue | Select Name, Id
