import common/blockTemplate

proc lightBlock*(name: string, root: string, works: string)=
    var mainJson = "./templates/lightBlock/BP/lightBlock.txt"
    blockTemplate(name, root, works, mainJson, "glass", false)
    return