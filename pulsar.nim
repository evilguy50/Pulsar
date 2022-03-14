import nimraylib_now
import pulsar_cli
import nimclipboard/libclipboard
import strutils
import os

import "Assets/Gui_shortcuts/Input_box.nim"

import "Assets/Settings/nameBox.nim"
import "Assets/Settings/tempBox.nim"
import "Assets/Settings/projectBox.nim"
import "Assets/Settings/devBox.nim"

import "Assets/Settings/discordLogo.nim"

import "Assets/Settings/logo.nim"

#background settings
var
    back_width: cint = 1000
    back_height: cint = 563
    back_xpos: cint = 0
    back_ypos: cint = 0

var frameCount = 0
var fontSize: cint = 13

initWindow(back_width, back_height , "Pulsar")
var pulsarIcon: Image = loadImage("./Assets/Images/pulsar_icon.png")
var discord_img: Image = loadImage("./Assets/Images/discord_logo.png")
setWindowIcon(pulsarIcon)
setTargetFPS(30)
var background: Image = loadImage("./Assets/Images/background.png")
var back_ptr: ptr Image = addr(background)
var logo_img: Image = loadImage("./Assets/Images/logo.png")
imageFlipHorizontal(back_ptr)
var render_background = loadTextureFromImage(background)
drawTexture(render_background, back_xpos, back_ypos, White)
var render_logo: Texture = loadTextureFromImage(logo_img)
var render_discord: Texture = loadTextureFromImage(discord_img)
drawTexture(render_logo, logo_xpos, logo_ypos, White)
drawTexture(render_discord, discord_xpos, discord_ypos, White)
unloadImage(background)
unloadImage(pulsarIcon)
unloadImage(discord_img)

unloadImage(logo_img)

var showTempList: bool
var showUsrList: bool
var paused: bool
var inCLip: bool
var clearBox: bool
var showLinks: bool
if showTempList:
    drawRectangle(tempL_xpos, tempL_ypos, tempL_width, tempL_height, White)
    drawRectangleLines(tempL_xpos, tempL_ypos, tempL_width, tempL_height, Black)

if showUsrList:
    drawRectangle(tempL_xpos + 710, tempL_ypos, tempL_width, tempL_height, White)
    drawRectangleLines(tempL_xpos + 710, tempL_ypos, tempL_width, tempL_height, Black)

while not windowShouldClose():
    var cb = clipboard_new(nil)
    var cbData = $cb.clipboard_text()
    if frameCount <= 30:
        inc(frameCount, 1)
    else:
        frameCount = 0

    #discord discord
    var discord: Rectangle = (x:discordF_xpos, y:discordF_ypos, width:100.0, height:100.0)
    var discord_mouse: bool = checkCollisionPointRec(getMousePosition(), discord)
    var discord_button = imageButton(discord, "Partner Links", render_discord)
    var boxSize: (float, float) = (discordBox_width.toFloat(), 30.00)
    var evilRec: Rectangle= (x:discordF_xpos - 10, y:discordF_ypos - 30, width:boxSize[0], height:boxSize[1])
    var raverRec: Rectangle =(x:discordF_xpos - 10, y:discordF_ypos - 65, width:boxSize[0], height:boxSize[1])
    if discord_mouse:
        if discord_button:
            if showLinks:
                showLinks = false
            else:
                showLinks = true

    #project box logic
    var projBox: Rectangle = (x:projF_xpos, y:projF_ypos, width:projF_width, height:projF_height)
    var projBoxW: Rectangle = (x:projF_xpos + 5, y:projF_ypos + 5, width:projF_width - 5, height:projF_height - 5)
    var proj_mouse: bool = checkCollisionPointRec(getMousePosition(), projBox)
    inputKeys(proj_mouse, proj_key, proj_keyMax, proj_letters, proj_chars, frameCount, cbData, inCLip)

    #template box logic
    var tempBox: Rectangle = (x:tempF_xpos, y:tempF_ypos, width:tempF_width, height:tempF_height)
    var tempBoxW: Rectangle = (x:tempF_xpos + 5, y:tempF_ypos + 5, width:tempF_width - 5, height:tempF_height - 5)
    var temp_mouse: bool = checkCollisionPointRec(getMousePosition(), tempBox)
    inputKeys(temp_mouse, temp_key, temp_keyMax, temp_letters, temp_chars, frameCount, cbData, inCLip)

    var temp_button: Rectangle = (x:tempB_xpos, y:tempB_ypos, width:tempB_width, height:tempB_height)
    var list_mouse: bool = checkCollisionPointRec(getMousePosition(), temp_button)

    #user template box logic
    var u_temp_button: Rectangle = (x:tempB_xpos + 350, y:tempB_ypos, width:tempB_width, height:tempB_height)

    #name box logic
    var nameBox: Rectangle = (x: nameF_xpos, y: nameF_ypos, width: nameF_width, height: nameF_height)
    var nameBoxW: Rectangle = (x: nameF_xpos + 5, y: nameF_ypos + 5, width: nameF_width - 5, height: nameF_height - 5)
    var name_mouse: bool = checkCollisionPointRec(getMousePosition(), nameBox)
    inputKeys(name_mouse, name_key, name_keyMax, name_letters, name_chars, frameCount, cbData, inCLip)

    #Generate button
    var genBox: Rectangle = (x:devF_xpos, y:devF_ypos, width:devF_width, height:devF_height)
    
    beginDrawing()
    #render background image
    drawTexture(render_background, back_xpos, back_ypos, White)
    
    #render discord discord
    drawTexture(render_discord, discord_xpos, discord_ypos, White)
    if showLinks:
        var evilButton = button(evilRec, "evil's Marketplace")
        if evilButton:
            openURL("https://discord.gg/JTgAV9Fh8W")
        var raverButton = button(raverRec, "RaverXNetwork")
        if raverButton:
            openURL("http://discord.raverx.network")

    #evil logo
    drawTexture(render_logo, logo_xpos, logo_ypos, White)

    #render project box
    var proj_string = cast[cstring](addr proj_chars[0])
    inputWrap(proj_mouse, projBoxW, proj_xpos, proj_ypos, proj_width,
     proj_height, proj_string, projTXT_xpos, projTXT_ypos, fontSize,
     "enter project name")

    #render template box
    var temp_string = cast[cstring](addr temp_chars[0])
    inputWrap(temp_mouse, tempBoxW, temp_xpos, temp_ypos, temp_width,
     temp_height, temp_string, tempTXT_xpos, tempTXT_ypos, fontSize,
     "enter template name")

    var list_button = button(temp_button, "List")
    if list_mouse:
        if list_button:
            if showTempList == true:
                showTempList = false
            else:
                showTempList = true

    #render user template box
    var utmp_button = button(u_temp_button, "user")
    if utmp_button:
        if showUsrList == true:
            showUsrList = false
        else:
            showUsrList = true

    #render template list
    if showTempList:
        drawRectangle(tempL_xpos, tempL_ypos, tempL_width, tempL_height, White)
        drawRectangleLines(tempL_xpos, tempL_ypos, tempL_width, tempL_height, Black)
        var foo = listTXT_ypos
        for i in templateList:
            foo = foo + 15
            var bar = foo
            drawText(i.cstring, listTXT_xpos, bar, fontSize, Black)

    if showUsrList:
        drawRectangle(tempL_xpos + 710, tempL_ypos, tempL_width, tempL_height, White)
        drawRectangleLines(tempL_xpos + 710, tempL_ypos, tempL_width, tempL_height, Black)
        var ufoo = listTXT_ypos
        var user_root = os.getCurrentDir()
        os.setCurrentDir("User_templates")
        os.setCurrentDir("custom")
        os.setCurrentDir("Blocks")
        os.setCurrentDir("blocks")
        for i in os.walkFiles("*.json"):
            var user_tmpNameSTR = split(i, ".", 2)
            var user_tmpName: cstring = user_tmpNameSTR[0].cstring
            ufoo = ufoo + 15
            var ubar = ufoo
            drawText(user_tmpName, listTXT_xpos + 710, ubar, fontSize, Black)
        os.setCurrentDir(user_root)
        os.setCurrentDir("User_templates")
        os.setCurrentDir("custom")
        os.setCurrentDir("Entities")
        os.setCurrentDir("entity")
        os.setCurrentDir("BP")
        for i in os.walkFiles("*.json"):
            var user_tmpNameSTR = split(i, ".", 2)
            var user_tmpName: cstring = user_tmpNameSTR[0].cstring
            ufoo = ufoo + 15
            var ubar = ufoo
            drawText(user_tmpName, listTXT_xpos + 710, ubar, fontSize, Black)
        os.setCurrentDir(user_root)
        os.setCurrentDir("User_templates")
        os.setCurrentDir("custom")
        os.setCurrentDir("Items")
        os.setCurrentDir("items")
        os.setCurrentDir("BP")
        for i in os.walkFiles("*.json"):
            var user_tmpNameSTR = split(i, ".", 2)
            var user_tmpName: cstring = user_tmpNameSTR[0].cstring
            ufoo = ufoo + 15
            var ubar = ufoo
            drawText(user_tmpName, listTXT_xpos + 710, ubar, fontSize, Black)
        os.setCurrentDir(user_root)
        os.setCurrentDir("User_templates")
        os.setCurrentDir("imported")
        for i in os.walkFiles("*.pulsar"):
            var user_tmpNameSTR = split(i, ".", 2)
            var user_tmpName: cstring = user_tmpNameSTR[0].cstring
            ufoo = ufoo + 15
            var ubar = ufoo
            drawText(user_tmpName, listTXT_xpos + 710, ubar, fontSize, Black)
        os.setCurrentDir(user_root)

    #render name box
    var name_string = cast[cstring](addr name_chars[0])
    inputWrap(name_mouse, nameBoxW, name_xpos, name_ypos, name_width,
     name_height, name_string, nameTXT_xpos, nameTXT_ypos, fontSize,
     "enter list of names to generate seperated by a space.\nhover over a text box to start typing")
    
    #Generate button
    var gen_button = button(genBox, "generate")

    if gen_button:
        if not paused:
            var tempStr: string = $temp_string
            var projStr: string = $proj_string
            var nameStr: string = $name_string
            tempStr = toLower(tempStr)
            projStr = toLower(projStr)
            nameStr = toLower(nameStr)
            paused = true
            generate(projStr, tempStr, nameStr)
            clearBox = true
            

    if clearBox == true:
        clearChars(proj_letters, proj_chars)
        clearChars(temp_letters, temp_chars)
        clearChars(name_letters, name_chars)
        proj_string = ""
        temp_string = ""
        name_string = ""
        clearBox = false
        paused = false

    endDrawing()
unloadTexture(render_background)
unloadTexture(render_discord)
unloadTexture(render_logo)
closeWindow()