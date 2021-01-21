import os
import strutils
import strformat

proc dummyEntity*(name: string, root: string, works: string)=
  #setup BP folders
  echo "creating behaviour pack files for: ", name
  if os.dirExists("BP") == false:
    os.createDir("BP")
  os.setCurrentDir("BP")
  if os.dirExists("entities") == false:
    os.createDir("entities")

  #generate BP template
  os.setCurrentDir(root)
  var dummyFileName = "./templates/BP/dummyEntity.txt"
  var dummyString = fmt"./{works}/BP/entities/{name}.json"
  var dummyRead = readFile(dummyFileName)
  var dummyReplace = replace(dummyRead, "$name", name)
  writeFile(dummyString, dummyReplace)
  echo (name, " saved entity as ", name, ".json")
  os.setCurrentDir(works)

  #setup RP folders
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

  #generate RP entities
  os.setCurrentDir(root)
  var dummyFileName2 = "./templates/RP/dummyEntity.txt"
  var dummyString2 = fmt"./{works}/RP/entity/{name}.json"
  var dummyRead2 = readFile(dummyFileName2)
  var dummyReplace2 = replace(dummyRead2, "$name", name)
  writeFile(dummyString2, dummyReplace2)
  echo (name, " saved entity as ", name, ".json")
  os.setCurrentDir(works)

  #generate RP geometry
  os.setCurrentDir(root)
  var dummyFileName3 = "./templates/RP/dummyEntity_geo.txt"
  var dummyString3 = fmt"./{works}/RP/models/entity/{name}.json"
  var dummyRead3 = readFile(dummyFileName3)
  var dummyReplace3 = replace(dummyRead3, "$name", name)
  writeFile(dummyString3, dummyReplace3)
  echo (name, " saved geometry as ", name, ".json")
  os.setCurrentDir(works)

  return
