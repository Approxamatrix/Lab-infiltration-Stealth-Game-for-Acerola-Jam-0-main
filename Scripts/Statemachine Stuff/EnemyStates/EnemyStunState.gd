extends BaseState
class_name EnemyStunState

@export var Enemyobj : Enemy
 
# Called when the node enters the scene tree for the first time.
func enter():
	
	#Enemyobj.animplayer.play("Guard_Human/Shocked")
	Enemyobj.CurPatrolPoint = null
	Enemyobj.playerseen = null
	Enemyobj.collision.queue_free()
	Enemyobj.audioplayer.stream = Enemyobj.hurtvoice
	Enemyobj.audioplayer.play()
	print("Stunned !")
	if Enemyobj.Navagent != null: 
		Enemyobj.Navagent.queue_free()
	if Enemyobj.animplayer:
		Enemyobj.animplayer.play("Guard/Downed")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	Enemyobj.velocity = Vector3.ZERO
	
	
	pass
