#import dependencies
import argparse
import os
import manifest
import outputDir
import packIcon
import templateList

#define command line options
proc main(args: seq[string]) =
  var opts = newParser("evil's addon generator"):
    nohelpflag()
    #im using my own help flag.
    option("-t", "--templateGen")
    option("-o", "--outputDir")
    option("-b", "--base")
    option("--mainJson")
    option("--resourceJson")
    option("--mainSound")
    option("--soundEntry")
    option("--geometry")
    option("--geometryTexture")
    option("--itemTexture")
    option("--loot")
    option("--render")
    flag("--useFunction")
    flag("-l", "--list")
    flag("-h", "--help")
    arg("names", nargs = -1)

#parse options
  var optGen = opts.parse(args)

  if optGen.list:
    echo "All templates with a $ symbol in the description require experimental world features.\n\n"
    echo "dummyEntity :	Generates a dummy entity with no model / texture that can be used for map making.\n"
    echo "zombieEntity :	Generates a zombie that won't turn into a drowned. (uses standard zombie skin file)\n"
    echo "basicBlock :	Generates a basic block.\n"
    echo "slabBlock : $	Generates a slab block. \n"
    echo "skullBlock: $	Generates a player skull. (uses standard steve skin file)\n"
    echo "basicItem :	Generates a basic item. (it does nothing, but it can be used in other addons.)\n"
    echo "fakeArmor : Generates fake armor. (an item that applies a skin to the player when you apply the $name_armor tag. (example: test_armor))\n"
    echo "lightBlock : Generates a block that lights up\n"
    echo "placeCodeBlock : $ Generates a block that runs a function from the block when placed\n"
    echo "playerCodeBlock : $ Generates a block that runs a function from the player that placed it\n"
    quit("run any of these templates with the -t option", 0)

  if optGen.help:
    echo "evil's Addon Generator: Help Section.\n\n"
    echo "How to run: \n"
    echo "windows: .\\evils_addon_generator.exe -o (name of output folder) -t (template to use) (list of names)\n"
    echo "linux: ./evils_addon_generator -o (name of output folder) -t (template to use) (list of names)\n\n"
    quit("run it with -l to list all templates", 0)
    

#count name arguments
  var nameCount = 0
  for i in optGen.names:
    inc(nameCount, 1)
  var nameNumber = 0
  
#set output directory
  var root: string = os.getCurrentDir() % "/"
  setOutput(optGen.outputDir)


  #standard templates
  if optGen.templateGen == "zombieEntity":
    for zombies in optGen.names:
      inc(nameNumber, 1)
      zombieEntity(zombies, root, optGen.outputDir, nameCount, nameNumber)

  if optGen.templateGen == "dummyEntity":
    for dummies in optGen.names:
      inc(nameNumber, 1)
      dummyEntity(dummies, root, optGen.outputDir, nameCount, nameNumber)
  
  if optGen.templateGen == "basicBlock":
    for blocks in optGen.names:
      inc(nameNumber, 1)
      basicBlock(blocks, root, optGen.outputDir, nameCount, nameNumber)

  if optGen.templateGen == "lightBlock":
    for lights in optGen.names:
      inc(nameNumber, 1)
      lightBlock(lights, root, optGen.outputDir, nameCount, nameNumber)

  if optGen.templateGen == "placeCodeBlock":
    for place in optGen.names:
      inc(nameNumber, 1)
      placeCodeBlock(place, root, optGen.outputDir, nameCount, nameNumber)

  if optGen.templateGen == "playerCodeBlock":
    for player in optGen.names:
      inc(nameNumber, 1)
      playerCodeBlock(player, root, optGen.outputDir, nameCount, nameNumber)

  if optGen.templateGen == "slabBlock":
    for slabs in optGen.names:
      inc(nameNumber, 1)
      slabBlock(slabs, root, optGen.outputDir, nameCount, nameNumber)

  if optGen.templateGen == "skullBlock":
    for skulls in optGen.names:
      inc(nameNumber, 1)
      skullBlock(skulls, root, optGen.outputDir, nameCount, nameNumber)
  
  if optGen.templateGen == "basicItem":
    for items in optGen.names:
      inc(nameNumber, 1)
      basicItem(items, root, optGen.outputDir, nameCount, nameNumber)

  if optGen.templateGen == "funcItem":
    for funcItem in optGen.names:
      inc(nameNumber, 1)
      funcItem(funcItem, root, optGen.outputDir, nameCount, nameNumber)

  if optGen.templateGen == "stairBlock":
    for stairs in optGen.names:
      inc(nameNumber, 1)
      stairBlock(stairs, root, optGen.outputDir, nameCount, nameNumber)

  #dynamic templates
  if optGen.templateGen == "tempBlock":
    for temp_block in optGen.names:
      inc(nameNumber, 1)
      tempBlock(temp_block, root, optGen.outputDir, nameCount, nameNumber, optGen.mainJson,
       optGen.mainSound, optGen.soundEntry, optGen.useFunction, optGen.base)

  if optGen.templateGen == "tempBlock_geo":
    for temp_blockGeo in optGen.names:
      inc(nameNumber, 1)
      tempBlockGeo(temp_blockGeo, root, optGen.outputDir, nameCount, nameNumber, optGen.mainJson,
       optGen.mainSound, optGen.soundEntry, optGen.geometry, optGen.geometryTexture,
        optGen.useFunction, optGen.base)
    
  if optGen.templateGen == "tempEntity":
    for temp_entity in optGen.names:
      inc(nameNumber, 1)
      tempEntity(temp_entity, root, optGen.outputDir, nameCount, nameNumber, optGen.mainJson, optGen.resourceJson,
       optGen.geometry, optGen.geometryTexture, optGen.loot, optGen.render, optGen.base)

  if optGen.templateGen == "tempItem":
    for temp_item in optGen.names:
      inc(nameNumber, 1)
      tempItem(temp_item, root, optGen.outputDir, nameCount, nameNumber, optGen.mainJson, optGen.resourceJson,
      optGen.itemTexture, optGen.base)

  manifest(optGen.outputDir, root)
  packIcon(optGen.outputDir)

#load program
when isMainModule:
  main(commandLineParams())
