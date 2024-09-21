extends BaseState
class_name PlayerWalkState

@export var PlayerObj : Player
@export var Camera : Camera3D
var MoveSpeed : float
func enter():
	PlayerObj.NoiseNode.noisemade = 0
	PlayerObj.velocity = Vector3.ZERO
	MoveSpeed = PlayerObj.WalkSpd
	PlayerObj.WalkSound.volume_db = -19
	PlayerObj.WalkTimer.wait_time = PlayerObj.Walksoundtime
	PlayerObj.WalkTimer.start()
	
	if PlayerObj.PlayerCollider.shape.height < 2:
		PlayerObj.PlayerAnim.play("Uncrouch")
	else:
		pass

	pass

func exit():
	PlayerObj.WalkTimer.stop()
	pass
	
	
func update():
	
	input()
	
	if !PlayerObj.is_on_floor():
		StateChangeSignal.emit("PlayerFallState")
	
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
		
	if Input.is_action_pressed("Run"):
		StateChangeSignal.emit("PlayerRunState")
	
	if Input.is_action_just_pressed("Crouch"):
		StateChangeSignal.emit("PlayerCrouchWalkState")
	
	pass
