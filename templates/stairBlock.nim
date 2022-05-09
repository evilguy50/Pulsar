import common/blockTemplate

proc stairBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/stairBlock/BP/stairBlock.json"
    var geometry = "./templates/stairBlock/RP/stairBlock.json"
    var geometryTexture = "./templates/stairBlock/RP/textures/stairBlock.png"
    blockTemplate(name, root, works, mainJson, "stone", geometry, geometryTexture, false)