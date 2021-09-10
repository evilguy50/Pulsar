#template settings
var
    #cint values
    temp_width*: cint = 350
    temp_height*: cint = 50
    temp_xpos*: cint =  351
    temp_ypos*: cint = 290

    #float values
    tempF_width*: float = 300.0
    tempF_height*: float = 50.0
    tempF_xpos*: float =  351.0
    tempF_ypos*: float = 290.0

    #button values
    tempB_xpos*: float = 301.0
    tempB_ypos*: float = 290.0
    tempB_width*: float = 50.0
    tempB_height*: float = 50.0

    #list values
    tempL_xpos*: cint = 20
    tempL_ypos*: cint = 20
    tempL_width*: cint = 250
    tempL_height*: cint = 350

    tempL_Fxpos*: float = 20.0
    tempL_Fypos*: float = 20.0
    tempL_Fwidth*: float = 250.0
    tempL_Fheight*: float = 350.0

    #list text pos
    listTXT_xpos*: cint = 30
    listTXT_ypos*: cint = 20

    #text pos
    tempTXT_xpos*: cint = 360
    tempTXT_ypos*: cint = 300

    #other
    temp_letters*: cint = 0
    temp_key*: cint = 0
const temp_keyMax*: cint = 100
const temp_key_1*: cint = temp_keyMax + 1
var temp_chars*: array[temp_key_1, char]

var templateList*: array[14, string] = ["basic_block", "light_block", "crafting_block (exp mode)", "place_code_block (exp mode)",
 "player_code_block (exp mode)", "skull_block (exp mode)", "slab_block (exp mode)", "stair_block (exp mode)",
 "old_item", "func_item (exp mode)", "new_item (exp mode)", "dummy_entity", "base_entity", "zombie_entity"]

var templateCheckList*: array[14, string] = ["basic_block", "light_block", "crafting_block", "place_code_block",
 "player_code_block", "skull_block", "slab_block", "stair_block",
 "old_item", "func_item", "new_item", "dummy_entity", "base_entity", "zombie_entity"]