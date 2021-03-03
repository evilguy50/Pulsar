import strutils

proc nameReplace*(templateFile: string, outputFile: string, name: string) =
    var read_file = readFile(templateFile)
    var replace_string = replace(readFile, "$name", name)
    writeFile(outputFile, replace_string)