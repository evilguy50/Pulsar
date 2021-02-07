import os
import strutils
import strformat
proc basicBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    #create needed directories
    #BP
    if os.dirExists("BP") == false:
        os.createDir("BP")
    os.setCurrentDir("BP")
    if os.dirExists("blocks") == false:
        os.createDir("blocks")
    if os.dirExists("texts") == false:
        os.createDir("texts")
    if os.dirExists("loot_tables") == false:
        os.createDir("loot_tables")
    if os.dirExists("loot_tables/blocks") == false:
        os.createDir("loot_tables/blocks")
    os.setCurrentDir(root)
    os.setCurrentDir(works)
    echo "generated behaviour folders"
    #RP
    if os.dirExists("RP") == false:
        os.createDir("RP")
    os.setCurrentDir("RP")
    if os.dirExists("textures") == false:
        os.createDir("textures")
    if os.dirExists("textures/blocks") == false:
        os.createDir("textures/blocks")
    if os.dirExists("texts") == false:
        os.createDir("texts")
    echo "generated resource folders"

    #define blocks in BP
    os.setCurrentDir(root)
    var bpBlockTemplate = "./templates/BP/basicBlock.txt"
    var bpBlockName = fmt"./{works}/BP/blocks/{name}.json"
    var bpBlockRead = readFile(bpBlockTemplate)
    var bpBlockReplace = replace(bpBlockRead, "$name", name)
    writeFile(bpBlockName, bpBlockReplace)
    echo name, " saved as block ", name, ".json"

    #generate loot tables
    var lootTemplate = "./templates/BP/basicBlock_loot.txt"
    var lootFile = fmt"./{works}/BP/loot_tables/blocks/{name}.json"
    var lootRead = readFile(lootTemplate)
    var lootReplace = replace(lootRead, "$name", name)
    writeFile(lootFile, lootReplace)
    echo name, " saved loottable for ", name, " as ", name, ".json"

    #generate block json for RP
    var rpBlockTemplate = "./templates/RP/basicBlock.txt"
    var rpBlockTemplateEntry = "./templates/RP/basicBlock_entry.txt"
    var rpBlockName = fmt"./{works}/RP/blocks.json"
    var newJson: bool = false
    var jsonReplaced: bool = false
    if os.fileExists(rpBlockName) == false and nameNumber == 1:
        var rpBlockRead = readFile(rpBlockTemplate)
        var rpBlockReplace = replace(rpBlockRead, "$name", name)
        writeFile(rpBlockName, rpBlockReplace)
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
        var rpBlockRead3 = readFile(rpBlockTemplateEntry)
        var rpBlockEntryReplace = replace(rpBlockRead3, "$name", name)
        write(rpBlockEntry, rpBlockEntryReplace)
        close(rpBlockEntry)
    if nameNumber >= nameCount:
        var rpBlockEntry2 = open(rpBlockName, fmAppend)
        write(rpBlockEntry2, "}")
        close(rpBlockEntry2)
    echo name, " added block.json entry for ", name

    #generate texture json
    var rpTextureName = fmt"./{works}/RP/textures/terrain_texture.json"
    var rpTextureTemplate = "./templates/RP/basicBlock_texture.txt"
    var rpTextureEntry = "./templates/RP/basicBlock_texture_entry.txt"
    var newTexture: bool = false
    if os.fileExists(rpTextureName) == false and nameNumber == 1:
        var textureRead = readFile(rpTextureTemplate)
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
        var textureEntryRead = readFile(rpTextureEntry)
        var textureEntryReplace = replace(textureEntryRead, "$name", name)
        var textureEntryFile = open(rpTextureName, fmAppend)
        write(textureEntryFile, textureEntryReplace)
        close(textureEntryFile)
    if nameNumber >= nameCount:
        var textureEnd = open(rpTextureName, fmAppend)
        write(textureEnd, "}}")
        close(textureEnd)
    echo name, " generated texture.json definition for ", name
    #generate textures
    var iconFile = "./templates/RP/textures/evil.png"
    var blockIconFile = fmt"./{works}/RP/textures/blocks/{name}.png"
    copyFile(iconFile, blockIconFile)
    echo name, " generated texture for block as ", name, ".png"

    #
    #   Generate language entries
    #

    #generate BP language entries
    var bpLangFile = fmt"./{works}/BP/texts/en_US.lang"
    var bpLangTemplate = "./templates/BP/texts/en_US.txt"
    var bpLangJson = fmt"./{works}/BP/texts/languages.json"
    var bpLangJsonTemplate = "./templates/BP/texts/languages.txt"
    if os.fileExists(bpLangFile) == false:
        var bpLangRead = readFile(bpLangTemplate)
        var bpLangReplace = replace(bpLangRead, "$works", works)
        writeFile(bpLangFile, bpLangReplace)

    if os.fileExists(bpLangJson) == false:
        copyFile(bpLangJsonTemplate, bpLangJson)
    echo "setup behaviour languages files"

    #generate RP language entries
    var rpLangFile = fmt"./{works}/RP/texts/en_US.lang"
    var rpLangTemplate = "./templates/RP/texts/en_US.txt"
    var rpLangJson = fmt"./{works}/RP/texts/languages.json"
    var rpLangJsonTemplate = "./templates/RP/texts/languages.txt"

    if os.fileExists(rpLangFile) == false:
        var rpLangFileRead = readFile(rpLangTemplate)
        var rpLangFileReplace = replace(rpLangFileRead, "$works", works)
        writeFile(rpLangFile, rpLangFileReplace)

    if os.fileExists(rpLangJson) == false:
        var rpLangJsonRead = readFile(rpLangJsonTemplate)
        var rpLangJsonReplace = replace(rpLangJsonRead, "$works", works)
        writeFile(rpLangJson, rpLangJsonReplace)
    echo "setup resource languages files"

    #populate block lang entries
    var blockLangEntry = fmt"tile.evil:{name}.name={name}"
    var blockLangRead = open(rpLangFile, fmAppend)
    write(blockLangRead, blockLangEntry)
    write(blockLangRead, "\n")
    close(blockLangRead)
    echo name, " populated language entries for ", name

    os.setCurrentDir(works)
    return