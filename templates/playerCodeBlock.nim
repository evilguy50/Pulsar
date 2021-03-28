import os
import strformat
import common/folderExist
import common/nameReplace
import common/blockJson
import common/langFiles

proc playerCodeBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    
    #create BP folders
    folderExist("BP")
    folderExist("BP/blocks")
    folderExist("BP/texts")
    folderExist("BP/functions")
    folderExist("BP/loot_tables")
    folderExist("BP/loot_tables/blocks")
    echo "generated behaviour folders"

    #create RP folders
    folderExist("RP")
    folderExist("RP/textures")
    folderExist("RP/textures/blocks")
    folderExist("RP/texts")
    echo "generated resource folders"

    #define blocks in BP
    os.setCurrentDir(root)
    var bpBlockTemplate = "./templates/playerCodeBlock/BP/playerCodeBlock.txt"
    var bpBlockName = fmt"./{works}/BP/blocks/{name}.json"
    nameReplace(bpBlockTemplate, bpBlockName, name)
    echo name, " generated block as ", name, ".json"

    #generate loot tables
    var lootTemplate = "./templates/common/BP/blockLoot.txt"
    var lootFile = fmt"./{works}/BP/loot_tables/blocks/{name}.json"
    nameReplace(lootTemplate, lootFile, name)
    echo name, " generated loottable as ", name, ".json"
    
    #generate function file
    var functionFile = fmt"./{works}/BP/functions/{name}.mcfunction"
    writeFile(functionFile, "")

    #generate block json for RP  
    var entry = "./templates/common/RP/block_json_entry.txt"
    var base = "./templates/common/RP/block_json.txt"
    blockJson(works, name, nameNumber, nameCount, entry, base)
    echo name, " generated block entry for ", name

    #generate texture json
    terrainJson(works, name, nameNumber, nameCount)
    echo name, " generated texture entry for ", name

    #generate language files
    var rpLang_entry = fmt"tile.evil:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, rpLang_entry)
    echo name, " generated lang entries for ", name

    var blockTextureFile = "./templates/common/RP/textures/evil.png"
    var blockTextureString = fmt"./{works}/RP/textures/blocks/{name}.png"
    copyFile(blockTextureFile, blockTextureString)
    echo name, " generated texture as ", name, ".json"

    os.setCurrentDir(works)
    return