import os

proc folderExist*(folder: string) =
    if os.dirExists(folder) == false:
        os.createDir(folder)