extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_key(action : String) -> String:
	var actionevent : InputEvent
	var actionkey
	if InputMap.has_action(action):
		actionevent  = InputMap.action_get_events(action)[0]
		
		#print(actionevent)
		var keycodestring = OS.get_keycode_string(actionevent.physical_keycode)
		actionkey = "(  " + keycodestring + "  )  "
	else :
		actionkey = "No key was set for this action ! pls fix"
	
	
	
	return actionkey
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
