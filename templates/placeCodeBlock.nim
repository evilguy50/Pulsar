import common/blockTemplate

proc placeCodeBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    var mainJson = "./templates/placeCodeBlock/BP/placeCodeBlock.txt"
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson, "stone", "stone", true)
    return