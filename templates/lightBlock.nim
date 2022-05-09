import common/blockTemplate

proc lightBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/lightBlock/BP/lightBlock.json"
    blockTemplate(name, root, works, mainJson, "glass", false)