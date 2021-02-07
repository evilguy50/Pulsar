#import dependencies
import argparse
import os
import manifest
import outputDir
import packIcon
import templates/dummyEntity
import templates/basicBlock


#define command line options
proc main(args: seq[string]) =
  var opts = newParser("evil's addon generator"):
    option("-t", "--templateGen")
    option("-o", "--outputDir")
    arg("names", nargs = -1)

#parse options
  var optGen = opts.parse(args)

#count name arguments
  var nameCount = 0
  for i in optGen.names:
    inc(nameCount, 1)
  var nameNumber = 0
  
#set output directory
  var root: string = os.getCurrentDir() % "/"
  setOutput(optGen.outputDir)

#generate dummy entities
  if optGen.templateGen == "dummyEntity":
    for dummies in optGen.names:
      inc(nameNumber, 1)
      dummyEntity(dummies, root, optGen.outputDir, nameCount, nameNumber)
  
  if optGen.templateGen == "basicBlock":
    for blocks in optGen.names:
      inc(nameNumber, 1)
      basicBlock(blocks, root, optGen.outputDir, nameCount, nameNumber)

  manifest(optGen.outputDir, root)
  packIcon(optGen.outputDir)

#load program
when isMainModule:
  main(commandLineParams())
