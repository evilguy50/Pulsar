import common/itemTemplate
import strformat
import strutils
import os

proc newItem*(name: string, root: string, works: string, nameCount: int, nameNumber: int, cat: string, group: string)=
    var cat2 = cat
    var group2 = group
    var mainJson = "./templates/newItem/BP/newItem.txt"
    var resourceJson = "./templates/newItem/RP/newItem.txt"
    var itemTexture = "./templates/common/RP/textures/evil.png"
    var itemJson = fmt"./BP/items/{name}.json"
    var rpitemJson = fmt"./RP/items/{name}.json"
    var langJson = "./RP/texts/en_US.lang"
    if cat2 == "none":
        cat2 = "Nature"
    var groupC = """
    "minecraft:creative_category": {
        "parent": "itemGroup.name.$group"
      },
    """
    if group2 == "none":
        groupC = ""
    if nameNumber >= 3:
        itemTemplate(name, root, works, nameCount, nameNumber, mainJson, resourceJson, itemTexture)
        
        var itemRead = readFile(itemJson)
        var catReplace = replace(itemRead, "$cat", cat2)
        var groupReplace = replace(catReplace, "$groupC", groupC)
        var groupReplaceC = replace(groupReplace, "$group", group2)
        os.removeFile(itemJson)
        writeFile(itemJson, groupReplaceC)

        var rpitemRead = readFile(rpitemJson)
        var rpitemReplace = replace(rpitemRead, "$cat", cat2)
        os.removeFile(rpitemJson)
        writeFile(rpitemJson, rpitemReplace)

        var langRead = readFile(langJson)
        var langReplace = replace(langRead, fmt"item.evil:{name}.name={name}", fmt"item.evil:{name}={name}")
        os.removeFile(langJson)
        writeFile(langJson, langReplace)
    return