import common/blockTemplate

proc craftingBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/craftingBlock/BP/craftingBlock.json"
    blockTemplate(name, root, works, mainJson, "stone", false)