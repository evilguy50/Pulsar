import common/itemTemplate
import strformat
import os

proc tempItem*(name: string, root: string, works: string, nameCount: int, nameNumber: int, mainJson: string, resourceJson: string,
 itemTexture: string, baseName: string)=
    os.setCurrentDir(root)
    var mainJson2 = mainJson
    var resourceJson2 = resourceJson
    var itemTexture2 = itemTexture
    if baseName != "":
        if mainJson == "":
            mainJson2 = fmt"./User_templates/Items/items/BP/{baseName}.txt"
        if resourceJson == "":
            resourceJson2 = fmt"./User_templates/Items/items/RP/{baseName}.txt"
        if itemTexture == "":
            var textureCheck = fmt"./User_templates/Items/texture/{baseName}.png"
            if os.fileExists(textureCheck) == false:
                itemTexture2 = "./templates/common/RP/textures/evil.png"
            else:
                itemTexture2 = textureCheck
    os.setCurrentDir(works)
    itemTemplate(name, root, works, nameCount, nameNumber, mainJson2, resourceJson2, itemTexture2)
    return