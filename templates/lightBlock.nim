import common/blockTemplate

proc lightBlock*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    var mainJson = "./templates/lightBlock/BP/lightBlock.txt"
    blockTemplate(name, root, works, nameCount, nameNumber, mainJson, "glass", "glass", false)
    return