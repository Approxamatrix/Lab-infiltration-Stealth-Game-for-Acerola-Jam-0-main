extends EnemyPatrolState
class_name EnemyTensePatrolState

# Called when the node enters the scene tree for the first time.

func enter():
	if EnemyObj.animplayer:
		EnemyObj.animplayer.play("Guard/Walk")
	Patrolspeed = EnemyObj.EnemyTenseSpeed
	EnemyObj.velocity = Vector3.ZERO
	pass # Replace with function body.
