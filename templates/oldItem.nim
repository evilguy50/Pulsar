import common/itemTemplate

proc oldItem*(name: string, root: string, works: string)=
    var mainJson = "./templates/oldItem/BP/oldItem.txt"
    var resourceJson = "./templates/oldItem/RP/oldItem.txt"
    var itemTexture = "./templates/common/RP/textures/placeholder.png"
    itemTemplate(name, root, works, mainJson, resourceJson, itemTexture)
    return