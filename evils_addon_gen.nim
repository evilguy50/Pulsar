#import dependencies
import argparse
import os
import outputDir
import templates/dummyEntity


#define command line options
proc main(args: seq[string]) =
  var opts = newParser("evil's addon generator"):
    option("-t", "--templateGen")
    option("-o", "--outputDir")
    arg("names", nargs = -1)

#parse options
  var optGen = opts.parse(args)

#set output directory
  var root: string = os.getCurrentDir() % "/"
  setOutput(optGen.outputDir)

#generate dummy entities
  if optGen.templateGen == "dummyEntity":
    for dummies in optGen.names:
      dummyEntity(dummies, root, optGen.outputDir)

#load program
when isMainModule:
  main(commandLineParams())
