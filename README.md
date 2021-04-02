# addon-generator
Template based add-on generator for minecraft bedrock edition written in nim.

What this program can do so far:
	
	set project output directory.

	run template for each name provided in a list.

	generate addons based on templates.
	
To do:
	
	add more template types
	
template types:

    All templates with a $ symbol in the description require experimental world features.
    dummyEntity :	Generates a dummy entity with no model / texture that can be used for map making.
    zombieEntity :	Generates a zombie that won't turn into a drowned. (uses standard zombie skin file)
    basicBlock :	Generates a basic block.
    slabBlock : $	Generates a slab block. 
    skullBlock: $	Generates a player skull. (uses standard steve skin file)
    basicItem :	Generates a basic item. (it does nothing, but it can be used in other addons.)
    fakeArmor : Generates fake armor. (an item that applies a skin to the player when you apply the $name_armor tag. (example: test_armor))
    lightBlock : Generates a block that lights up
    placeCodeBlock : $ Generates a block that runs a function from the block when placed
    playerCodeBlock : $ Generates a block that runs a function from the player that placed it
	
How to compile:

	linux: nim compile ./evils_addon_gen.nim
	windows: nim compile .\evils_addon_gen.nim

nim dependencies:
	
	Standard library:
	os
	strutils
	strformat
	
	Third party:
	argparse
		https://github.com/iffy/nim-argparse
	uuids
		https://github.com/pragmagic/uuids
	
usage:
	
	linux: ./evils_addon_gen -o outputdirname -t templatename names
	windows: .\evils_addon_gen.exe -o outputdirname -t templatename names
	
	
Open source licenses used:

Argparse:

	Copyright 2018 Matt Haggard

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

uuids:

	uuids - UUID library for Nim

	The MIT License

	Copyright (c) 2016 Xored Software Inc.

	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
	associated documentation files (the "Software"), to deal in the Software without restriction,
	including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
	and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
	subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all copies or substantial
	portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
	NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
	THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
