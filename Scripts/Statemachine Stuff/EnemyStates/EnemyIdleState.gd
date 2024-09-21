extends BaseState
class_name EnemyIdleState

@export var EnemyObj : Enemy


func enter():
	#print("hi")
	EnemyObj.velocity = Vector3.ZERO
	checkforpatrolpoint()
	if EnemyObj.animplayer != null:
		#EnemyObj.animplayer.play("Guard/Shocked")
		pass
	pass

func exit():
	#print("bye")
	pass
	
	
func update():
	EnemyObj.hearing()
	
	#print(EnemyObj.plyrdotprod)
	## Enemy does not move in thie state
	## if they see a player, they will either chase or look in their direction
	## based on the player's light meter
	if EnemyObj.playerseen == null:
		pass
	else:
		EnemyObj.sight()
		
	
	
	pass


func checkforpatrolpoint():
	
	if EnemyObj.CurPatrolPoint != null:
		StateChangeSignal.emit("EnemyPatrolState")
	else:
		
		pass
	
	
	
	
	pass




func _on_awareness_timeout():
	
	StateChangeSignal.emit("EnemyChaseState")
	pass # Replace with function body.
