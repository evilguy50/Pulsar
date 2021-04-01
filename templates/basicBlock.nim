import common/blockTemplate

proc basicBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    var mainJson = "./templates/basicBlock/BP/basicBlock.txt"
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson, "stone", "stone", false)
    return