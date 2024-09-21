extends PlayerFallState
class_name PlayerCrouchFallState

# Called when the node enters the scene tree for the first time.

func update():
	
	input()

	PlayerObj.velocity.y -= PlayerObj.Fallspeed 
	
	if PlayerObj.is_on_floor():
		StateChangeSignal.emit("PlayerCrouchIdleState")
	
	
	pass
	
