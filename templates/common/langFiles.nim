import os
import strutils
import strformat

proc bpLang*(works: string, name: string)=
    #generate BP language entries
    var bpLangFile = fmt"./{works}/BP/texts/en_US.lang"
    var bpLangTemplate = "./templates/common/BP/texts/en_US.json"
    var bpLangJson = fmt"./{works}/BP/texts/languages.json"
    var bpLangJsonTemplate = "./templates/common/BP/texts/languages.json"
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
    var rpLangTemplate = "./templates/common/RP/texts/en_US.json"
    var rpLangJson = fmt"./{works}/RP/texts/languages.json"
    var rpLangJsonTemplate = "./templates/common/RP/texts/languages.json"

    if not os.fileExists(rpLangFile):
        var rpLangFileRead = readFile(rpLangTemplate)
        var rpLangFileReplace = replace(rpLangFileRead, "$works", works)
        writeFile(rpLangFile, rpLangFileReplace)

    if not os.fileExists(rpLangJson):
        var rpLangJsonRead = readFile(rpLangJsonTemplate)
        var rpLangJsonReplace = replace(rpLangJsonRead, "$works", works)
        writeFile(rpLangJson, rpLangJsonReplace)
    echo "setup resource languages files"

    #populate block lang entries
    var blockLangRead = readFile(rpLangFile).split("\n")
    blockLangRead.add(langEntry)
    rpLangFile.writeFile(blockLangRead.join("\n"))
    echo name, " populated language entries for ", name