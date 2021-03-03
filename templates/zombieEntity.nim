import os
import strformat
import common/folderExist
import common/nameReplace
import common/langFiles
import common/textureJson

proc zombieEntity*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
  #setup BP folders
  folderExist("BP")
  folderExist("BP/loot_tables")
  folderExist("BP/loot_tables/entities")
  folderExist("BP/entities")
  folderExist("BP/texts")
  echo "generated behaviour folders"

  #setup RP folders 
  folderExist("RP")
  folderExist("RP/entity")
  folderExist("RP/models")
  folderExist("RP/models/entity")
  folderExist("RP/render_controllers")
  folderExist("RP/texts")
  folderExist("RP/textures")
  folderExist("RP/textures/entity")
  folderExist("RP/textures/items")
  folderExist("RP/textures/items/egg")
  echo "generated resource folders"

    #generate BP template
  os.setCurrentDir(root)
  var zombieFileName = "./templates/zombieEntity/BP/zombieEntity.txt"
  var zombieString = fmt"./{works}/BP/entities/{name}.json"
  nameReplace(zombieFileName, zombieString, name)
  echo name, " generated entity as ", name, ".json"

  var zombieLootFile = "./templates/zombieEntity/BP/zombieEntity_loot.txt"
  var zombieLootString = fmt"./{works}/BP/loot_tables/entities/{name}.json"
  copyFile(zombieLootFile, zombieLootString)
  echo name, " generated loottable as ", name, ".json"

  #generate RP entities
  var zombieFileName2 = "./templates/zombieEntity/RP/zombieEntity.txt"
  var zombieString2 = fmt"./{works}/RP/entity/{name}.json"
  nameReplace(zombieFileName2, zombieString2, name)
  echo (name, " generated entity as ", name, ".json")

  #generate RP geometry
  var zombieFileName3 = "./templates/zombieEntity/RP/zombieEntity_geo.txt"
  var zombieString3 = fmt"./{works}/RP/models/entity/{name}.json"
  nameReplace(zombieFileName3, zombieString3, name)
  echo (name, " generated geometry as ", name, ".json")

  #generate RP render controller
  var zombieRenderFile = "./templates/zombieEntity/RP/zombieEntity_render.txt"
  var zombieRenderString = fmt"./{works}/RP/render_controllers/{name}.json"
  nameReplace(zombieRenderFile, zombieRenderString, name)
  echo (name, " generated render controller as ", name, ".json")

  #generate spawnegg texture
  var spawneggFileName = "./templates/common/RP/textures/evil.png"
  var spawneggString = fmt"./{works}/RP/textures/items/egg/{name}.png"
  copyFile(spawneggFileName, spawneggString)
  echo (name, " generated spawnegg as ", name, ".png")

  #generate entity texture
  var zombieTexture = "./templates/zombieEntity/RP/textures/zombieEntity.png"
  var zombieTextureString = fmt"./{works}/RP/textures/entity/{name}.png"
  copyFile(zombieTexture, zombieTextureString)
  echo (name, "generated entity as ", name, ".png")

  #generate BP lang files
  bpLang(works, name)

  #generate RP lang files
  var entityEntry = fmt"entity.evil:{name}.name={name}"
  var spawneggEntry = fmt"item.spawn_egg.entity.evil:{name}.name={name}"
  rpLang(works, name, entityEntry)
  rpLang(works, name, spawneggEntry)
  echo ("added language entry for entity ", name)
  echo ("added language entry for spawnegg ", name)

  textureJson(works, name, nameNumber, nameCount, "entity")
  os.setCurrentDir(works)

  return