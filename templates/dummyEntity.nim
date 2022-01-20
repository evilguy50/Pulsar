import common/entityTemplate

proc dummyEntity*(name: string, root: string, works: string)=
  var mainJson = "./templates/dummyEntity/BP/dummyEntity.txt"
  var resourceJson = "./templates/dummyEntity/RP/dummyEntity.txt"
  var model = "./templates/dummyEntity/RP/dummyEntity_geo.txt"
  entityTemplate(name, root, works, model, "none", "none", "none", mainJson, resourceJson, "none")
  return