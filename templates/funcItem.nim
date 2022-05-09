import common/itemTemplate
import common/folderExist
import os
import strformat

proc funcItem*(name: string, root: string, works: string)=
    var mainJson = "./templates/funcItem/BP/funcItem.json"
    var itemTexture = "./templates/common/RP/textures/placeholder.png"
    itemTemplate(name, root, works, mainJson, "none", itemTexture)
    os.setCurrentDir("BP")
    folderExist("functions")
    writeFile(fmt"functions/{name}.mcfunction", "")
    os.setCurrentDir(root)
    os.setCurrentDir(works)