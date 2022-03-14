import uuids
import os
import strformat
import strutils
proc manifest*(works: string, root: string)=
    os.setCurrentDir(root)
    #setup directory placeholders
    var resourceTemplate = "./templates/common/RP/RPmanifest.json"
    var behaviourTemplate = "./templates/common/BP/BPmanifest.json"

    #generate uuid
    var uuid1 = genUUID()
    var uuid2 = genUUID()
    var uuid3 = genUUID()
    var uuid4 = genUUID()
    #convert uuid to string
    var uuid1s = $uuid1
    var uuid2s = $uuid2
    var uuid3s = $uuid3
    var uuid4s = $uuid4

    if os.fileExists(fmt"./{works}/RP/manifest.json") == false:
        #replace placholders
        var rpRead = readFile(resourceTemplate)
        var rpReplace = replace(rpRead, "$works", works)
        var rpReplace2 = replace(rpReplace, "$uuid1", uuid1s)
        var rpReplace3 = replace(rpReplace2, "$uuid2", uuid2s)
        writeFile(fmt"./{works}/RP/manifest.json", rpReplace3)

    if os.fileExists(fmt"./{works}/BP/manifest.json") == false:
        #replace placholders
        var bpRead = readFile(behaviourTemplate)
        var bpReplace = replace(bpRead, "$works", works)
        var bpReplace2 = replace(bpReplace, "$uuid3", uuid3s)
        var bpReplace3 = replace(bpReplace2, "$uuid4", uuid4s)
        var bpReplace4 = replace(bpReplace3, "$uuid1", uuid1s)
        writeFile(fmt"./{works}/BP/manifest.json", bpReplace4)
    return
    
