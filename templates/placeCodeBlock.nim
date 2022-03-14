import common/blockTemplate

proc placeCodeBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/placeCodeBlock/BP/placeCodeBlock.json"
    blockTemplate(name, root, works, mainJson, "stone", true)
    return