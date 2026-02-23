#Requires AutoHotkey v2.0
#SingleInstance Force
#Include lib/lib.ahk
; #Include lib/kill_script.ahk
InstallKeybdHook

debuging := false
capslock_up := true
sencondkey_down := false

SC3A:: { ; CapsLock
    global capslock_up
    if (capslock_up) {
        capslock_up := false
        doublepress_and_longpress("SC3A")
    }
}

SC3A Up:: {
    global capslock_up
    capslock_up := true
    return false
}

doublepress_and_longpress(___button) {
    global capslock_up, debuging, sencondkey_down
    if (KeyWait(___button, "T0.25")) {
        debug("One Click", debuging)
        debug(sencondkey_down, debuging)
        if (sencondkey_down) {
            sencondkey_down := false
            return
        }
        SetCapsLockState !GetKeyState("CapsLock", "T")
    } else {
        debug("Long Click", debuging)
        return
    }
    return
}

; q k& Alt:: {


;     MsgBox("i and q")
; qqq}
; #HotIf GetKeyState("CapsLock", "P")iiiii

#HotIf GetKeyState("SC3A", "P")
global sencondkey_down


; we need to write it with ScanCode  / press i while holding q
sc1E & sc17:: {
    SendEvent "!{UP}"
}
sc1E & sc25:: {
    SendEvent "!{Down}"
}

sc17:: { ;i
    Send "{Up}"
    global sencondkey_down
    sencondkey_down := true
}
sc25:: { ;k
    Send "{Down}"
    global sencondkey_down
    sencondkey_down := true
}
sc24:: { ;j
    Send "{Left}"
    global sencondkey_down
    sencondkey_down := true
}
sc26:: { ;L
    Send "{Right}"
    global sencondkey_down
    sencondkey_down := true
}
sc16:: { ;u
    Send "{BackSpace}"
    global sencondkey_down
    sencondkey_down := true
}
sc18:: { ;o
    Send "{Del}"
    global sencondkey_down
    sencondkey_down := true
}
sc23:: { ;h
    Send "{Home}"
    global sencondkey_down
    sencondkey_down := true
}
sc27:: { ; m
    Send "{End}"
    global sencondkey_down
    sencondkey_down := true
}
sc19:: { ;p
    Send "{PgUp}"
    global sencondkey_down
    sencondkey_down := true
}
sc35:: { ; !
    Send "{PgDn}"
    global sencondkey_down
    sencondkey_down := true
}
#HotIf