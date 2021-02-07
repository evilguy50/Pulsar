# addon-generator
Template based add-on generator for minecraft bedrock edition written in nim.

No license is provided with this software. You are free to make any add-ons you want as long you don't make money off of them.

What this program can do so far:
	
	set project output directory.

	run template for each name provided in a list.

	generate addons based on templates.
	
To do:
	
	add more template types
	
template types:

	dummyEntity :	Generates a dummy entity with no model / texture that can be used for map making.
	basicBlock :	Generates a basic block. (all blocks use same template texture, all you have to do is change the textures ;P)
	
How to compile:
	
	nim compile ./evils_addon_gen.nim

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
	
	./evils_addon_gen -o outputdirname -t templatename names
	
	
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
