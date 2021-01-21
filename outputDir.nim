import os

proc setOutput*(workDir: string)=
  if workDir != "":
    if os.dirExists(workDir) == false:
      os.createDir(workDir)
    os.setCurrentDir(workDir)
    var dirs: string = os.getCurrentDir()
    echo "Set project output folder to: ", dirs, "/"
    return