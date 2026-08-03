#Requires AutoHotkey v2.0
#SingleInstance Force
#Include functions/lib.ahk

InstallKeybdHook

; ============================================================================
; Configuration
; ============================================================================

KEY_DOWN_DELAY := 250

global CapsButtonState := "UP"
global ArrowMode := false
global PressTime := 0

; ============================================================================
; Utility
; ============================================================================

SendArrow(key) {
    global ArrowMode

    ArrowMode := true
    Send (key)
}

; ============================================================================
; CapsLock
; ============================================================================

SC3A:: {
    global CapsButtonState, PressTime

    if (CapsButtonState != "UP")
        return

    CapsButtonState := "DOWN"
    PressTime := A_TickCount
}

SC3A Up:: {
    global CapsButtonState, ArrowMode, PressTime

    if (CapsButtonState != "DOWN")
        return

    CapsButtonState := "UP"

    if (ArrowMode) {
        ArrowMode := false
        return
    }

    if ((A_TickCount - PressTime) <= KEY_DOWN_DELAY)
        SetCapsLockState !GetKeyState("CapsLock", "T")
}

; ============================================================================
; Navigation Mode
; ============================================================================

#HotIf GetKeyState("SC3A", "P")

SC17:: SendArrow("{Up}")
SC25:: SendArrow("{Down}")
SC24:: SendArrow("{Left}")
SC26:: SendArrow("{Right}")

SC16:: SendArrow("{BackSpace}")
SC18:: SendArrow("{Del}")

SC23:: SendArrow("{Home}")
SC27:: SendArrow("{End}")

SC19:: SendArrow("{PgUp}")
SC35:: SendArrow("{PgDn}")

SC1E & SC17:: SendArrow("!{Up}")
SC1E & SC25:: SendArrow("!{Down}")

#HotIf