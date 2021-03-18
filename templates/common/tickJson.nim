import os
import strutils
import strformat

proc tickJson*(works: string, name: string, nameNumber: int, nameCount:int)=
    var functions_txt = "./templates/common/BP/tickJson.txt"
    var functions_entry_txt = "./templates/common/BP/tickJson_entry.txt"
    var functionJsonTemplate = fmt"./{works}/BP/functions/tick.json"
    var functionJsonRerun = fmt"./{works}/BP/functions/tick2.json"
    var newJson: bool = false
    if os.fileExists(functionJsonTemplate) == false:
        var functionJson = readFile(functions_txt)
        var functionJsonGen = replace(functionJson, "$name", name)
        writeFile(functionJsonTemplate, functionJsonGen)
        newJson = true
    elif newJson == false and nameNumber == 1:
        copyFile(functionJsonTemplate, functionJsonRerun)
        var oldRead = readFile(functionJsonRerun)
        var oldReplace = replace(oldRead, "]}", "")
        removeFile(functionJsonTemplate)
        writeFile(functionJsonTemplate, oldReplace)
        removeFile(functionJsonRerun)
    if newJson == false:
        var functionJsonPopulate = open(functionJsonTemplate, fmAppend)
        var functionEntryRead = readFile(functions_entry_txt)
        var functionEntry = replace(functionEntryRead, "$name", name)
        write(functionJsonPopulate, functionEntry)
        close(functionJsonPopulate)
    if nameNumber >= nameCount:
        var functionJsonPopulate2 = open(functionJsonTemplate, fmAppend)
        var functionEnd = "]}"
        write(functionJsonPopulate2, functionEnd)