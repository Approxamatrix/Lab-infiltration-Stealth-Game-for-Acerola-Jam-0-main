extends BaseState
class_name PlayerJumpState

@export var PlayerObj : Player

func enter():
	PlayerObj.velocity.y += PlayerObj.JumpPower  
	PlayerObj.NoiseNode.noisemade = 0
	StateChangeSignal.emit("PlayerFallState")
	
	pass

func exit():
	#PlayerObj.velocity = Vector3.ZERO
	pass
	
	
func update():
	
	input()
	
	
	
	
	
	pass
	
func input():
	##print("HI")
	#
	if PlayerObj.InputVector != Vector3.ZERO:
		PlayerObj.velocity.x = PlayerObj.InputVector.x * PlayerObj.WalkSpd
		PlayerObj.velocity.z = PlayerObj.InputVector.z * PlayerObj.WalkSpd
	
		
		
	
		
	
	
	pass
