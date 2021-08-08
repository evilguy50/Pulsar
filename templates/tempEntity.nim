import common/entityTemplate
import strformat
import os

proc tempEntity*(name: string, root: string, works: string, nameCount: int, nameNumber: int, baseName: string)=
  os.setCurrentDir(root)
  var mainJson = fmt"./User_templates/Entities/entity/BP/{baseName}.txt"
  var resourceJson = fmt"./User_templates/Entities/entity/RP/{baseName}.txt"
  var loot = fmt"./User_templates/Entities/optional/loot/{baseName}.txt"
  var geometry = fmt"./User_templates/Entities/geometry/{baseName}.txt"
  var geometryTexture = fmt"./User_templates/Entities/geometry/textures/{baseName}.png"
  var render = fmt"./User_templates/Entities/render/{baseName}.txt"
  var trades = fmt"./User_templates/optional/trades/{baseName}.txt"
  if os.fileExists(loot) == false:
    loot = "none"
  if os.fileExists(trades) == false:
    trades = "none"
  os.setCurrentDir(works)
  entityTemplate(name, root, works, nameCount, nameNumber, geometry, render, geometryTexture, loot, mainJson, resourceJson, trades)