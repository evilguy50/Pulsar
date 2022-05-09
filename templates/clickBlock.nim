 import common/blockTemplate

proc clickBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/clickBlock/BP/clickBlock.json"
    blockTemplate(name, root, works, mainJson, "stone", true)