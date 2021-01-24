# addon-generator
Template based add-on generator for minecraft bedrock edition written in nim.

No license is provided with this software. You are free to make any add-ons you want as long you don't make money off of them.

What this program can do so far:
	
	set project output directory.

	run template for each name provided in a list.

	generate addon for dummyEntity template. (Note: pack manifest generation not finished. so you will need to make a pack manifest file)
	
	run the dummyEntity template multiple times in the same output directory
	
To do:
	
	setup pack manifest generation with linked uuids.
	
How to compile:
	
	nim compile ./evils_addon_gen.nim

nim dependencies:
	
	os
	strutils
	strformat
	argparse
	
usage:
	
	./evils_addon_gen -o outputdirname -t templatename names
