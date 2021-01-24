import uuids
import os
import strformat
import strutils
proc manifest*(works: string, root: string)=
    os.setCurrentDir(root)
    #setup directory placeholders
    var resourceTemplate = "./templates/RP/RPmanifest.txt"
    var resourceManifest = fmt"./{works}/RP/"
    var resourceManifestFile = resourceManifest % "manifest.json"
    var behaviourTemplate = "./templates/BP/BPmanifest.txt"
    var behaviourManifest = fmt"./{works}/BP/"
    var behaviourManifestFile = behaviourManifest % "manifest.json"

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

    if os.fileExists(resourceManifestFile) == false:
        #replace placholders
        var rpRead = readFile(resourceTemplate)
        var rpReplace = replace(rpRead, "$works", works)
        var rpReplace2 = replace(rpReplace, "$uuid1", uuid1s)
        var rpReplace3 = replace(rpReplace2, "$uuid2", uuid2s)
        os.setCurrentDir(resourceManifest)
        writeFile("manifest.json", rpReplace3)
        os.setCurrentDir(root)

    if os.fileExists(behaviourManifestFile) == false:
        #replace placholders
        var bpRead = readFile(behaviourTemplate)
        var bpReplace = replace(bpRead, "$works", works)
        var bpReplace2 = replace(bpReplace, "$uuid3", uuid3s)
        var bpReplace3 = replace(bpReplace2, "$uuid4", uuid4s)
        var bpReplace4 = replace(bpReplace3, "$uuid1", uuid1s)
        os.setCurrentDir(behaviourManifest)
        writeFile("manifest.json", bpReplace4)
        os.setCurrentDir(root)
    return
    
