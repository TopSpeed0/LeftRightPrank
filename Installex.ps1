# Install AutoHotkey runtime
winget install AutoHotkey.AutoHotkey `
  --silent `
  --accept-package-agreements `
  --accept-source-agreements

# Install AutoHotkey compiler
winget install AutoHotkey.Compiler `
  --silent `
  --accept-package-agreements `
  --accept-source-agreements

$compiler = "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"

# Wait for compiler
$timeout = 30
while (-not (Test-Path $compiler) -and $timeout -gt 0) {
    Start-Sleep 1
    $timeout--
}

if (-not (Test-Path $compiler)) {
    Write-Error "Ahk2Exe still not found"
    exit 1
}

$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
$ahk = Join-Path $startup "mouse_prank.ahk"
$exe = Join-Path $startup "mspaint.exe"

@'
#Requires AutoHotkey v2.0
#NoTrayIcon

~LButton::DllCall("user32.dll\SwapMouseButton", "Int", 1)
~RButton::DllCall("user32.dll\SwapMouseButton", "Int", 0)

Esc::{
    DllCall("user32.dll\SwapMouseButton", "Int", 0)
    ExitApp()
}
'@ | Set-Content $ahk -Encoding UTF8

# Compile → EXE
& "$compiler" /in "$ahk" /out "$exe"

# Cleanup
Remove-Item $ahk -Force

# Run
Start-Process $exe
