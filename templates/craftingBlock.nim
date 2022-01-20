import common/blockTemplate

proc craftingBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/craftingBlock/BP/craftingBlock.txt"
    blockTemplate(name, root, works, mainJson, "stone", false)
    return