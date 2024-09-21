extends BaseState
class_name PlayerFallState

@export var PlayerObj : Player
var BlockedCheckerPos : Vector3
@export var LedgeGrabIndicator : TextureRect
func enter():
	PlayerObj.NoiseNode.noisemade = 0
	pass

func exit():
	PlayerObj.velocity = Vector3.ZERO
	PlayerObj.WalkSound.play()
	#LedgeGrabIndicator.hide()
	pass

	
func update():
	
	input()
	LedgeGrabLogic()
	PlayerObj.velocity.y -= PlayerObj.Fallspeed 
	
	if PlayerObj.is_on_floor():
		StateChangeSignal.emit("PlayerIdleState")
	
	
	pass
	
func input():
	##print("HI")
	#
	if PlayerObj.InputVector != Vector3.ZERO:
		PlayerObj.velocity.x = PlayerObj.InputVector.x * PlayerObj.WalkSpd/1.5
		PlayerObj.velocity.z = PlayerObj.InputVector.z * PlayerObj.WalkSpd/1.5
	
		
		
	
		
	
	
	pass


func LedgeGrabLogic():
	
	
	if PlayerObj.FrontLedgeCheck.is_colliding():
		PlayerObj.TopLedgeCheck.global_position =  Vector3(PlayerObj.FrontLedgeCheck.get_collision_point().x,PlayerObj.FrontLedgeCheck.get_collision_point().y - PlayerObj.LedgeBlockedCheckerOffset,PlayerObj.FrontLedgeCheck.get_collision_point().z)
		PlayerObj.LedgeBlockedCheck.global_position = Vector3(PlayerObj.TopLedgeCheck.get_collision_point().x,PlayerObj.TopLedgeCheck.get_collision_point().y - PlayerObj.LedgeBlockedCheckerOffset ,PlayerObj.TopLedgeCheck.get_collision_point().z)
		if !PlayerObj.LedgeBlockedCheck.is_colliding() and PlayerObj.TopLedgeCheck.is_colliding():
			PlayerObj.dummy = Vector3(PlayerObj.FrontLedgeCheck.get_collision_point().x,PlayerObj.TopLedgeCheck.get_collision_point().y - PlayerObj.LedgeBlockedCheckerOffset ,PlayerObj.FrontLedgeCheck.get_collision_point().z)
			#LedgeGrabIndicator.show()
			if Input.is_action_pressed("Jump"):
				StateChangeSignal.emit("PlayerLedgeGrabState")
		else:
			#LedgeGrabIndicator.hide()
			
			pass
		pass
		
		if PlayerObj.LedgeBlockedCheck.is_colliding():
			#set the top ledge check's position but offset it a bit
			#LedgeGrabIndicator.hide()
			
			# put shapecast slightly above where the ledge is and if the shapecast is not colliding, then get the data from the raycasts
			
			pass
	
	

