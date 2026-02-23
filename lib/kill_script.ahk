; Kill Boucle ----------------------------------------
SetTimer myBoucle, 60000 ; 1 minute
myBoucle() {
    now := Number(FormatTime(, "Hmm"))
    if (now == 920) {
        ExitApp
    }
    if (now == 2224) {
        ExitApp
    }
    ; if (1840 <= now && now <= 1841) {
    ;     ExitApp
    ; }
}
; ---------------------------------------------------
