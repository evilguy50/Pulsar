#project settings
var
    #cint values
    proj_width*: cint = 400
    proj_height*: cint = 50
    proj_xpos*: cint =  301
    proj_ypos*: cint = 230

    #float values
    projF_width*: float = 400.0
    projF_height*: float = 50.0
    projF_xpos*: float =  301.0
    projF_ypos*: float = 230.0

    #text pos
    projTXT_xpos*: cint = 311
    projTXT_ypos*: cint = 240

    #other
    proj_letters*: cint = 0
    proj_key*: cint = 0

const proj_keyMax*: cint = 100
const proj_key_1*: cint = proj_keyMax + 1
var proj_chars*: array[proj_key_1, char]