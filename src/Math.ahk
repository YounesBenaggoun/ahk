#Requires AutoHotkey v2.0

#Requires AutoHotkey v2.0

addition(a, b) {
    return a + b
}

subtraction(a, b) {
    return a - b
}

multiply(a, b) {
    return a * b
}

divide(a, b) {
    if (b = 0)
        throw Error("Division by zero")

    return a / b
}
