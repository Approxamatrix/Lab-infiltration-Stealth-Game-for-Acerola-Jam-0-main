extends BaseState
class_name PlayerIdleState

@export var PlayerObj : Player

func enter():
	if PlayerObj.NoiseNode != null :
		PlayerObj.NoiseNode.noisemade = 0
	PlayerObj.velocity = Vector3.ZERO
	if PlayerObj.PlayerCollider != null  :
		if PlayerObj.PlayerCollider.shape.height < 2:
			PlayerObj.PlayerAnim.play("Uncrouch")
		else:
			pass
			
		pass
		
	
	pass

func exit():
	
	pass
	
	
func update():
	input()
	
	
	if !PlayerObj.is_on_floor():
		StateChangeSignal.emit("PlayerFallState")
	
	
	pass

func input():
	
	if PlayerObj.InputVector != Vector3.ZERO:
		StateChangeSignal.emit("PlayerWalkState")
		pass
	
	if Input.is_action_just_pressed("Jump"):
		StateChangeSignal.emit("PlayerJumpState")
	
	if Input.is_action_just_pressed("Crouch"):
		StateChangeSignal.emit("PlayerCrouchIdleState")
	
	
	pass
