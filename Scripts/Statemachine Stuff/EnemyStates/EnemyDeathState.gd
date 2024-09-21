extends BaseState
class_name EnemyDeathState


@export var EnemyObj : Enemy

func enter():
	print("Rest in pepperonis !!")
	EnemyObj.velocity = Vector3.ZERO
	EnemyObj.animplayer.play("Downed")
	EnemyObj.collision.disabled = true
	pass



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():

	##TODO: Have an aniamtion play and then upon it being finished, queue_free()
	## This could be done using signals like maybe one that is emitted when the animation is done.
	## This would work as the only animation that should be playing is the death animation
	
	pass
