import common/itemTemplate

proc oldItem*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    var mainJson = "./templates/oldItem/BP/oldItem.txt"
    var resourceJson = "./templates/oldItem/RP/oldItem.txt"
    var itemTexture = "./templates/common/RP/textures/evil.png"
    itemTemplate(name, root, works, nameCount, nameNumber, mainJson, resourceJson, itemTexture)
    return