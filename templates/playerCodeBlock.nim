import common/blockTemplate

proc playerCodeBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/playerCodeBlock/BP/playerCodeBlock.json"
    blockTemplate(name, root, works, mainJson, "stone", true)