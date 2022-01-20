import common/blockTemplate

proc slabBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/slabBlock/BP/slabBlock.txt"
    var geometry = "./templates/slabBlock/RP/slabBlock_model.txt"
    var geometryTexture = "./templates/slabBlock/RP/textures/slabBlock.png"
    blockTemplate(name, root, works, mainJson, "stone", geometry, geometryTexture, false)
    return