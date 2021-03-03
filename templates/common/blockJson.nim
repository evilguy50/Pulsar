import os
import strutils
import strformat
import nameReplace

proc blockJson*(works: string, name: string, nameNumber: int, nameCount: int)=

    var newJson: bool = false
    var jsonReplaced: bool = false
    var templateFile = "./templates/common/RP/block_json.txt"
    var templateEntry = "./templates/common/RP/block_json_entry.txt" 
    var rpBlockName = fmt"./{works}/RP/blocks.json"

    if os.fileExists(rpBlockName) == false and nameNumber == 1:
        nameReplace(templateFile, rpBlockName, name)
        newJson = true
    if newJson == false and nameNumber == 1:
        var rpBlockRead2 = readFile(rpBlockName)
        var rpBlockReplace2 = rpBlockRead2
        var rpBlockLength = len(rpBlockRead2)
        var rpBlockLength2 = rpBlockLength - 2
        delete(rpBlockReplace2, rpBlockLength2, rpBlockLength)
        removeFile(rpBlockName)
        writeFile(rpBlockName, rpBlockReplace2)
        var rpFixEnd = open(rpBlockName, fmAppend)
        write(rpFixEnd, "\n")
        close(rpFixEnd)
        jsonReplaced = true
    if nameNumber > 1 or jsonReplaced == true:
        var rpBlockEntry = open(rpBlockName, fmAppend)
        var rpBlockRead3 = readFile(templateEntry)
        var rpBlockEntryReplace = replace(rpBlockRead3, "$name", name)
        write(rpBlockEntry, rpBlockEntryReplace)
        close(rpBlockEntry)
    if nameNumber >= nameCount:
        var rpBlockEntry2 = open(rpBlockName, fmAppend)
        write(rpBlockEntry2, "}")
        close(rpBlockEntry2)
    echo name, " added block.json entry for ", name

proc terrainJson*(works: string, name: string, nameNumber: int, nameCount: int)=
    #generate texture json

    var rpTextureName = fmt"./{works}/RP/textures/terrain_texture.json"
    var newTexture: bool = false
    var templateFile = "./templates/common/RP/block_texture.txt"
    var templateEntry = "./templates/common/RP/block_texture_entry.txt"
    if os.fileExists(rpTextureName) == false and nameNumber == 1:
        var textureRead = readFile(templateFile)
        var textureReplace = replace(textureRead, "$name", name)
        var textureReplaceTitle = replace(textureReplace, "$works", works)
        writeFile(rpTextureName, textureReplaceTitle)
        newTexture = true
    if newTexture == false and nameNumber == 1:
        var textureRead2 = readFile(rpTextureName)
        var textureReplace2 = replace(textureRead2, "}}", "")
        os.removeFile(rpTextureName)
        writeFile(rpTextureName, textureReplace2)
    if newTexture == false or nameNumber > 1:
        var textureEntryRead = readFile(templateEntry)
        var textureEntryReplace = replace(textureEntryRead, "$name", name)
        var textureEntryFile = open(rpTextureName, fmAppend)
        write(textureEntryFile, textureEntryReplace)
        close(textureEntryFile)
    if nameNumber >= nameCount:
        var textureEnd = open(rpTextureName, fmAppend)
        write(textureEnd, "}}")
        close(textureEnd)
    echo name, " generated texture.json definition for ", name