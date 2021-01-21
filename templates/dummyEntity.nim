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
  os.setCurrentDir("entities")

  #load BP template
  os.setCurrentDir(root)
  var dummyFileName = "./templates/BP/dummyEntity.txt"
  var dummyString = fmt"./{works}/BP/entities/{name}.json"
  var dummy = readFile(dummyFileName)
  var dummy2 = replace(dummy, "$name", name)
  writeFile(dummyString, dummy2)
  echo name % " saved as " % name % ".json"
  os.setCurrentDir(works)
  return
