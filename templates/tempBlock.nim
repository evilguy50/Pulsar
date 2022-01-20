import common/blockTemplate
import strformat
import os

proc tempBlock*(name: string, root: string, works: string, baseName: string)=
    os.setCurrentDir(root)
    var mainSound = "stone"
    var mainJson = fmt"./User_templates/Blocks/optional/blocks/{baseName}.txt"
    if os.fileExists(fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt"):
        mainSound = readFile(fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt")
    os.setCurrentDir(works)
    blockTemplate(name, root, works, mainJson, mainSound, false)
    return

proc tempBlockGeo*(name: string, root: string, works: string, baseName: string)=
    os.setCurrentDir(root)
    var mainSound = "stone"
    var mainJson = fmt"./User_templates/Blocks/optional/blocks/{baseName}.txt"
    if os.fileExists(fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt"):
        mainSound = fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt"
    var geometry = fmt"./User_templates/Blocks/optional/geometry/{baseName}.txt"
    var geometryTexture = fmt"./User_templates/Blocks/optional/geometry/textures/{baseName}.png"
    if os.fileExists(mainSound):
        mainSound = readFile(fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt")
    os.setCurrentDir(works)
    blockTemplate(name, root, works, mainJson, mainSound, geometry, geometryTexture, false)
    return