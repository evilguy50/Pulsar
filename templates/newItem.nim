import common/itemTemplate
import strformat
import strutils

proc newItem*(name: string, root: string, works: string, nameNumber: int, cat: string, group: string)=
    var cat2 = cat
    var group2 = group
    var mainJson = "./templates/newItem/BP/newItem.txt"
    var resourceJson = "./templates/newItem/RP/newItem.txt"
    var itemTexture = "./templates/common/RP/textures/placeholder.png"
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
        itemTemplate(name, root, works, mainJson, resourceJson, itemTexture)
        var itemRead = readFile(itemJson)
        var catReplace = replace(itemRead, "$cat", cat2)
        var groupReplace = replace(catReplace, "$groupC", groupC)
        var groupReplaceC = replace(groupReplace, "$group", group2)
        writeFile(itemJson, groupReplaceC)

        var rpitemRead = readFile(rpitemJson)
        var rpitemReplace = replace(rpitemRead, "$cat", cat2)
        writeFile(rpitemJson, rpitemReplace)

        var langRead = readFile(langJson)
        var langReplace = replace(langRead, fmt"item.pulsar:{name}.name={name}", fmt"item.pulsar:{name}={name}")
        writeFile(langJson, langReplace)
    return