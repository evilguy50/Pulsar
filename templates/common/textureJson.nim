import os
import strutils
import strformat

proc textureJson*(works: string, name: string, nameNumber: int, nameCount:int, templateType: string)=
    var textures_txt = ""
    var textures_entry_txt = ""
    if templateType == "entity":
        textures_txt = "./templates/common/RP/entity_textures.txt"
        textures_entry_txt = "./templates/common/RP/entity_textureEntry.txt"
    elif templateType == "item":
        textures_txt = "./templates/common/RP/item_textures.txt"
        textures_entry_txt = "./templates/common/RP/item_textureEntry.txt"
    var textureJsonTemplate = fmt"./{works}/RP/textures/item_texture.json"
    var textureJsonRerun = fmt"./{works}/RP/textures/item_texture2.json"
    var newJson: bool = false
    if os.fileExists(textureJsonTemplate) == false:
        var textureJson = readFile(textures_txt)
        var textureJsonGen = replace(textureJson, "$works", works)
        var textureJsonGen2 = replace(textureJsonGen, "$name", name)
        writeFile(textureJsonTemplate, textureJsonGen2)
        newJson = true
    elif newJson == false and nameNumber == 1:
        copyFile(textureJsonTemplate, textureJsonRerun)
        var oldRead = readFile(textureJsonRerun)
        var oldReplace = replace(oldRead, "}}", "")
        removeFile(textureJsonTemplate)
        writeFile(textureJsonTemplate, oldReplace)
        removeFile(textureJsonRerun)
    if newJson == false:
        var textureJsonPopulate = open(textureJsonTemplate, fmAppend)
        var textureEntryRead = readFile(textures_entry_txt)
        var textureEntry = replace(textureEntryRead, "$name", name)
        write(textureJsonPopulate, textureEntry)
        close(textureJsonPopulate)
    if nameNumber >= nameCount:
        var textureJsonPopulate2 = open(textureJsonTemplate, fmAppend)
        var textureEnd = "}}"
        write(textureJsonPopulate2, textureEnd)
        close(textureJsonPopulate2)
