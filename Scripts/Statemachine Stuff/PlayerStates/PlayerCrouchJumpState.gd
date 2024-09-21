extends PlayerJumpState
class_name PlayerCrouchJumpState

# Called when the node enters the scene tree for the first time.
func enter():
	PlayerObj.velocity.y += PlayerObj.CrouchJumpPower  
	PlayerObj.NoiseNode.noisemade = 0
	StateChangeSignal.emit("PlayerCrouchFallState")
	PlayerObj.WalkSpd = PlayerObj.CrouchSpd *2
	
	
	#if the animation playing is the crouch animation, pass
	pass # Replace with function body.

func exit():
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
