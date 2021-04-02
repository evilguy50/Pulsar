import common/entityTemplate

proc dummyEntity*(name: string, root: string, works: string, nameCount: int, nameNumber: int)=
  var mainJson = "./templates/dummyEntity/BP/dummyEntity.txt"
  var resourceJson = "./templates/dummyEntity/RP/dummyEntity.txt"
  var model = "./templates/dummyEntity/RP/dummyEntity_geo.txt"
  entityTemplate(name, root, works, nameCount, nameNumber, model, "none", "none", "none", mainJson, resourceJson)
  return