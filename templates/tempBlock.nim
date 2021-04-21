import common/blockTemplate
import strformat
import os

proc tempBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int,
 mainJson: string, mainSound: string, soundEntry: string, useFunction: bool, baseName: string)=

    os.setCurrentDir(root)
    var mainJson2 = mainJson
    var mainSound2 = mainSound
    var soundEntry2 = soundEntry
    if mainSound == "" and baseName == "":
        mainSound2 = "stone"
    if soundEntry == "" and baseName == "":
        soundEntry2 = "stone"
    if baseName != "":
        mainJson2 = fmt"./User_templates/Blocks/blocks/{baseName}.txt"
        mainSound2 = fmt"./User_templates/Blocks/sounds/{baseName}.txt"
        if os.fileExists(mainSound2) == false:
            mainSound2 = "stone"
        soundEntry2 = fmt"./User_templates/Blocks/sounds/entries/{baseName}.txt"
        if os.fileExists(soundEntry2) == false:
            soundEntry2 = "stone"
    os.setCurrentDir(works)
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson2, mainSound2, soundEntry2, useFunction)
    return

proc tempBlockGeo*(name: string, root: string, works: string, nameCount: int, nameNumber: int,
 mainJson: string, mainSound: string, soundEntry: string, geometry: string, geometryTexture: string,
  useFunction: bool, baseName: string)=

    os.setCurrentDir(root)
    var mainJson2 = mainJson
    var mainSound2 = mainSound
    var soundEntry2 = soundEntry
    var geometry2 = geometry
    var geometryTexture2 = geometryTexture
    if mainSound == "" and baseName == "":
        mainSound2 = "stone"
    if soundEntry == "" and baseName == "":
        soundEntry2 = "stone"
    if baseName != "":
        mainJson2 = fmt"./User_templates/Blocks/blocks/{baseName}.txt"
        mainSound2 = fmt"./User_templates/Blocks/sounds/{baseName}.txt"
        geometry2 = fmt"./User_templates/Blocks/geometry/{baseName}.txt"
        geometryTexture2 = fmt"./User_templates/Blocks/geometry/textures/{baseName}.png"
        if os.fileExists(mainSound2) == false:
            mainSound2 = "stone"
        else:
            mainSound2 = mainSound
        soundEntry2 = fmt"./User_templates/Blocks/sounds/entries/{baseName}.txt"
        if os.fileExists(soundEntry2) == false:
            soundEntry2 = "stone"
        else:
            soundEntry2 = soundEntry
    os.setCurrentDir(works)
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson2, mainSound2, soundEntry2, geometry2, geometryTexture2, useFunction)
    return