extends PlayerWalkState
class_name PlayerCrouchWalkState

# Called when the node enters the scene tree for the first time.
func enter():
	#print("Crouchwalk")
	PlayerObj.NoiseNode.noisemade = 0
	
	if PlayerObj.PlayerCollider.shape.height > 1:
		PlayerObj.PlayerAnim.play("Crouch")
	else:
		
		pass
	pass
	MoveSpeed = PlayerObj.CrouchSpd
	#if the animation playing is the crouch animation, pass
	pass # Replace with function body.

func input():
	##print("HI")
	#
	if PlayerObj.InputVector != Vector3.ZERO:
		PlayerObj.velocity.x = PlayerObj.InputVector.x * MoveSpeed
		PlayerObj.velocity.z = PlayerObj.InputVector.z * MoveSpeed

		
		pass
	if PlayerObj.InputVector == Vector3.ZERO:
		StateChangeSignal.emit("PlayerCrouchIdleState")
	
	if Input.is_action_just_pressed("Jump"):
		StateChangeSignal.emit("PlayerCrouchJumpState")
		
	if Input.is_action_just_pressed("Crouch"):
		StateChangeSignal.emit("PlayerWalkState")
	
	
	pass
func exit():
	#print("Uncrouchwalk")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
