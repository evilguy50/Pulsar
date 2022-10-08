import os
import strformat
import strutils
import json

proc textureJson*(works: string, name: string, templateType: string) =
    var textures_txt = "./templates/common/RP/item_textures.json"
    var textures_entry_txt: string
    if templateType == "entity":
        textures_entry_txt = "textures/items/egg/" & name
    elif templateType == "item":
        textures_entry_txt = "textures/items/" & name
    var textureJson = fmt"./{works}/RP/textures/item_texture.json"
    var txtJson: JsonNode
    if not os.fileExists(textureJson):
        writeFile(textureJson, textures_txt)
        txtJson = readFile(textures_txt).parseJson()
    else:
        txtJson = readFile(textureJson).parseJson()
    txtJson["texture_data"].add(name, newJObject())
    txtJson["texture_data"][name].add("textures", newJString(textures_entry_txt))
    writeFile(textureJson, txtJson.pretty().replace("$works", works))
