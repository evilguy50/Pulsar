import os
import strutils
import strformat

proc zombieEntity*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
  #setup BP folders
  echo "creating behaviour pack files for: ", name
  if os.dirExists("BP") == false:
    os.createDir("BP")
  os.setCurrentDir("BP")
  if os.dirExists("loot_tables") == false:
    os.createDir("loot_tables")
  if os.dirExists("loot_tables/entities") == false:
    os.createDir("loot_tables/entities")
  if os.dirExists("entities") == false:
    os.createDir("entities")
  if os.dirExists("texts") == false:
    os.createDir("texts")
  echo "generated behaviour folders"

  #generate BP template
  os.setCurrentDir(root)
  var zombieFileName = "./templates/zombieEntity/BP/zombieEntity.txt"
  var zombieString = fmt"./{works}/BP/entities/{name}.json"
  var zombieRead = readFile(zombieFileName)
  var zombieReplace = replace(zombieRead, "$name", name)
  writeFile(zombieString, zombieReplace)
  echo (name, " saved entity as ", name, ".json")

  var zombieLootFile = "./templates/zombieEntity/BP/zombieEntity_loot.txt"
  var zombieLootString = fmt"./{works}/BP/loot_tables/entities/{name}.json"
  var zombieLootRead = readFile(zombieLootFile)
  writeFile(zombieLootString, zombieLootRead)

  #setup RP folders
  os.setCurrentDir(works)
  echo "creating resource pack files for: ", name
  if os.dirExists("RP") == false:
    os.createDir("RP")
  os.setCurrentDir("RP")
  if os.dirExists("entity") == false:
    os.createDir("entity")
  if os.dirExists("models") == false:
    os.createDir("models")
  if os.dirExists("models/entity") == false:
    os.createDir("models/entity")
  if os.dirExists("render_controllers") == false:
    os.createDir("render_controllers")
  if os.dirExists("texts") == false:
    os.createDir("texts")
  if os.dirExists("textures") == false:
    os.createDir("textures")
  if os.dirExists("textures/entity") == false:
    os.createDir("textures/entity")
  if os.dirExists("textures/items") == false:
    os.createDir("textures/items")
  if os.dirExists("textures/items/egg") == false:
    os.createDir("textures/items/egg")
  os.setCurrentDir(root)
  echo "generated resource folders"

  #generate RP entities
  var zombieFileName2 = "./templates/zombieEntity/RP/zombieEntity.txt"
  var zombieString2 = fmt"./{works}/RP/entity/{name}.json"
  var zombieRead2 = readFile(zombieFileName2)
  var zombieReplace2 = replace(zombieRead2, "$name", name)
  writeFile(zombieString2, zombieReplace2)
  echo (name, " saved entity as ", name, ".json")

  #generate RP geometry
  var zombieFileName3 = "./templates/zombieEntity/RP/zombieEntity_geo.txt"
  var zombieString3 = fmt"./{works}/RP/models/entity/{name}.json"
  var zombieRead3 = readFile(zombieFileName3)
  var zombieReplace3 = replace(zombieRead3, "$name", name)
  writeFile(zombieString3, zombieReplace3)
  echo (name, " saved geometry as ", name, ".json")

  #generate RP render controller
  var zombieRenderFile = "./templates/zombieEntity/RP/zombieEntity_render.txt"
  var zombieRenderString = fmt"./{works}/RP/render_controllers/{name}.json"
  var zombieRenderRead = readFile(zombieRenderFile)
  var zombieRenderReplace = replace(zombieRenderRead, "$name", name)
  writeFile(zombieRenderString, zombieRenderReplace)
  echo (name, " saved render controller as ", name, ".json")

  #generate spawnegg texture
  var spawneggFileName = "./templates/common/RP/textures/evil.png"
  var spawneggString = fmt"./{works}/RP/textures/items/egg/{name}.png"
  copyFile(spawneggFileName, spawneggString)
  echo (name, " saved spawnegg as ", name, ".png")

  #generate entity texture
  var zombieTexture = "./templates/zombieEntity/RP/textures/zombieEntity.png"
  var zombieTextureString = fmt"./{works}/RP/textures/entity/{name}.png"
  copyFile(zombieTexture, zombieTextureString)
  echo (name, "saved entity as ", name, ".png")

  #
  #   language entries
  #

  #generate BP lang files
  var usSTb = "./templates/common/BP/texts/en_US.txt"  #create lang file
  var usLb = fmt"./{works}/BP/texts/en_US.lang"
  if os.fileExists(usLb) == false:
    var zombieRead4l = readFile(usSTb)
    var zombieReplace4l = replace(zombieRead4l, "$works", works)
    writeFile(usLb, zombieReplace4l)
  
  var langSTb = "./templates/common/BP/texts/languages.txt"  #create lang json file
  var langLb = fmt"./{works}/BP/texts/languages.json"
  if os.fileExists(langLb) == false:
    var zombieRead4j = readFile(langSTb)
    var zombieReplace4j = replace(zombieRead4j, "$none", works)
    writeFile(langLb, zombieReplace4j)
  echo "generated behaviour language files"

  #generate RP lang files
  var usSTr = "./templates/common/RP/texts/en_US.txt"  #create lang file
  var usLr = fmt"./{works}/RP/texts/en_US.lang"
  if os.fileExists(usLr) == false:
    var zombieRead5l = readFile(usSTr)
    var zombieReplace5l = replace(zombieRead5l, "$works", works)
    writeFile(usLr, zombieReplace5l)
  
  var langSTr = "./templates/common/RP/texts/languages.txt"  #create lang json
  var langLr = fmt"./{works}/RP/texts/languages.json"
  if os.fileExists(langLr) == false:
    var zombieRead5j = readFile(langSTr)
    var zombieReplace5j = replace(zombieRead5j, "$works", works)
    writeFile(langLr, zombieReplace5j)
  echo "generated resource language files"

  #populate entity entites
  var langEntry = open(usLr, fmAppend)
  var entityEntry = fmt"entity.evil:{name}.name={name}"
  var breakEntry = "\n"
  write(langEntry, entityEntry)
  write(langEntry, breakEntry)
  echo ("added language entry for entity ", name)

  #populate spawnegg entries
  var spawneggEntry = fmt"item.spawn_egg.entity.evil:{name}.name={name}"
  write(langEntry, spawneggEntry)
  write(langEntry, breakEntry)
  close(langEntry)
  echo ("added language entry for spawnegg ", name)

  #
  # generate texture json
  #
  var textureJsonTemplate = fmt"./{works}/RP/textures/item_texture.json"
  var textureJsonRerun = fmt"./{works}/RP/textures/item_texture2.json"
  var newJson: bool = false
  if os.fileExists(textureJsonTemplate) == false:
    var textureJson = readFile("./templates/common/RP/entity_textures.txt")
    var textureJsonGen = replace(textureJson, "$works", works)
    var textureJsonGen2 = replace(textureJsonGen, "$name", name)
    writeFile(textureJsonTemplate, textureJsonGen2)
    newJson = true
  elif newJson == false and nameNumber == 1:
    copyFile(textureJsonTemplate, textureJsonRerun)
    var oldRead = readFile(textureJsonRerun)
    var oldReplace = replace(oldRead, "}}", "")
    removeFile(textureJsonTemplate)
    writeFile(textureJsonTemplate, oldReplace)
    removeFile(textureJsonRerun)
  if newJson == false:
    var textureJsonPopulate = open(textureJsonTemplate, fmAppend)
    var textureEntryRead = readFile("./templates/common/RP/entity_textureEntry.txt")
    var textureEntry = replace(textureEntryRead, "$name", name)
    write(textureJsonPopulate, textureEntry)
    close(textureJsonPopulate)
  if nameNumber >= nameCount:
    var textureJsonPopulate2 = open(textureJsonTemplate, fmAppend)
    var textureEnd = "}}"
    write(textureJsonPopulate2, textureEnd)

  os.setCurrentDir(works)

  return
