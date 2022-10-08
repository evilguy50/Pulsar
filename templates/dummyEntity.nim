import common/entityTemplate

proc dummyEntity*(name: string, root: string, works: string)=
  var mainJson = "./templates/dummyEntity/BP/dummyEntity.json"
  var resourceJson = "./templates/dummyEntity/RP/dummyEntity.json"
  var model = "./templates/dummyEntity/RP/dummyEntity_geo.json"
  entityTemplate(name, root, works, model, "none", "none", "none", mainJson, resourceJson, "none")