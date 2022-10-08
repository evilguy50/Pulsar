#import dependencies
import os
import json
import argparse
import manifest
import outputDir
import packIcon
import strutils
import strformat
import templateList
import zippy/ziparchives
import nimpy
import "Assets/Settings/tempBox.nim"
import "templates/common/blockTemplate.nim"
import "templates/common/itemTemplate.nim"
import "templates/common/entityTemplate.nim"

proc eRead(z: string, path: string): string=
  var reader = openZipArchive(z)
  try:
    result = reader.extractFile(path)
  except:
    result = "null"
  reader.close()

#define command line options
proc generate*(outputDir: string, templateGen: string, nameStr: string) =
  var baseTemplate = false
  if templateGen in templateCheckList:
    baseTemplate = true
  var nameL = nameStr
  var names = split(nameL, " ", -1)

#count name arguments
  var nameCount = 0
  for i in names:
    inc(nameCount, 1)
  var nameNumber = 0
  
#set output directory
  var root: string = os.getCurrentDir() % "/"
  setOutput(outputDir)

  #standard templates
  if templateGen == "zombie_entity":
    for zombies in names:
      zombieEntity(zombies, root, outputDir)

  if templateGen == "dummy_entity":
    for dummies in names:
      dummyEntity(dummies, root, outputDir)

  if templateGen == "base_entity":
    for baseEnt in names:
      baseEntity(baseEnt, root, outputDir)
  
  if templateGen == "basic_block":
    for blocks in names:
      basicBlock(blocks, root, outputDir)

  if templateGen == "crafting_block":
    for craft in names:
      craftingBlock(craft, root, outputDir)

  if templateGen == "light_block":
    for lights in names:
      lightBlock(lights, root, outputDir)

  if templateGen == "place_code_block":
    for place in names:
      placeCodeBlock(place, root, outputDir)

  if templateGen == "player_code_block":
    for player in names:
      playerCodeBlock(player, root, outputDir)

  if templateGen == "click_block":
    for click in names:
      clickBlock(click, root, outputDir)

  if templateGen == "slab_block":
    for slabs in names:
      slabBlock(slabs, root, outputDir)

  if templateGen == "skull_block":
    for skulls in names:
      skullBlock(skulls, root, outputDir)
  
  if templateGen == "old_item":
    for items in names:
      oldItem(items, root, outputDir)

  if templateGen == "func_item":
    for funcItem in names:
      funcItem(funcItem, root, outputDir)

  if templateGen == "stair_block":
    for stairs in names:
      stairBlock(stairs, root, outputDir)

  #special templates
  if templateGen == "new_item":
    for itemN in names:
      inc(nameNumber, 1)
      newItem(itemN, root, outputDir, nameNumber)
  
  var invalid = false
  if baseTemplate == false:
    #python templates
    os.setCurrentDir(root)
    var pyTemplate = true
    if not fileExists("./User_templates/python/" & templateGen & "/" & templateGen & ".py"):
      pyTemplate = false
    if pyTemplate:
      var runner = pyImport(cstring("User_templates.python." & templateGen))
      os.setCurrentDir(outputDir)
      for pyN in names:
        inc(nameNumber, 1)
        echo "running python template: " & templateGen & "\nfor Name: " & pyN
        discard runner.`template`(@[pyN, root, outputDir].join(" "))

    #dynamic templates
    os.setCurrentDir(root)
    if fileExists(fmt"./User_templates/custom/Blocks/blocks/{templateGen}.json"):
      if fileExists(fmt"./User_templates/custom/Blocks/optional/geometry/{templateGen}.json"):
        os.setCurrentDir(outputDir)
        for i in names:
          inc(nameNumber, 1)
          tempBlockGeo(i, root, outputDir, templateGen)
      else:
        os.setCurrentDir(outputDir)
        for i in names:
          inc(nameNumber, 1)
          tempBlock(i, root, outputDir, templateGen)
    elif fileExists(fmt"./User_templates/custom/Entities/entity/BP/{templateGen}.json"):
      os.setCurrentDir(outputDir)
      for i in names:
        inc(nameNumber, 1)
        tempEntity(i, root, outputDir, templateGen)
    elif fileExists(fmt"./User_templates/custom/Items/items/{templateGen}.json"):
      os.setCurrentDir(outputDir)
      for i in names:
        inc(nameNumber, 1)
        tempItem(i, root, outputDir, templateGen)
    elif fileExists(fmt"./User_templates/imported/{templateGen}.pulsar"):
      var readZip = fmt"./User_templates/imported/{templateGen}.pulsar"
      var pZip = openZipArchive(readZip)
      var tempType = "null"
      try:
        for path in pZip.walkFiles:
          if path.contains("Blocks/blocks"):
            tempType = "block"
          elif path.contains("Items/items"):
            tempType = "item"
          elif path.contains("Entities/entity"):
            tempType = "entity"   
        pZip.close()
        case tempType:
        of "block":
          var mainBlock = readZip.eRead(fmt"Blocks/blocks/{templateGen}.json")
          var mainGeo = readZip.eRead(fmt"Blocks/optional/geometry/{templateGen}.json")
          var mainImg = readZip.eRead(fmt"Blocks/optional/geometry/textures/{templateGen}.png")
          var mainSound = readZip.eRead(fmt"Blocks/optional/sounds/{templateGen}.json")
          if mainSound == "null":
            mainSound = "stone"
          else:
            mainSound = mainSound.parseJson()["sound"].to(string)
          if mainGeo == "null":
            for pblock in names:
              pulsarBlock(pblock, root, outputDir, mainBlock, mainSound, false)
          else:
            for pblock in names:
              pulsarBlock(pblock, root, outputDir, mainBlock, mainSound, mainGeo, mainImg, false)
        of "item":
          var mainItem = readZip.eRead(fmt"Items/items/{templateGen}.json")
          var rItem = readZip.eRead(fmt"Items/optional/RP/{templateGen}.json")
          var itemTexture = readZip.eRead(fmt"Items/optional/texture/{templateGen}.png")
          if itemTexture == "null":
            itemTexture = readFile("./templates/common/RP/textures/placeholder.png")
          for pItem in names:
            pulsarItem(pItem, root, outputDir, mainItem, rItem, itemTexture)
        of "entity":
          var eMain = readZip.eRead(fmt"Entities/entity/BP/{templateGen}.json")
          var eResource = readZip.eRead(fmt"Entities/entity/RP/{templateGen}.json")
          var eModel = readZip.eRead(fmt"Entities/geometry/{templateGen}.json")
          var eTexture = readZip.eRead(fmt"Entities/geometry/textures/{templateGen}.png")
          var eRend = readZip.eRead(fmt"Entities/render/{templateGen}.json")
          var eloot = readZip.eRead(fmt"Entities/optional/loot/{templateGen}.json")
          var eTrade = readZip.eRead(fmt"Entities/optional/trades/{templateGen}.json")
          for pEntity in names:
            pulsarEntity(pEntity, root, outputDir, eModel, eRend, eTexture, eloot, eMain, eResource, eTrade)

      except:
        invalid = true
        echo "can't read " & fmt"./User_templates/imported/{templateGen}.pulsar"
        echo "error: " & getCurrentExceptionMsg()
        echo "dir: " & os.getCurrentDir()
      pZip.close()

  os.setCurrentDir(root)
  if not invalid:
    manifest(outputDir, root)
    packIcon(outputDir)

proc cli*(args: seq[string]) =
  var opts = newParser("Pulsar"):
    nohelpflag()
    #im using my own help flag.
    option("-t", "--templateGen")
    option("-o", "--outputDir")
    flag("-l", "--list")
    flag("-h", "--help")
    arg("names", nargs = -1)
  var optGen = opts.parse(args)
  if optGen.help:
    echo "Pulsar: Help Section.\n\n"
    echo "How to run: \n"
    echo ".\\pulsar_cli.exe -o (name of output folder) -t (template to use) (list of names)\n"
    quit("run it with -l to list all templates", 0)
  if optGen.list:
    var templateInfo = readFile("./template_info.json")
    echo templateInfo
    quit("run any of these templates with the -t option", 0)
  if optGen.help == false and optGen.list == false:
    var nameList: string = optGen.names[0]
    var nameInt = -1
    try:
      for a in optGen.names:
        inc(nameInt, 1)
        if nameInt > 0:
          nameList = nameList & fmt" {optGen.names[nameInt]}"
    except:
      echo "only 1 name was passed. Not merging list.\n"
    generate(optGen.outputDir, optGen.templateGen, nameList)
when isMainModule:
  cli(commandLineParams())
