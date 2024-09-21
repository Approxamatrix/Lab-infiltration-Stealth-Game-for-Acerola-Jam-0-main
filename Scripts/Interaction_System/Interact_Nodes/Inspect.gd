extends BaseInteractNode
class_name Inspect

@export var InspectText : String
var inspectkey
func _ready():
	
	InteractionName = GetActionKey.get_key("Inspect") + "Inspect"
	GameJamAutoload.SecondaryInteraction1.connect(interact)



func interact(item):
	if item == parentitem:
		
		GameJamAutoload.DisplayInspectText.emit(InspectText)
		print(InspectText)
	
	pass
