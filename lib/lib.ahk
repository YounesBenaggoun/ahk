now_for_debug() {
    return FormatTime(, "HH:mm:ss")
}

debug(text := "default variable", enabled := true, explanation := "explication => ") {
    if (!enabled)
        return

    timestamp := FormatTime(, "HH:mm:ss")

    message := timestamp
        . " -- "
        . explanation
        . " -- "
        . text
        . "`n"

    FileAppend(message, "debug.txt")
}
