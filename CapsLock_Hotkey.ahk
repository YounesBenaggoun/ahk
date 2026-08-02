#Requires AutoHotkey v2.0
#SingleInstance Force
#Include lib/lib.ahk
; #Include lib/kill_script.ahk
InstallKeybdHook

debuging := false
arrowMode := false
capsState := "UP"
t0 := 0

BUTTON_DOWN_TIMER := 250

; SC3A  down == CAPS lock Code

SC3A:: { ; CapsLock
    global capsState
    global arrowMode
    global t0
    

    if (capsState = "UP") {
        capsState := "DOWN"
        t0 := A_TickCount
        debug(t0)
    }
    return false
}

; SC3A up : CapsLock Up
SC3A Up:: {
    global capsState
    global arrowMode
    global t0

    if (capsState = "DOWN") {
        capsState := "UP"
        if (!arrowMode) {
            elapsed := A_TickCount - t0
            debug(elapsed)
            if (elapsed < 250) {
                SetCapsLockState !GetKeyState("CapsLock", "T")
            }

        }
        arrowMode := false
    }
    return false
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