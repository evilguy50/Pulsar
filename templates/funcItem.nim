import common/itemTemplate
import common/folderExist
import os
import strformat

proc funcItem*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    var mainJson = "./templates/funcItem/BP/funcItem.txt"
    var resourceJson = "./templates/basicItem/RP/basicItem.txt"
    var itemTexture = "./templates/common/RP/textures/evil.png"
    itemTemplate(name, root, works, nameCount, nameNumber, mainJson, resourceJson, itemTexture)
    os.setCurrentDir("BP")
    folderExist("functions")
    writeFile(fmt"functions/{name}.mcfunction", "")
    os.setCurrentDir(root)
    os.setCurrentDir(works)
    return