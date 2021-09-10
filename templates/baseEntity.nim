import common/entityTemplate

proc baseEntity*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
  var mainJson = "./templates/baseEntity/BP/baseEntity.txt"
  var resourceJson = "./templates/baseEntity/RP/baseEntity.txt"
  var model = "./templates/baseEntity/RP/base_model.txt"
  var renderController = "./templates/common/RP/common_render.txt"
  var texture = "./templates/baseEntity/RP/textures/base_texture.png"
  entityTemplate(name, root, works, nameCount, nameNumber, model, renderController, texture, "none", mainJson, resourceJson, "none")
  return