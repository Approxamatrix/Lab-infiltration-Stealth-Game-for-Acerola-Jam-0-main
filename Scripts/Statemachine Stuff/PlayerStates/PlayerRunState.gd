extends PlayerWalkState
class_name PlayerRunState

func enter():
	PlayerObj.NoiseNode.noisemade = 0.5
	#PlayerObj.velocity = Vector3.ZERO
	MoveSpeed = PlayerObj.RunSpd
	PlayerObj.WalkSound.volume_db = 0
	PlayerObj.WalkTimer.start()
	PlayerObj.WalkTimer.wait_time = PlayerObj.Runsoundtime
	print("Running")
	pass
func exit():
	PlayerObj.WalkTimer.stop()
	pass

func input():
	##print("HI")
	#
	if PlayerObj.InputVector != Vector3.ZERO:
		PlayerObj.velocity.x = PlayerObj.InputVector.x * MoveSpeed
		PlayerObj.velocity.z = PlayerObj.InputVector.z * MoveSpeed

		
		pass
	if PlayerObj.InputVector == Vector3.ZERO:
		StateChangeSignal.emit("PlayerIdleState")
	
	if Input.is_action_just_pressed("Jump"):
		StateChangeSignal.emit("PlayerJumpState")
		
	if !Input.is_action_pressed("Run"):
		StateChangeSignal.emit("PlayerWalkState")
	
	if Input.is_action_just_pressed("Crouch"):
		StateChangeSignal.emit("PlayerCrouchWalkState")
	
	pass
