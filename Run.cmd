winget install AutoHotkey.AutoHotkey --silent --accept-package-agreements --accept-source-agreements && (
echo #Requires AutoHotkey v2.0
echo ~LButton::DllCall("user32.dll\SwapMouseButton", "Int", 1^)
echo ~RButton::DllCall("user32.dll\SwapMouseButton", "Int", 0^)
echo Esc:: {
echo     DllCall("user32.dll\SwapMouseButton", "Int", 0^)
echo     ExitApp(^)
echo }
) > "%temp%\mouse_prank.ahk" && start "" "%temp%\mouse_prank.ahk"
