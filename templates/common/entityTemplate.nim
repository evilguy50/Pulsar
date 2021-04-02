import os
import strformat
import folderExist
import nameReplace
import langFiles
import textureJson

proc entityTemplate*(name: string, root: string, works: string, nameCount: int, nameNumber: int, model: string, renderController: string,
 texture: string, loot: string, mainJson: string, resourceJson: string)=

  #setup BP folders
  folderExist("BP")
  folderExist("BP/entities")
  folderExist("BP/texts")
  if loot != "none":
    folderExist("BP/loot_tables")
    folderExist("BP/loot_tables/entities")
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
    var zombieLootString = fmt"./{works}/BP/loot_tables/entities/{name}.json"
    copyFile(loot, zombieLootString)
    echo name, " generated loottable as ", name, ".json"

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
  var spawneggFileName = "./templates/common/RP/textures/evil.png"
  var spawneggString = fmt"./{works}/RP/textures/items/egg/{name}.png"
  copyFile(spawneggFileName, spawneggString)
  echo (name, " saved spawnegg as ", name, ".png")

  #generate BP lang files
  bpLang(works, name)

  #generate RP lang files
  var entityEntry = fmt"entity.evil:{name}.name={name}"
  rpLang(works, name, entityEntry)
  echo ("added language entry for entity ", name)

  #populate spawnegg entries
  var spawneggEntry = fmt"item.spawn_egg.entity.evil:{name}.name={name}"
  rpLang(works, name, spawneggEntry)
  echo ("added language entry for spawnegg ", name)

  # generate texture json
  textureJson(works, name, nameNumber, nameCount, "entity")
  echo name, " generated texture entry for ", name
  os.setCurrentDir(works)

  return