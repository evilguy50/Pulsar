import common/entityTemplate
import strformat
import os

proc tempEntity*(name: string, root: string, works: string, baseName: string)=
  os.setCurrentDir(root)
  var mainJson = fmt"./User_templates/custom/Entities/entity/BP/{baseName}.json"
  var resourceJson = fmt"./User_templates/custom/Entities/entity/RP/{baseName}.json"
  var loot = fmt"./User_templates/custom/Entities/optional/loot/{baseName}.json"
  var geometry = fmt"./User_templates/custom/Entities/geometry/{baseName}.json"
  var geometryTexture = fmt"./User_templates/custom/Entities/geometry/textures/{baseName}.png"
  var render = fmt"./User_templates/custom/Entities/render/{baseName}.json"
  var trades = fmt"./User_templates/custom/optional/trades/{baseName}.json"
  if os.fileExists(loot) == false:
    loot = "none"
  if os.fileExists(trades) == false:
    trades = "none"
  os.setCurrentDir(works)
  entityTemplate(name, root, works, geometry, render, geometryTexture, loot, mainJson, resourceJson, trades)