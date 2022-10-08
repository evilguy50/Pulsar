import includes

proc entityTemplate*(name: string, root: string, works: string, model: string, renderController: string,
 texture: string, loot: string, mainJson: string, resourceJson: string, trades: string) =

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


proc pulsarEntity*(name: string, root: string, works: string, model: string, renderController: string,
 texture: string, loot: string, mainJson: string, resourceJson: string, trades: string)=
  os.setCurrentDir(works)
  #setup BP folders
  folderExist("BP")
  folderExist("BP/entities")
  folderExist("BP/texts")
  if loot != "null":
    folderExist("BP/loot_tables")
    folderExist("BP/loot_tables/entities")
  if trades != "null":
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
  folderExist("RP/render_controllers")
  folderExist("RP/textures/entity")

  echo "generated resource folders"
  #generate BP template
  os.setCurrentDir(root)
  var entityString = fmt"./{works}/BP/entities/{name}.json"
  writeFile(entityString, mainJson.replace("$name", name))
  echo (name, " saved entity as ", name, ".json")

  #generate loot tables
  if loot != "null":
    var lootString = fmt"./{works}/BP/loot_tables/entities/{name}.json"
    writeFile(lootString, loot)
    echo name, " generated loottable as ", name, ".json"

  if trades != "null":
    var tradeString = fmt"./{works}/BP/trading/{name}.json"
    writeFile(tradeString, trades.replace("$name", name))
    echo (name, " generated trade table as ", name, ".json")

  #generate RP entities
  var resourceEntity = fmt"./{works}/RP/entity/{name}.json"
  writeFile(resourceEntity, resourceJson.replace("$name", name))
  echo (name, " saved entity as ", name, ".json")

  #generate RP geometry
  var modelString = fmt"./{works}/RP/models/entity/{name}.json"
  writeFile(modelString, model.replace("$name", name))
  echo (name, " saved geometry as ", name, ".json")

  #generate RP render controller
  var renderString = fmt"./{works}/RP/render_controllers/{name}.json"
  writeFile(renderString, renderController.replace("$name", name))
  echo (name, " generated render controller as ", name, ".json")

  #generate entity texture
  if texture != "null":
    var textureString = fmt"./{works}/RP/textures/entity/{name}.png"
    writeFile(textureString, texture)
    echo (name, "generated entity as ", name, ".png")

  #generate spawnegg texture
  var spawneggFileName = "./templates/common/RP/textures/placeholder.png"
  var spawneggString = fmt"./{works}/RP/textures/items/egg/{name}.png"
  writeFile(spawneggString, spawneggFileName)
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
  os.setCurrentDir(root)