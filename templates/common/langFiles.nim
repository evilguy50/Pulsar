import os
import strutils
import strformat

proc bpLang*(works: string, name: string)=
    #generate BP language entries
    var bpLangFile = fmt"./{works}/BP/texts/en_US.lang"
    var bpLangTemplate = "./templates/common/BP/texts/en_US.txt"
    var bpLangJson = fmt"./{works}/BP/texts/languages.json"
    var bpLangJsonTemplate = "./templates/common/BP/texts/languages.txt"
    if os.fileExists(bpLangFile) == false:
        var bpLangRead = readFile(bpLangTemplate)
        var bpLangReplace = replace(bpLangRead, "$works", works)
        writeFile(bpLangFile, bpLangReplace)

    if os.fileExists(bpLangJson) == false:
        copyFile(bpLangJsonTemplate, bpLangJson)
    echo "setup behaviour languages files"

proc rpLang*(works: string, name: string, langEntry: string)= 
    #generate RP language entries
    var rpLangFile = fmt"./{works}/RP/texts/en_US.lang"
    var rpLangTemplate = "./templates/common/RP/texts/en_US.txt"
    var rpLangJson = fmt"./{works}/RP/texts/languages.json"
    var rpLangJsonTemplate = "./templates/common/RP/texts/languages.txt"

    if os.fileExists(rpLangFile) == false:
        var rpLangFileRead = readFile(rpLangTemplate)
        var rpLangFileReplace = replace(rpLangFileRead, "$works", works)
        writeFile(rpLangFile, rpLangFileReplace)

    if os.fileExists(rpLangJson) == false:
        var rpLangJsonRead = readFile(rpLangJsonTemplate)
        var rpLangJsonReplace = replace(rpLangJsonRead, "$works", works)
        writeFile(rpLangJson, rpLangJsonReplace)
    echo "setup resource languages files"

    #populate block lang entries
    var blockLangRead = open(rpLangFile, fmAppend)
    write(blockLangRead, langEntry)
    write(blockLangRead, "\n")
    close(blockLangRead)
    echo name, " populated language entries for ", name
