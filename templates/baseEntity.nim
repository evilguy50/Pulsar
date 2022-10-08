import common/entityTemplate

proc baseEntity*(name: string, root: string, works: string)=
  var mainJson = "./templates/baseEntity/BP/baseEntity.json"
  var resourceJson = "./templates/baseEntity/RP/baseEntity.json"
  var model = "./templates/baseEntity/RP/base_model.json"
  var renderController = "./templates/common/RP/common_render.json"
  var texture = "./templates/baseEntity/RP/textures/base_texture.png"
  entityTemplate(name, root, works, model, renderController, texture, "none", mainJson, resourceJson, "none")