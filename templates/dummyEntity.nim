import os
import strformat
import common/folderExist
import common/nameReplace
import common/langFiles
import common/textureJson

proc dummyEntity*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
  #setup BP folders
  folderExist("BP")
  folderExist("BP/entities")
  folderExist("BP/texts")
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
  echo "generated resource folders"

  #generate BP template
  os.setCurrentDir(root)
  var dummyFileName = "./templates/dummyEntity/BP/dummyEntity.txt"
  var dummyString = fmt"./{works}/BP/entities/{name}.json"
  nameReplace(dummyFileName, dummyString, name)
  echo (name, " saved entity as ", name, ".json")

  #generate RP entities
  var dummyFileName2 = "./templates/dummyEntity/RP/dummyEntity.txt"
  var dummyString2 = fmt"./{works}/RP/entity/{name}.json"
  nameReplace(dummyFileName2, dummyString2, name)
  echo (name, " saved entity as ", name, ".json")

  #generate RP geometry
  var dummyFileName3 = "./templates/dummyEntity/RP/dummyEntity_geo.txt"
  var dummyString3 = fmt"./{works}/RP/models/entity/{name}.json"
  nameReplace(dummyFileName3, dummyString3, name)
  echo (name, " saved geometry as ", name, ".json")

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