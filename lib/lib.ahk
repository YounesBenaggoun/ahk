now_for_debug() {
    return FormatTime(, "HH:mm:ss")
}

debug(___text := "default variable", enable := true) {
    if (enable) {
        FileAppend now_for_debug() " -- " ___text "`n", "debug.txt"
    }
}