#Requires AutoHotkey v2.0
#SingleInstance Force
#Include functions/lib.ahk

InstallKeybdHook

; ============================================================================
; Configuration
; ============================================================================

global capsButtonState := "UP"
global arrowMode := false
global pressTime := 0

KEY_DOWN_DELAY := 250

; SC3A  down == CAPS lock Code

SC3A::
{
    global capsButtonState
    global pressTime

    if (capsButtonState != "UP")
        return

    capsButtonState := "DOWN"
    pressTime := A_TickCount
    return
}

; SC3A up : CapsLock Up
SC3A Up:: {
    global capsButtonState, arrowMode, pressTime

    if (capsButtonState != "DOWN")
        return

    capsButtonState := "UP"

    if (arrowMode) {
        arrowMode := false
        return
    }

    if ((A_TickCount - PressTime) <= KEY_DOWN_DELAY)
        SetCapsLockState !GetKeyState("CapsLock", "T")

    return
}

; Si CapsLock est appuyée
#HotIf GetKeyState("SC3A", "P")
global arrowMode

sc17:: { ;i
    Send "{Up}"
    global arrowMode
    arrowMode := true
}
sc25:: { ;k
    Send "{Down}"
    global arrowMode
    arrowMode := true
}
sc24:: { ;j
    Send "{Left}"
    global arrowMode
    arrowMode := true
}
sc26:: { ;L
    Send "{Right}"
    global arrowMode
    arrowMode := true
}
sc16:: { ;u
    Send "{BackSpace}"
    global arrowMode
    arrowMode := true
}
sc18:: { ;o
    Send "{Del}"
    global arrowMode
    arrowMode := true
}
sc23:: { ;h
    Send "{Home}"
    global arrowMode
    arrowMode := true
}
sc27:: { ; m
    Send "{End}"
    global arrowMode
    arrowMode := true
}
sc19:: { ;p
    Send "{PgUp}"
    global arrowMode
    arrowMode := true
}
sc35:: { ; !
    Send "{PgDn}"
    global arrowMode
    arrowMode := true
}

;  press i while holding q => Alt + Up
sc1E & sc17:: {
    SendEvent "!{UP}"
    global arrowMode
    arrowMode := true
}

;  press k while holding q => Alt + Down
sc1E & sc25:: {
    SendEvent "!{Down}"
    global arrowMode
    arrowMode := true
}

#HotIf