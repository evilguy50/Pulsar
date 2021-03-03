import os
import strutils
import strformat

proc dummyEntity*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
  #setup BP folders
  echo "creating behaviour pack files for: ", name
  if os.dirExists("BP") == false:
    os.createDir("BP")
  os.setCurrentDir("BP")
  if os.dirExists("entities") == false:
    os.createDir("entities")
  if os.dirExists("texts") == false:
    os.createDir("texts")
  echo "generated behaviour folders"

  #generate BP template
  os.setCurrentDir(root)
  var dummyFileName = "./templates/dummyEntity/BP/dummyEntity.txt"
  var dummyString = fmt"./{works}/BP/entities/{name}.json"
  var dummyRead = readFile(dummyFileName)
  var dummyReplace = replace(dummyRead, "$name", name)
  writeFile(dummyString, dummyReplace)
  echo (name, " saved entity as ", name, ".json")

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
  if os.dirExists("texts") == false:
    os.createDir("texts")
  if os.dirExists("textures") == false:
    os.createDir("textures")
  if os.dirExists("textures/items") == false:
    os.createDir("textures/items")
  if os.dirExists("textures/items/egg") == false:
    os.createDir("textures/items/egg")
  os.setCurrentDir(root)
  echo "generated resource folders"

  #generate RP entities
  var dummyFileName2 = "./templates/dummyEntity/RP/dummyEntity.txt"
  var dummyString2 = fmt"./{works}/RP/entity/{name}.json"
  var dummyRead2 = readFile(dummyFileName2)
  var dummyReplace2 = replace(dummyRead2, "$name", name)
  writeFile(dummyString2, dummyReplace2)
  echo (name, " saved entity as ", name, ".json")

  #generate RP geometry
  var dummyFileName3 = "./templates/dummyEntity/RP/dummyEntity_geo.txt"
  var dummyString3 = fmt"./{works}/RP/models/entity/{name}.json"
  var dummyRead3 = readFile(dummyFileName3)
  var dummyReplace3 = replace(dummyRead3, "$name", name)
  writeFile(dummyString3, dummyReplace3)
  echo (name, " saved geometry as ", name, ".json")


  #generate spawnegg texture
  var spawneggFileName = "./templates/common/RP/textures/evil.png"
  var spawneggString = fmt"./{works}/RP/textures/items/egg/{name}.png"
  copyFile(spawneggFileName, spawneggString)
  echo (name, " saved spawnegg as ", name, ".png")

  #
  #   language entries
  #

  #generate BP lang files
  var usSTb = "./templates/common/BP/texts/en_US.txt"  #create lang file
  var usLb = fmt"./{works}/BP/texts/en_US.lang"
  if os.fileExists(usLb) == false:
    var dummyRead4l = readFile(usSTb)
    var dummyReplace4l = replace(dummyRead4l, "$works", works)
    writeFile(usLb, dummyReplace4l)
  
  var langSTb = "./templates/common/BP/texts/languages.txt"  #create lang json file
  var langLb = fmt"./{works}/BP/texts/languages.json"
  if os.fileExists(langLb) == false:
    var dummyRead4j = readFile(langSTb)
    var dummyReplace4j = replace(dummyRead4j, "$none", works)
    writeFile(langLb, dummyReplace4j)
  echo "generated behaviour language files"

  #generate RP lang files
  var usSTr = "./templates/common/RP/texts/en_US.txt"  #create lang file
  var usLr = fmt"./{works}/RP/texts/en_US.lang"
  if os.fileExists(usLr) == false:
    var dummyRead5l = readFile(usSTr)
    var dummyReplace5l = replace(dummyRead5l, "$works", works)
    writeFile(usLr, dummyReplace5l)
  
  var langSTr = "./templates/common/RP/texts/languages.txt"  #create lang json
  var langLr = fmt"./{works}/RP/texts/languages.json"
  if os.fileExists(langLr) == false:
    var dummyRead5j = readFile(langSTr)
    var dummyReplace5j = replace(dummyRead5j, "$works", works)
    writeFile(langLr, dummyReplace5j)
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
