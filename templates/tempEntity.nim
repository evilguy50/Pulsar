import common/entityTemplate
import strformat
import os

proc tempEntity*(name: string, root: string, works: string, nameCount: int, nameNumber: int,
 mainJson: string, resourceJson: string, geometry: string, geometryTexture: string,
  loot: string, render: string, baseName: string)=
  os.setCurrentDir(root)
  var mainJson2 = mainJson
  var resourceJson2 = resourceJson
  var loot2 = loot
  var geometry2 = geometry
  var geometryTexture2 = geometryTexture
  var render2 = render
  if baseName != "":
      if mainJson == "":
        mainJson2 = fmt"./User_templates/Entities/entity/BP/{baseName}.txt"
      if resourceJson == "":
        resourceJson2 = fmt"./User_templates/Entities/entity/RP/{baseName}.txt"
      if loot == "":
        loot2 = fmt"./User_templates/Entities/loot/{baseName}.txt"
      if geometry == "":
        geometry2 = fmt"./User_templates/Entities/geometry/{baseName}.txt"
      if geometryTexture == "":
        geometryTexture2 = fmt"./User_templates/Entities/geometry/textures/{baseName}.png"
      if render == "":
        render2 = fmt"./User_templates/Entities/render/{baseName}.txt"
  os.setCurrentDir(works)
  entityTemplate(name, root, works, nameCount, nameNumber, geometry2, render2, geometryTexture2, loot2, mainJson2, resourceJson2)