#Requires AutoHotkey v2.0

; Test.ahk
#Requires AutoHotkey v2.0
; #Include %A_ScriptDir%\lib\Yunit\Yunit.ahk
; #Include %A_ScriptDir%\lib\Yunit\Window.ahk

#Include lib/Yunit/Yunit.ahk
#Include lib/Yunit/Window.ahk

Yunit.Use(YunitWindow).Test(MathTests)

class MathTests {
    Add() {
        result := 2 + 3
        Yunit.Assert(result = 5, "2 + 3 should equal 5")
    }

    Subtract() {
        result := 10 - 4
        Yunit.Assert(result = 6, "10 - 4 should equal 6")
    }

    StringConcat() {
        result := "Hello" . " " . "World"
        Yunit.Assert(result = "Hello World", "String concat failed")
    }
}
