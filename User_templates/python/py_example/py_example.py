from .. import pulsar_py as pulsar

def template(str_params):
    str_list = str_params.split(" ")
    name = str_list[0]
    root = str_list[1]
    works = str_list[2]
    mainJson = "./User_templates/python/py_example/BP/py_example.json"
    pulsar.blockTemplate(name, root, works, mainJson, "stone", False)