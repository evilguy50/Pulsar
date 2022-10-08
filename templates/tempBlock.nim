import common/blockTemplate
import strformat
import os
import json

proc tempBlock*(name: string, root: string, works: string, baseName: string)=
    os.setCurrentDir(root)
    var mainSound = "stone"
    var mainJson = fmt"./User_templates/custom/Blocks/blocks/{baseName}.json"
    if os.fileExists(fmt"./User_templates/custom/Blocks/optional/sounds/{baseName}.json"):
        mainSound = readFile(fmt"./User_templates/custom/Blocks/optional/sounds/{baseName}.json").parseJson()["sound"].to(string)
    os.setCurrentDir(works)
    blockTemplate(name, root, works, mainJson, mainSound, false)

proc tempBlockGeo*(name: string, root: string, works: string, baseName: string)=
    os.setCurrentDir(root)
    var mainSound = "stone"
    var mainJson = fmt"./User_templates/custom/Blocks/blocks/{baseName}.json"
    if os.fileExists(fmt"./User_templates/custom/Blocks/optional/sounds/{baseName}.json"):
        mainSound = readFile(fmt"./User_templates/custom/Blocks/optional/sounds/{baseName}.json").parseJson()["sound"].to(string)
    var geometry = fmt"./User_templates/custom/Blocks/optional/geometry/{baseName}.json"
    var geometryTexture = fmt"./User_templates/custom/Blocks/optional/geometry/textures/{baseName}.png"
    os.setCurrentDir(works)
    blockTemplate(name, root, works, mainJson, mainSound, geometry, geometryTexture, false)