extends BaseInteractNode
class_name StealItem

var cost : int

func _ready():
	InteractionName = GetActionKey.get_key("Interact") + "Steal"
	cost = parentitem.cost
	GameJamAutoload.PrimaryInteraction.connect(interact)

func interact(item):
	
	if parentitem == item:
		print("Stealing an item !!")
		
		
		GameJamAutoload.money += cost
		print(GameJamAutoload.money)
	
	
	pass
