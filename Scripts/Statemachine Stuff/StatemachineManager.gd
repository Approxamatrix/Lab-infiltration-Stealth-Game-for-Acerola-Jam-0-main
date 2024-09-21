extends Node
class_name StatemachineManager

@export var StartState : BaseState
var StateArray : Array[BaseState]
var EntityState : BaseState


func _ready():
	initializestates()
	if StartState != null:
		EntityState = StartState
		
		EntityState.enter()
		pass
		
		
	
	pass

func changestate(state : StringName):
	
	for items in StateArray:
		if items.name == state:
			if EntityState != null:
				EntityState.exit()
			
			EntityState = items
			EntityState.enter()

	
	pass
	
	
func initializestates():
	
	for child in get_children():
		if child is BaseState:
			StateArray.append(child)
			child.StateChangeSignal.connect(changestate)
			pass
		
		pass

func _physics_process(delta):
	#print(EntityState)
	if EntityState != null:
		EntityState.update()
