#import dependencies
import os
import argparse
import manifest
import outputDir
import packIcon
import strutils
import strformat
import templateList
import "Assets/Settings/tempBox.nim"

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
      inc(nameNumber, 1)
      zombieEntity(zombies, root, outputDir, nameCount, nameNumber)

  if templateGen == "dummy_entity":
    for dummies in names:
      inc(nameNumber, 1)
      dummyEntity(dummies, root, outputDir, nameCount, nameNumber)
  
  if templateGen == "basic_block":
    for blocks in names:
      inc(nameNumber, 1)
      basicBlock(blocks, root, outputDir, nameCount, nameNumber)

  if templateGen == "crafting_block":
    for craft in names:
      inc(nameNumber, 1)
      craftingBlock(craft, root, outputDir, nameCount, nameNumber)

  if templateGen == "light_block":
    for lights in names:
      inc(nameNumber, 1)
      lightBlock(lights, root, outputDir, nameCount, nameNumber)

  if templateGen == "place_code_block":
    for place in names:
      inc(nameNumber, 1)
      placeCodeBlock(place, root, outputDir, nameCount, nameNumber)

  if templateGen == "player_code_block":
    for player in names:
      inc(nameNumber, 1)
      playerCodeBlock(player, root, outputDir, nameCount, nameNumber)

  if templateGen == "slab_block":
    for slabs in names:
      inc(nameNumber, 1)
      slabBlock(slabs, root, outputDir, nameCount, nameNumber)

  if templateGen == "skull_block":
    for skulls in names:
      inc(nameNumber, 1)
      skullBlock(skulls, root, outputDir, nameCount, nameNumber)
  
  if templateGen == "old_item":
    for items in names:
      inc(nameNumber, 1)
      oldItem(items, root, outputDir, nameCount, nameNumber)

  if templateGen == "func_item":
    for funcItem in names:
      inc(nameNumber, 1)
      funcItem(funcItem, root, outputDir, nameCount, nameNumber)

  if templateGen == "stair_block":
    for stairs in names:
      inc(nameNumber, 1)
      stairBlock(stairs, root, outputDir, nameCount, nameNumber)

  #special templates
  if templateGen == "new_item":
    for itemN in names:
      inc(nameNumber, 1)
      newItem(itemN, root, outputDir, nameCount, nameNumber, names[0], names[1])
  
  #dynamic templates

  if baseTemplate == false:
    os.setCurrentDir(root)
    if fileExists(fmt"./User_templates/Blocks/blocks/{templateGen}.txt"):
      if fileExists(fmt"./User_templates/Blocks/optional/geometry/{templateGen}.txt"):
        os.setCurrentDir(outputDir)
        for i in names:
          inc(nameNumber, 1)
          tempBlockGeo(i, root, outputDir, nameCount, nameNumber, templateGen)
      else:
        os.setCurrentDir(outputDir)
        for i in names:
          inc(nameNumber, 1)
          tempBlock(i, root, outputDir, nameCount, nameNumber, templateGen)
    elif fileExists(fmt"./User_templates/Entities/entity/BP/{templateGen}.txt"):
      os.setCurrentDir(outputDir)
      for i in names:
        inc(nameNumber, 1)
        tempEntity(i, root, outputDir, nameCount, nameNumber, templateGen)
    elif fileExists(fmt"./User_templates/Items/items/BP/{templateGen}.txt"):
      os.setCurrentDir(outputDir)
      for i in names:
        inc(nameNumber, 1)
        tempItem(i, root, outputDir, nameCount, nameNumber, templateGen)

  manifest(outputDir, root)
  packIcon(outputDir)

proc cli(args: seq[string]) =
  var opts = newParser("evil's addon generator"):
    nohelpflag()
    #im using my own help flag.
    option("-t", "--templateGen")
    option("-o", "--outputDir")
    flag("-l", "--list")
    flag("-h", "--help")
    arg("names", nargs = -1)
  var optGen = opts.parse(args)
  if optGen.help:
    echo "evil's Addon Generator: Help Section.\n\n"
    echo "How to run: \n"
    echo ".\\evils_addon_cli.exe -o (name of output folder) -t (template to use) (list of names)\n"
    quit("run it with -l to list all templates", 0)
  if optGen.list:
    echo "All templates with a $ symbol in the description require experimental world features.\n\n"
    echo "dummy_entity :	Generates a dummy entity with no model / texture that can be used for map making.\n"
    echo "zombie_entity :	Generates a zombie that won't turn into a drowned. (uses standard zombie skin file)\n"
    echo "basic_block :	Generates a basic block.\n"
    echo "slab_block : $	Generates a slab block. \n"
    echo "stair_block : $	Generates a stair block. \n"
    echo "skull_block: $	Generates a player skull. (uses standard steve skin file)\n"
    echo "old_item :	Generates a basic item. (it does nothing, but it can be used in other addons.)\n"
    echo "new_item : $	Generates a basic item. (it does nothing, but it can be used in other addons.)\n supports 1.16.100+ features\n"
    echo "func_item : $ Generates an item that runs a function when used (item not consumed. add that to your function if you want it to be)"
    echo "light_block : Generates a block that lights up\n"
    echo "place_code_block : $ Generates a block that runs a function from the block when placed\n"
    echo "player_code_block : $ Generates a block that runs a function from the player that placed it\n"
    echo "crafting_block : $ Generates a new crafting table (only crafts recipes made for the specific table)"
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