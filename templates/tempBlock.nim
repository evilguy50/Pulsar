import common/blockTemplate
import strformat
import os

proc tempBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int, baseName: string)=

    os.setCurrentDir(root)
    var mainSound = "stone"
    var soundEntry = "stone"
    var mainJson = fmt"./User_templates/Blocks/optional/blocks/{baseName}.txt"
    if os.fileExists(fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt"):
        mainSound = fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt"
    if os.fileExists(fmt"./User_templates/Blocks/optional/sounds/entries/{baseName}.txt"):
        soundEntry = fmt"./User_templates/Blocks/optional/sounds/entries/{baseName}.txt"
    os.setCurrentDir(works)
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson, mainSound, soundEntry, false)
    return

proc tempBlockGeo*(name: string, root: string, works: string, nameCount: int, nameNumber: int, baseName: string)=

    os.setCurrentDir(root)
    var mainSound = "stone"
    var soundEntry = "stone"
    var mainJson = fmt"./User_templates/Blocks/optional/blocks/{baseName}.txt"
    if os.fileExists(fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt"):
        mainSound = fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt"
    if os.fileExists(fmt"./User_templates/Blocks/optional/sounds/entries/{baseName}.txt"):
        soundEntry = fmt"./User_templates/Blocks/optional/sounds/entries/{baseName}.txt"
    var geometry = fmt"./User_templates/Blocks/optional/geometry/{baseName}.txt"
    var geometryTexture = fmt"./User_templates/Blocks/optional/geometry/textures/{baseName}.png"
    if os.fileExists(mainSound):
        mainSound = fmt"./User_templates/Blocks/optional/sounds/{baseName}.txt"
    if os.fileExists(soundEntry):
        soundEntry = fmt"./User_templates/Blocks/optional/sounds/entries/{baseName}.txt"
    os.setCurrentDir(works)
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson, mainSound, soundEntry, geometry, geometryTexture, false)
    return