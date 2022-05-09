import os
import templates/common/folderExist

proc setOutput*(workDir: string)=
  if workDir != "":
    folderExist(workDir)
    os.setCurrentDir(workDir)
    var dirs: string = os.getCurrentDir()
    echo "Set project output folder to: ", dirs, "/"