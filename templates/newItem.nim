import common/itemTemplate

proc newItem*(name, root, works: string, nameNumber: int)=
    var mainJson = "./templates/newItem/BP/newItem.json"
    var itemTexture = "./templates/common/RP/textures/placeholder.png"      
    itemTemplate(name, root, works, mainJson, "none", itemTexture)