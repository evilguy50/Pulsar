import os, strutils
import nigui
import pulsar_cli

app.init()

var window = newWindow("Pulsar: Minimal")
window.width = 600.scaleToDpi
window.height = 400.scaleToDpi

var container = newLayoutContainer(Layout_Vertical)
window.add(container)

var projectName = newTextBox("")
var temps: seq[string]

var letters: seq[char] = @['_']
for l in Letters:
    letters.add(l)

var newTemplate: string
for t in os.walkFiles("./templates/*.nim"):
    var tName = t.splitFile()[1]
    newTemplate = tName.toLower().multiReplace(@[
        ("entity", "_entity"),
        ("block", "_block"),
        ("item", "_item")
    ])
    temps.add(newTemplate)

for b in os.walkFiles("./User_templates/custom/Blocks/blocks/*.json"):
    temps.add(b.splitFile()[1])

for e in os.walkFiles("./User_templates/custom/Entities/entity/BP/*.json"):
    temps.add(e.splitFile()[1])

for i in os.walkFiles("./User_templates/custom/Items/items/*.json"):
    temps.add(i.splitFile()[1])

for p in os.walkFiles("./User_templates/imported/*.pulsar"):
    temps.add(p.splitFile()[1])

for py in os.walkDir("./User_templates/python"):
    if py[1].dirExists():
        temps.add(py[1].splitPath()[1])

var tempName = newComboBox(temps)

var nameList = newTextArea("")

var generateButton = newButton("Generate")

container.add(newLabel("Project Name"))
container.add(projectName)
container.add(newLabel("Template Name"))
container.add(tempName)
container.add(newLabel("Names"))
container.add(nameList)
container.add(generateButton)

generateButton.onClick = proc(event: ClickEvent) =
    try:
        if projectName.text == "":
            window.alert("Must fill in project name")
        else:
            generate(projectName.text, tempName.value, nameList.text)
            nameList.text = ""
            window.alert("Generated!")
    except:
        window.alert(getCurrentExceptionMsg())

window.show()
app.run()