# addon-generator
Template based add-on generator for minecraft bedrock edition written in nim.

No license is provided with this software. You are free to make any add-ons you want as long you don't make money off of them.

What this program can do so far:
	
	set project output directory.

	run template for each name provided in a list.

	generate behaviour pack entity file for the dummyEntity template. 
	
	generate resource pack entity file for the dummyEntity template.
	
	generate resource pack entity geometry file for the dummyEntity template.
	
To do:
	
	finish the dummyEntity template.
	
	setup pack manifest generation with linked uuids.
	
	setup spawnegg color randomizer
	
How to compile:
	
	nim compile ./evils_addon_gen.nim

nim dependencies:
	
	os
	strutils
	strformat
	argparse
	
usage:
	
	./evils_addon_gen -o outputdirname -t templatename names
