import nimpy
import templates/common/includes

proc blockTemplate(name: string, root: string, works: string,
 mainJson: string, soundJson: string,function: bool) {.exportpy.}=
    #create BP folders
    folderExist("BP")
    folderExist("BP/blocks")
    folderExist("BP/texts")
    folderExist("BP/loot_tables")
    folderExist("BP/loot_tables/blocks")
    echo "generated behaviour folders"

    #create RP folders
    folderExist("RP")
    folderExist("RP/textures")
    folderExist("RP/textures/blocks")
    folderExist("RP/texts")
    echo "generated resource folders"

    #define blocks in BP
    os.setCurrentDir(root)
    var bpBlockName = fmt"./{works}/BP/blocks/{name}.json"
    nameReplace(mainJson, bpBlockName, name)
    echo name, " generated block as ", name, ".json"

    #generate loot tables
    var lootTemplate = "./templates/common/BP/blockLoot.json"
    var lootFile = fmt"./{works}/BP/loot_tables/blocks/{name}.json"
    nameReplace(lootTemplate, lootFile, name)
    echo name, " generated loottable as ", name, ".json"

    os.setCurrentDir(works)
    if function == true:
       folderExist("BP/functions")
       var functionFile = fmt"./BP/functions/{name}.mcfunction"
       writeFile(functionFile, "")
    os.setCurrentDir(root)

    #generate block json for RP
    blockJson(works, name, soundJson)
    echo name, " generated block entry for ", name

    #generate texture json
    terrainJson(works, name)
    echo name, " generated texture entry for ", name

    #generate language files
    var rpLang_entry = fmt"tile.pulsar:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, rpLang_entry)
    echo name, " generated lang entries for ", name

    var blockTextureFile = "./templates/common/RP/textures/placeholder.png"
    var blockTextureString = fmt"./{works}/RP/textures/blocks/{name}.png"
    copyFile(blockTextureFile, blockTextureString)
    echo name, " generated texture as ", name, ".json"

    os.setCurrentDir(works)
    return

proc blockTemplate_geo(name: string, root: string, works: string,
 mainJson: string, soundJson: string, geometry: string, geometryTexture: string, function: bool) {.exportpy.}=
    var geometryTexture2 = geometryTexture

    #create BP folders
    folderExist("BP")
    folderExist("BP/blocks")
    folderExist("BP/texts")
    folderExist("BP/loot_tables")
    folderExist("BP/loot_tables/blocks")
    echo "generated behaviour folders"

    #create RP folders
    folderExist("RP")
    folderExist("RP/textures")
    folderExist("RP/textures/blocks")
    folderExist("RP/models")
    folderExist("RP/models/entity")
    folderExist("RP/texts")
    echo "generated resource folders"

    #define blocks in BP
    os.setCurrentDir(root)
    var bpBlockName = fmt"./{works}/BP/blocks/{name}.json"
    nameReplace(mainJson, bpBlockName, name)
    echo name, " generated block as ", name, ".json"

    #generate loot tables
    var lootTemplate = "./templates/common/BP/blockLoot.json"
    var lootFile = fmt"./{works}/BP/loot_tables/blocks/{name}.json"
    nameReplace(lootTemplate, lootFile, name)
    echo name, " generated loottable as ", name, ".json"

    if function == true:
       folderExist("BP/functions")
       var functionFile = fmt"./{works}/BP/functions/{name}.mcfunction"
       writeFile(functionFile, "")

    #generate block json for RP
    blockJson(works, name, soundJson)
    echo name, " generated block entry for ", name

    #generate texture json
    terrainJson(works, name)
    echo name, " generated texture entry for ", name

    #generate language files
    var rpLang_entry = fmt"tile.pulsar:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, rpLang_entry)
    echo name, " generated lang entries for ", name

    #generate block model
    var geoString = fmt"./{works}/RP/models/entity/{name}.json"
    nameReplace(geometry, geoString, name)
    
    var blockTextureString = fmt"./{works}/RP/textures/blocks/{name}.png"
    copyFile(geometryTexture2, blockTextureString)
    echo name, " generated texture as ", name, ".json"

    os.setCurrentDir(works)
    return

proc entityTemplate(name: string, root: string, works: string, model: string, renderController: string,
 texture: string, loot: string, mainJson: string, resourceJson: string, trades: string) {.exportpy.}=

  #setup BP folders
  folderExist("BP")
  folderExist("BP/entities")
  folderExist("BP/texts")
  if loot != "none":
    folderExist("BP/loot_tables")
    folderExist("BP/loot_tables/entities")
  if trades != "none":
    folderExist("BP/trading")
  echo "generated behaviour folders"

  #setup RP folders 
  folderExist("RP")
  folderExist("RP/entity")
  folderExist("RP/models")
  folderExist("RP/models/entity")
  folderExist("RP/texts")
  folderExist("RP/textures")
  folderExist("RP/textures/items")
  folderExist("RP/textures/items/egg")
  if renderController != "none":
    folderExist("RP/render_controllers")
    folderExist("RP/textures/entity")

  echo "generated resource folders"
  #generate BP template
  os.setCurrentDir(root)
  var entityString = fmt"./{works}/BP/entities/{name}.json"
  nameReplace(mainJson, entityString, name)
  echo (name, " saved entity as ", name, ".json")

  #generate loot tables
  if loot != "none":
    var lootString = fmt"./{works}/BP/loot_tables/entities/{name}.json"
    copyFile(loot, lootString)
    echo name, " generated loottable as ", name, ".json"

  if trades != "none":
    var tradeString = fmt"./{works}/BP/trading/{name}.json"
    nameReplace(trades, tradeString, name)
    echo (name, " generated trade table as ", name, ".json")

  #generate RP entities
  var resourceEntity = fmt"./{works}/RP/entity/{name}.json"
  nameReplace(resourceJson, resourceEntity, name)
  echo (name, " saved entity as ", name, ".json")

  #generate RP geometry
  var modelString = fmt"./{works}/RP/models/entity/{name}.json"
  nameReplace(model, modelString, name)
  echo (name, " saved geometry as ", name, ".json")

  #generate RP render controller
  if renderController != "none":
    var renderString = fmt"./{works}/RP/render_controllers/{name}.json"
    nameReplace(renderController, renderString, name)
    echo (name, " generated render controller as ", name, ".json")

  #generate entity texture
  if texture != "none":
    var textureString = fmt"./{works}/RP/textures/entity/{name}.png"
    copyFile(texture, textureString)
    echo (name, "generated entity as ", name, ".png")

  #generate spawnegg texture
  var spawneggFileName = "./templates/common/RP/textures/placeholder.png"
  var spawneggString = fmt"./{works}/RP/textures/items/egg/{name}.png"
  copyFile(spawneggFileName, spawneggString)
  echo (name, " saved spawnegg as ", name, ".png")

  #generate BP lang files
  bpLang(works, name)

  #generate RP lang files
  var entityEntry = fmt"entity.pulsar:{name}.name={name}"
  rpLang(works, name, entityEntry)
  echo ("added language entry for entity ", name)

  #populate spawnegg entries
  var spawneggEntry = fmt"item.spawn_egg.entity.pulsar:{name}.name={name}"
  rpLang(works, name, spawneggEntry)
  echo ("added language entry for spawnegg ", name)

  # generate texture json
  textureJson(works, name, "entity")
  echo name, " generated texture entry for ", name
  os.setCurrentDir(works)

  return

proc itemTemplate(name: string, root: string, works: string,
 mainJson: string, resourceJson: string, itemTexture: string) {.exportpy.}=
    #setup BP folders
    folderExist("BP")
    folderExist("BP/texts")
    folderExist("BP/items")
    echo "generated behaviour folders"

    #setup RP folders
    folderExist("RP")
    folderExist("RP/texts")
    if resourceJson != "none":
      folderExist("RP/items")
    folderExist("RP/textures")
    folderExist("RP/textures/items")
    echo "generated resource folders"
    
    os.setCurrentDir(root)

    #generate BP item
    var itemString = fmt"./{works}/BP/items/{name}.json"
    nameReplace(mainJson, itemString, name)
    echo name, " generated BP item as ", name, ".json"

    #generate RP item
    if resourceJson != "none":
      var resourceItem = fmt"./{works}/RP/items/{name}.json"
      nameReplace(resourceJson, resourceItem, name)
      echo name, " generated RP item as ", name, ".json"

    #generate texture
    var itemFile = fmt"./{works}/RP/textures/items/{name}.png"
    copyFile(itemTexture, itemFile)
    echo name, " generated item texture as ", name, ".png"

    #generate texture json
    textureJson(works, name, "item")
    echo name, " generated texture json entry for ", name

    #generate lang files
    var itemEntry = fmt"item.pulsar:{name}.name={name}"
    bpLang(works, name)
    rpLang(works, name, itemEntry)
    echo name, " generated item lang entry for ", name
    
    os.setCurrentDir(works)
    return

proc folderExist(folder: string) {.exportpy.}=
    if os.dirExists(folder) == false:
        os.createDir(folder)

proc nameReplace(templateFile: string, outputFile: string, name: string) {.exportpy.}=
    var read_file = readFile(templateFile)
    var replace_string = replace(readFile, "$name", name)
    writeFile(outputFile, replace_string)

proc textureJson(works: string, name: string, templateType: string) {.exportpy.}=
    var textures_txt = "./templates/common/RP/item_textures.json"
    var textures_entry_txt: string
    if templateType == "entity":
        textures_entry_txt = "textures/items/egg/" & name
    elif templateType == "item":
        textures_entry_txt = "textures/items/" & name
    var textureJson = fmt"./{works}/RP/textures/item_texture.json"
    var txtJson: JsonNode
    if not os.fileExists(textureJson):
        writeFile(textureJson, textures_txt)
        txtJson = readFile(textures_txt).parseJson()
    else:
        txtJson = readFile(textureJson).parseJson()
    txtJson["texture_data"].add(name, newJObject())
    txtJson["texture_data"][name].add("textures", newJString(textures_entry_txt))
    writeFile(textureJson, txtJson.pretty().replace("$works", works))

proc tickJson(works: string, name: string) {.exportpy.}=
    var functions_txt = "./templates/common/BP/tickJson.json"
    var functionJsonTemplate = fmt"./{works}/BP/functions/tick.json"
    if os.fileExists(functionJsonTemplate) == false:
        writeFile(functionJsonTemplate, functions_txt)
    var funcJson = readFile(functions_txt).parseJson()
    funcJson["values"].add(newJString(name))
    writeFile(functionJsonTemplate, funcJson.pretty())