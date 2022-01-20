import common/blockTemplate

proc skullBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/skullBlock/BP/skullBlock.txt"
    var geometry = "./templates/skullBlock/RP/skullBlock_model.txt"
    var geometryTexture = "./templates/skullBlock/RP/textures/skullBlock.png"
    blockTemplate(name, root, works, mainJson, "stone", geometry, geometryTexture, false)
    return