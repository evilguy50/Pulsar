import common/blockTemplate

proc playerCodeBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    var mainJson = "./templates/playerCodeBlock/BP/playerCodeBlock.txt"
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson, "stone", "stone", true)
    return