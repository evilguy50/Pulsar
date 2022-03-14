import os
import json
import strformat

proc tickJson*(works: string, name: string)=
    var functions_txt = "./templates/common/BP/tickJson.json"
    var functionJsonTemplate = fmt"./{works}/BP/functions/tick.json"
    if os.fileExists(functionJsonTemplate) == false:
        writeFile(functionJsonTemplate, functions_txt)
    var funcJson = readFile(functions_txt).parseJson()
    funcJson["values"].add(newJString(name))
    writeFile(functionJsonTemplate, funcJson.pretty())
