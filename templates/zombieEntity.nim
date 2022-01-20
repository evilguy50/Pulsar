import common/entityTemplate

proc zombieEntity*(name: string, root: string, works: string)=
  var mainJson = "./templates/zombieEntity/BP/zombieEntity.txt"
  var resourceJson = "./templates/zombieEntity/RP/zombieEntity.txt"
  var model = "./templates/zombieEntity/RP/zombieEntity_geo.txt"
  var renderController = "./templates/zombieEntity/RP/zombieEntity_render.txt"
  var texture = "./templates/zombieEntity/RP/textures/zombieEntity.png"
  var loot = "./templates/zombieEntity/BP/zombieEntity_loot.txt"
  entityTemplate(name, root, works, model, renderController, texture, loot, mainJson, resourceJson, "none")
  return