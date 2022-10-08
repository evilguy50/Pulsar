import os
import json
import strutils
import strformat

proc blockJson*(works: string, name: string, sound: string)=
    var rpBlockName = fmt"./{works}/RP/blocks.json" 
    var rpBlockBase = "./templates/common/RP/blockJson.json"
    var rpJson: JsonNode

    if not fileExists(rpBlockName):
        rpJson = rpBlockBase.readFile().parseJson()
    else:
        rpJson = rpBlockName.readFile().parseJson()

    rpJson.add("pulsar:" & name, newJObject())
    rpJson["pulsar:" & name].add("textures", newJString(name))
    rpJson["pulsar:" & name].add("sound", newJString(sound))
    writeFile(rpBlockName, rpJson.pretty())
    echo name, " generated block jsonn definition for ", name

proc terrainJson*(works: string, name: string)=
    #generate texture json

    var rpTextureName = fmt"./{works}/RP/textures/terrain_texture.json"
    var rpBlockBase = "./templates/common/RP/block_texture.json"
    var rpJson: JsonNode

    if not fileExists(rpTextureName):
        rpJson = rpBlockBase.readFile().parseJson()
    else:
        rpJson = rpTextureName.readFile().parseJson() 

    rpJson["texture_data"].add(name, newJObject())
    rpJson["texture_data"][name].add("textures", newJString("textures/blocks/" & name))
    writeFile(rpTextureName, rpJson.pretty().replace("$works", works))
    echo name, " generated texture.json definition for ", name