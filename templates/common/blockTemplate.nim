import os
import strformat
import strutils
import folderExist
import nameReplace
import blockJson
import langFiles

proc blockTemplate*(name: string, root: string, works: string,
 mainJson: string, soundJson: string,function: bool)=
    #create BP folders
    folderExist("BP")
    folderExist("BP/blocks")
    folderExist("BP/texts")
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
    var bpBlockName = fmt"./{works}/BP/blocks/{name}.json"
    nameReplace(mainJson, bpBlockName, name)
    echo name, " generated block as ", name, ".json"

    #generate loot tables
    var lootTemplate = "./templates/common/BP/blockLoot.json"
    var lootFile = fmt"./{works}/BP/loot_tables/blocks/{name}.json"
    nameReplace(lootTemplate, lootFile, name)
    echo name, " generated loottable as ", name, ".json"

    os.setCurrentDir(works)
    if function == true:
       folderExist("BP/functions")
       var functionFile = fmt"./BP/functions/{name}.mcfunction"
       writeFile(functionFile, "")
    os.setCurrentDir(root)

    #generate block json for RP
    blockJson(works, name, soundJson)
    echo name, " generated block entry for ", name

    #generate texture json
    terrainJson(works, name)
    echo name, " generated texture entry for ", name

    #generate language files
    var rpLang_entry = fmt"tile.pulsar:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, rpLang_entry)
    echo name, " generated lang entries for ", name

    var blockTextureFile = "./templates/common/RP/textures/placeholder.png"
    var blockTextureString = fmt"./{works}/RP/textures/blocks/{name}.png"
    copyFile(blockTextureFile, blockTextureString)
    echo name, " generated texture as ", name, ".json"

    os.setCurrentDir(works)
    return

proc blockTemplate*(name: string, root: string, works: string,
 mainJson: string, soundJson: string, geometry: string, geometryTexture: string, function: bool)=
    var geometryTexture2 = geometryTexture

    #create BP folders
    folderExist("BP")
    folderExist("BP/blocks")
    folderExist("BP/texts")
    folderExist("BP/loot_tables")
    folderExist("BP/loot_tables/blocks")
    echo "generated behaviour folders"

    #create RP folders
    folderExist("RP")
    folderExist("RP/textures")
    folderExist("RP/textures/blocks")
    folderExist("RP/models")
    folderExist("RP/models/entity")
    folderExist("RP/texts")
    echo "generated resource folders"

    #define blocks in BP
    os.setCurrentDir(root)
    var bpBlockName = fmt"./{works}/BP/blocks/{name}.json"
    nameReplace(mainJson, bpBlockName, name)
    echo name, " generated block as ", name, ".json"

    #generate loot tables
    var lootTemplate = "./templates/common/BP/blockLoot.json"
    var lootFile = fmt"./{works}/BP/loot_tables/blocks/{name}.json"
    nameReplace(lootTemplate, lootFile, name)
    echo name, " generated loottable as ", name, ".json"

    if function == true:
       folderExist("BP/functions")
       var functionFile = fmt"./{works}/BP/functions/{name}.mcfunction"
       writeFile(functionFile, "")

    #generate block json for RP
    blockJson(works, name, soundJson)
    echo name, " generated block entry for ", name

    #generate texture json
    terrainJson(works, name)
    echo name, " generated texture entry for ", name

    #generate language files
    var rpLang_entry = fmt"tile.pulsar:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, rpLang_entry)
    echo name, " generated lang entries for ", name

    #generate block model
    var geoString = fmt"./{works}/RP/models/entity/{name}.json"
    nameReplace(geometry, geoString, name)
    
    var blockTextureString = fmt"./{works}/RP/textures/blocks/{name}.png"
    copyFile(geometryTexture2, blockTextureString)
    echo name, " generated texture as ", name, ".json"

    os.setCurrentDir(works)
    return


proc pulsarBlock*(name: string, root: string, works: string,
 mainJson: string, soundJson: string,function: bool)=
    os.setCurrentDir(works)
    #create BP folders
    folderExist("BP")
    folderExist("BP/blocks")
    folderExist("BP/texts")
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
    var bpBlockName = fmt"./{works}/BP/blocks/{name}.json"
    writeFile(bpBlockName, mainJson.replace("$name", name))
    echo name, " generated block as ", name, ".json"

    #generate loot tables
    var lootTemplate = "./templates/common/BP/blockLoot.json"
    var lootFile = fmt"./{works}/BP/loot_tables/blocks/{name}.json"
    nameReplace(lootTemplate, lootFile, name)
    echo name, " generated loottable as ", name, ".json"

    os.setCurrentDir(works)
    if function == true:
       folderExist("BP/functions")
       var functionFile = fmt"./BP/functions/{name}.mcfunction"
       writeFile(functionFile, "")
    os.setCurrentDir(root)

    #generate block json for RP
    blockJson(works, name, soundJson)
    echo name, " generated block entry for ", name

    #generate texture json
    terrainJson(works, name)
    echo name, " generated texture entry for ", name

    #generate language files
    var rpLang_entry = fmt"tile.pulsar:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, rpLang_entry)
    echo name, " generated lang entries for ", name

    var blockTextureFile = "./templates/common/RP/textures/placeholder.png"
    var blockTextureString = fmt"./{works}/RP/textures/blocks/{name}.png"
    copyFile(blockTextureFile, blockTextureString)
    echo name, " generated texture as ", name, ".json"

    os.setCurrentDir(root)
    return

proc pulsarBlock*(name: string, root: string, works: string,
 mainJson: string, soundJson: string, geometry: string, geometryTexture: string, function: bool)=
    var geometryTexture2 = geometryTexture
    os.setCurrentDir(works)

    #create BP folders
    folderExist("BP")
    folderExist("BP/blocks")
    folderExist("BP/texts")
    folderExist("BP/loot_tables")
    folderExist("BP/loot_tables/blocks")
    echo "generated behaviour folders"

    #create RP folders
    folderExist("RP")
    folderExist("RP/textures")
    folderExist("RP/textures/blocks")
    folderExist("RP/models")
    folderExist("RP/models/entity")
    folderExist("RP/texts")
    echo "generated resource folders"

    #define blocks in BP
    os.setCurrentDir(root)
    var bpBlockName = fmt"./{works}/BP/blocks/{name}.json"
    writeFile(bpBlockName, mainJson.replace("$name", name))
    echo name, " generated block as ", name, ".json"

    #generate loot tables
    var lootTemplate = "./templates/common/BP/blockLoot.json"
    var lootFile = fmt"./{works}/BP/loot_tables/blocks/{name}.json"
    nameReplace(lootTemplate, lootFile, name)
    echo name, " generated loottable as ", name, ".json"

    if function == true:
       folderExist("BP/functions")
       var functionFile = fmt"./{works}/BP/functions/{name}.mcfunction"
       writeFile(functionFile, "")

    #generate block json for RP
    blockJson(works, name, soundJson)
    echo name, " generated block entry for ", name

    #generate texture json
    terrainJson(works, name)
    echo name, " generated texture entry for ", name

    #generate language files
    var rpLang_entry = fmt"tile.pulsar:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, rpLang_entry)
    echo name, " generated lang entries for ", name

    #generate block model
    var geoString = fmt"./{works}/RP/models/entity/{name}.json"
    writeFile(geoString, geometry.replace("$name", name))
    
    var blockTextureString = fmt"./{works}/RP/textures/blocks/{name}.png"
    writeFile(blockTextureString, geometryTexture2)
    echo name, " generated texture as ", name, ".json"

    os.setCurrentDir(root)
    return