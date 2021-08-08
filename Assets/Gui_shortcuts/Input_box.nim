import nimraylib_now

proc inputWrap*(overMouse: bool, boxRec: Rectangle, boxX: cint, boxY: cint, boxWidth: cint, boxHeight: cint, boxStr: cstring, txtX: cint, txtY: cint, fontSize: cint, message: cstring)=
    var font = getFontDefault()
    var fontSizeF = toFloat(fontSize)
    var fontSizeFF: cfloat = fontSizeF 
    var spacing: cfloat = 5.00
    drawRectangle(boxX, boxY, boxWidth, boxHeight, White)
    #drawText(boxStr, txtX, txtY, fontSize, Black)
    drawTextRec(font, boxStr, boxRec, fontSizeFF , spacing, true, Black)
    if overMouse == false:
        drawRectangleLines(boxX, boxY, boxWidth, boxHeight, Black)
        if boxStr == "":
            drawTextRec(font, message, boxRec, fontSizeFF , spacing, true, Black)
    else:
        drawRectangleLines(boxX, boxY, boxWidth, boxHeight, Green)

template inputKeys*(boxMouse: bool, boxKey: cint, boxKeyMax: cint, boxLetters: cint, boxChar: openArray[char], frames: cint)=
    if boxMouse:
        boxKey = getKeyPressed()
        while boxKey > 0:
            if boxKey.int >= 32 and boxKey.int <= 125 and boxLetters.int < boxKeyMax.int:
                boxChar[boxLetters] = boxKey.char
                if boxKey.int == 45:
                    boxChar[boxLetters] = '_'
                inc(boxLetters, 1)
            boxKey = getKeyPressed()
        if isKeyDown(BACKSPACE) and frames mod 3 == 0 :
            dec(boxLetters, 1)
            if boxLetters < 0:
                boxLetters = 0
            boxChar[boxLetters] = '\0'

template clearChars*(boxLetters: cint, boxChar: openArray[char])=
    for i in boxChar:
            dec(boxLetters, 1)
            if boxLetters < 0:
                boxLetters = 0
            boxChar[boxLetters] = '\0'