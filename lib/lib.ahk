now_for_debug() {
    return FormatTime(, "HH:mm:ss")
}

debug(___text := "default variable", enable := true, explication := "explication => ") {
    if (enable) {
        FileAppend now_for_debug() " -- " explication " -- " ___text "`n", "debug.txt"
        ; FileAppend now_for_debug() explication " -- " ___text "`n", "debug.txt"
    }
}
