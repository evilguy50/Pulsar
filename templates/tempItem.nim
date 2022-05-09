import common/itemTemplate
import strformat
import os

proc tempItem*(name: string, root: string, works: string, baseName: string)=
    os.setCurrentDir(root)
    var mainJson = fmt"./User_templates/custom/Items/items/{baseName}.json"
    var resourceJson = fmt"./User_templates/custom/Items/optional/RP/{baseName}.json"
    if not os.fileExists(resourceJson):
        resourceJson = "none"
    var textureCheck = fmt"./User_templates/custom/Items/optional/texture/{baseName}.png"
    var itemTexture = textureCheck
    if os.fileExists(textureCheck) == false:
        itemTexture = "./templates/common/RP/textures/placeholder.png"
    os.setCurrentDir(works)
    itemTemplate(name, root, works, mainJson, resourceJson, itemTexture)