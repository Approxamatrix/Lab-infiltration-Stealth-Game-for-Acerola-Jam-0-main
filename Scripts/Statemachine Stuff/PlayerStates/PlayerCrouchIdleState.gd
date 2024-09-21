extends PlayerIdleState
class_name PlayerCrouchIdleState

func enter():
	
	PlayerObj.NoiseNode.noisemade = 0
	PlayerObj.velocity = Vector3.ZERO
	print("Crouch")
	#if the animation playing is the crouch animation, pass
	if PlayerObj.PlayerCollider.shape.height > 1:
		PlayerObj.PlayerAnim.play("Crouch")
	else:
		pass
	pass



func input():
	
	if PlayerObj.InputVector != Vector3.ZERO:
		StateChangeSignal.emit("PlayerCrouchWalkState")
		pass
	
	if Input.is_action_just_pressed("Jump"):
		StateChangeSignal.emit("PlayerCrouchJumpState")
	
	if Input.is_action_just_pressed("Crouch"):
		StateChangeSignal.emit("PlayerIdleState")
	
	
	pass
