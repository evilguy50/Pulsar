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
  if os.dirExists("texts") == false:
    os.createDir("texts")

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

  #
  #   language entries
  #

  #generate BP lang files
  os.setCurrentDir(root)
  var usSTb = "./templates/BP/texts/en_US.txt"  #create lang file
  var usLb = fmt"./{works}/BP/texts/en_US.lang"
  if os.fileExists(usLb) == false:
    var dummyRead4l = readFile(usSTb)
    var dummyReplace4l = replace(dummyRead4l, "$works", works)
    writeFile(usLb, dummyReplace4l)
  
  var langSTb = "./templates/BP/texts/languages.txt"  #create lang json file
  var langLb = fmt"./{works}/BP/texts/languages.json"
  if os.fileExists(langLb) == false:
    var dummyRead4j = readFile(langSTb)
    var dummyReplace4j = replace(dummyRead4j, "$none", works)
    writeFile(langLb, dummyReplace4j)
  os.setCurrentDir(works)

  #generate RP lang files
  os.setCurrentDir(root)
  var usSTr = "./templates/RP/texts/en_US.txt"  #create lang file
  var usLr = fmt"./{works}/RP/texts/en_US.lang"
  if os.fileExists(usLr) == false:
    var dummyRead5l = readFile(usSTr)
    var dummyReplace5l = replace(dummyRead5l, "$works", works)
    writeFile(usLr, dummyReplace5l)
  
  var langSTr = "./templates/RP/texts/languages.txt"  #create lang json
  var langLr = fmt"./{works}/RP/texts/languages.json"
  if os.fileExists(langLr) == false:
    var dummyRead5j = readFile(langSTr)
    var dummyReplace5j = replace(dummyRead5j, "$works", works)
    writeFile(langLr, dummyReplace5j)

  #populate entites
  var langEntry = open(usLr, fmAppend)
  var entityEntry = fmt"entity.evil:{name}.name={name}"
  var breakEntry = "\n"
  write(langEntry, entityEntry)
  write(langEntry, breakEntry)
  close(langEntry)
  

  os.setCurrentDir(works)

  return
