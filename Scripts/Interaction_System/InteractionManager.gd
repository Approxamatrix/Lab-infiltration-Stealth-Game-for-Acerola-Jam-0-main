extends Node
class_name InteractionManager

@export var PossibleInteractionList : Array[BaseInteractNode]
@export var ItemName : String
func _ready():
	
	initializeinteractlist()


func initializeinteractlist():
	
	print("Initializing list of interactions ...")
	
	PossibleInteractionList.clear() #clears list just incase it might be occupied
	
	for item in get_children(): #loops through children then 
		if item is BaseInteractNode: #  it checks if the items are the interaction nodes
			#print(item)
			
			
			
			PossibleInteractionList.append(item) #if the conditions are true, then it adds the item to the interaction list/array
			pass
	pass
	
