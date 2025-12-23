#Requires AutoHotkey v2.0

; Clicking the PHYSICAL LEFT button swaps them
; (Physical Left now acts like a Right-Click)
~LButton:: {
    DllCall("user32.dll\SwapMouseButton", "Int", 1)
}

; Clicking the PHYSICAL RIGHT button restores them
; (Physical Left returns to acting like a Left-Click)
~RButton:: {
    DllCall("user32.dll\SwapMouseButton", "Int", 0)
}

; Press Escape to exit the script and reset
Esc:: {
    DllCall("user32.dll\SwapMouseButton", "Int", 0)
    ExitApp()
}
