import os
import strformat
import common/folderExist
import common/nameReplace
import common/textureJson
import common/tickJson
import common/langFiles

proc fakeArmor*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
    #generate BP folders
    folderExist("BP")
    folderExist("BP/items")
    folderExist("BP/functions")
    folderExist("BP/texts")

    #generate RP folders
    folderExist("RP")
    folderExist("RP/attachables")
    folderExist("RP/items")
    folderExist("RP/texts")
    folderExist("RP/textures")
    folderExist("RP/textures/armor")
    folderExist("RP/textures/items")

    #generate BP item
    os.setCurrentDir(root)
    var bpfakeArmor_file = "./templates/fakeArmor/BP/fakeArmor.txt"
    var bpfakeArmor_string = fmt"./{works}/BP/items/{name}_armor.json"
    nameReplace(bpfakeArmor_file,bpfakeArmor_string, name)

    #generate BP functions
    var fakeFunction_file = "./templates/fakeArmor/BP/fakeArmor_function.txt"
    var fakeFunction_string = fmt"./{works}/BP/functions/{name}_armor.mcfunction"
    nameReplace(fakeFunction_file, fakeFunction_string, name)

    #generate tick json entries
    var fakeArmor_item = fmt"{name}_armor"
    tickJson(works, fakeArmor_item, nameNumber, nameCount)

    #generate RP item
    var rpfakeArmor_file = "./templates/fakeArmor/RP/fakeArmor.txt"
    var rpfakeArmor_string = fmt"./{works}/RP/items/{name}_armor.json"
    nameReplace(rpfakeArmor_file, rpfakeArmor_string, name)

    #generate RP attachables
    var fakeAttach_file1 = "./templates/fakeArmor/RP/fakeArmor_attach1.txt"
    var fakeAttach_string1 = fmt"./{works}/RP/attachables/{name}_armor.json"
    nameReplace(fakeAttach_file1, fakeAttach_string1, name)

    var fakeAttach_file2 = "./templates/fakeArmor/RP/fakeArmor_attach2.txt"
    var fakeAttach_string2 = fmt"./{works}/RP/attachables/{name}_armor.player.json"
    nameReplace(fakeAttach_file2, fakeAttach_string2, name)

    #generate lang files
    var fakeLang_entry = fmt"item.evil:{name}_armor.name={name}_armor"
    bpLang(works, name)
    rpLang(works, name, fakeLang_entry)

    #generate textures
    var fakeTexture_file = "./templates/fakeArmor/RP/textures/evil.png"
    var fakeTexture_string = fmt"./{works}/RP/textures/armor/{name}_armor.png"
    var fakeIcon_file = "./templates/common/RP/textures/evil.png"
    var fakeIcon_string = fmt"./{works}/RP/textures/items/{name}_armor.png"
    copyFile(fakeTexture_file, fakeTexture_string)
    copyFile(fakeIcon_file, fakeIcon_string)

    #generate texture json entries
    textureJson(works, fakeArmor_item, nameNumber, nameCount, "item")
    
    os.setCurrentDir(works)
    return