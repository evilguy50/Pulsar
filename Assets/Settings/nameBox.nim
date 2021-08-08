#nameBox settings
var
    #cint values
    name_width*: cint = 400
    name_height*: cint = 200
    name_xpos*: cint = 301
    name_ypos*: cint = 350

    #float values
    nameF_width*: float = 400.0
    nameF_height*: float = 200.0
    nameF_xpos*: float = 301.0
    nameF_ypos*: float = 350.0

    #text pos
    nameTXT_xpos*: cint = 311
    nameTXT_ypos*: cint = 360

    #other
    name_letters*: cint = 0
    name_key*: cint = 0

const name_keyMax*: cint = 400
const name_key_1*: cint = name_keyMax + 1
var name_chars*: array[name_key_1, char]