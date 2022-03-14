import common/itemTemplate
import strformat
import strutils
import os

proc tempItem*(name: string, root: string, works: string, baseName: string)=
    os.setCurrentDir(root)
    var mainJson = fmt"./User_templates/custom/Items/items/BP/{baseName}.json"
    var resourceJson = fmt"./User_templates/custom/Items/items/RP/{baseName}.json"
    if not os.fileExists(resourceJson):
        resourceJson = "none"
    var textureCheck = fmt"./User_templates/custom/Items/texture/{baseName}.png"
    var itemTexture = textureCheck
    if os.fileExists(textureCheck) == false:
        itemTexture = "./templates/common/RP/textures/placeholder.png"
    os.setCurrentDir(works)
    itemTemplate(name, root, works, mainJson, resourceJson, itemTexture)

    var langJson = "./RP/texts/en_US.lang"
    var langRead = readFile(langJson)
    var langReplace = replace(langRead, fmt"item.pulsar:{name}.name={name}", fmt"item.pulsar:{name}={name}")
    writeFile(langJson, langReplace)
    return