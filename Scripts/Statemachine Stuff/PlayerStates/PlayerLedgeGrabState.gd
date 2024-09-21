extends BaseState
class_name PlayerLedgeGrabState

@export var PlayerObj : Player
@export var LedgeGrabIndicator : TextureRect
var LedgeClimbTween

func enter():
	PlayerObj.velocity = Vector3.ZERO
	PlayerObj.NoiseNode.noisemade = 0
	LedgeClimbTween = create_tween()
	LedgeClimbTween.tween_property(PlayerObj,"position",PlayerObj.dummy,0.2)
	#PlayerObj.global_position = PlayerObj.dummy
	LedgeClimbTween.finished.connect(climbtweenfinished)
	
	
	pass

func exit():
	
	pass
	
	
func update():
	input()
	
	
	
	pass
	
func climbtweenfinished():
	StateChangeSignal.emit("PlayerIdleState")
	pass

func input():
	
	
	
	
	pass
