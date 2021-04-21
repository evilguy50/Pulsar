import os
import strformat
import folderExist
import nameReplace
import textureJson
import langFiles

proc itemTemplate*(name: string, root: string, works: string, nameCount: int, nameNumber: int,
 mainJson: string, resourceJson: string, itemTexture: string)=
    #setup BP folders
    folderExist("BP")
    folderExist("BP/texts")
    folderExist("BP/items")
    echo "generated behaviour folders"

    #setup RP folders
    folderExist("RP")
    folderExist("RP/texts")
    folderExist("RP/items")
    folderExist("RP/textures")
    folderExist("RP/textures/items")
    echo "generated resource folders"
    
    os.setCurrentDir(root)

    #generate BP item
    var itemString = fmt"./{works}/BP/items/{name}.json"
    nameReplace(mainJson, itemString, name)
    echo name, " generated BP item as ", name, ".json"

    #generate RP item
    var resourceItem = fmt"./{works}/RP/items/{name}.json"
    nameReplace(resourceJson, resourceItem, name)
    echo name, " generated RP item as ", name, ".json"

    #generate texture
    var itemFile = fmt"./{works}/RP/textures/items/{name}.png"
    copyFile(itemTexture, itemFile)
    echo name, " generated item texture as ", name, ".png"

    #generate texture json
    textureJson(works, name, nameNumber, nameCount, "item")
    echo name, " generated texture json entry for ", name

    #generate lang files
    var itemEntry = fmt"item.evil:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, itemEntry)
    echo name, " generated item lang entry for ", name
    
    os.setCurrentDir(works)
    return