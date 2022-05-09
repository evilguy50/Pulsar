import common/entityTemplate

proc zombieEntity*(name: string, root: string, works: string)=
  var mainJson = "./templates/zombieEntity/BP/zombieEntity.json"
  var resourceJson = "./templates/zombieEntity/RP/zombieEntity.json"
  var model = "./templates/zombieEntity/RP/zombieEntity_geo.json"
  var renderController = "./templates/zombieEntity/RP/zombieEntity_render.json"
  var texture = "./templates/zombieEntity/RP/textures/zombieEntity.png"
  var loot = "./templates/zombieEntity/BP/zombieEntity_loot.json"
  entityTemplate(name, root, works, model, renderController, texture, loot, mainJson, resourceJson, "none")