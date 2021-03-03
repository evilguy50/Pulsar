import os
import strformat
import common/folderExist
import common/nameReplace
import common/textureJson
import common/langFiles

proc basicItem*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
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
    var bp_item_file = "./templates/basicItem/BP/basicItem.txt"
    var bp_item_string = fmt"./{works}/BP/items/{name}.json"
    nameReplace(bp_item_file, bp_item_string, name)
    echo name, " generated BP item as ", name, ".json"

    #generate RP item
    var rp_item_file = "./templates/basicItem/RP/basicItem.txt"
    var rp_item_string = fmt"./{works}/RP/items/{name}.json"
    nameReplace(rp_item_file, rp_item_string, name)
    echo name, " generated RP item as ", name, ".json"

    #generate texture
    var itemCopy = "./templates/common/RP/textures/evil.png"
    var itemTexture = fmt"./{works}/RP/textures/items/{name}.png"
    copyFile(itemCopy, itemTexture)
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