import common/itemTemplate
import strformat
import strutils
import os

proc tempItem*(name: string, root: string, works: string, baseName: string)=
    os.setCurrentDir(root)
    var mainJson = fmt"./User_templates/Items/items/BP/{baseName}.txt"
    var resourceJson = fmt"./User_templates/Items/items/RP/{baseName}.txt"
    var textureCheck = fmt"./User_templates/Items/texture/{baseName}.png"
    var itemTexture = textureCheck
    if os.fileExists(textureCheck) == false:
        itemTexture = "./templates/common/RP/textures/evil.png"
    os.setCurrentDir(works)
    itemTemplate(name, root, works, mainJson, resourceJson, itemTexture)

    var langJson = "./RP/texts/en_US.lang"
    var langRead = readFile(langJson)
    var langReplace = replace(langRead, fmt"item.evil:{name}.name={name}", fmt"item.evil:{name}={name}")
    writeFile(langJson, langReplace)
    return