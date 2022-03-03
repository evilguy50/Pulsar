import os
import strformat

proc packIcon*(works: string)=
    var icon = "./templates/common/RP/textures/placeholder.png"
    var bpIconFile = fmt"./{works}/BP/pack_icon.png"
    var rpIconFile = fmt"./{works}/RP/pack_icon.png"
    if os.fileExists(bpIconFile) == false:
        copyFile(icon, bpIconFile)
    if os.fileExists(rpIconFile) == false:
        copyFile(icon, rpIconFile)
    return