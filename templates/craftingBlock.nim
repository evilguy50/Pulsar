import common/blockTemplate

proc craftingBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    var mainJson = "./templates/craftingBlock/BP/craftingBlock.txt"
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson, "stone", "stone", false)
    return