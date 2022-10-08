import common/blockTemplate

proc basicBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/basicBlock/BP/basicBlock.json"
    blockTemplate(name, root, works, mainJson, "stone", false)