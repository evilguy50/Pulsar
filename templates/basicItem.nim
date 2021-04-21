import common/itemTemplate

proc basicItem*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    var mainJson = "./templates/basicItem/BP/basicItem.txt"
    var resourceJson = "./templates/basicItem/RP/basicItem.txt"
    var itemTexture = "./templates/common/RP/textures/evil.png"
    itemTemplate(name, root, works, nameCount, nameNumber, mainJson, resourceJson, itemTexture)
    return