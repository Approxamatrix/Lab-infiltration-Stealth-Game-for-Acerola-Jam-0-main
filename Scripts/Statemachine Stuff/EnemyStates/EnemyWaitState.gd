extends BaseState
class_name EnemyWaitState

@export var EnemyObj : Enemy
var staypos : Vector3
func enter():
	print("Waiting")
	staypos = EnemyObj.global_position
	if EnemyObj.animplayer != null:
		EnemyObj.animplayer.play("Guard/Shocked")
	
	pass

func update():
	
	EnemyObj.global_position = staypos
	#EnemyObj.velocity = Vector3.ZERO
	EnemyObj.WaitTime -= 0.05
	#print(EnemyObj.WaitTime)
	EnemyObj.hearing()
	if EnemyObj.WaitTime <= 0:
		StateChangeSignal.emit("EnemyPatrolState")
		pass
	pass

func exit():
	
	EnemyObj.WaitTime = 0
	#print("i'm not waiting anymore")
	pass
