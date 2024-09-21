extends BaseState
class_name PlayerDeathState

@export var PlayerObj : Player
@export var deathtimer : Timer
@export var deathscreen : PackedScene
func enter():
	PlayerObj.PlayerAnim.play("Death")
	deathtimer.start()
	print("death state")
	pass

func exit():
	
	pass
	
	
func update():
	
	
	
	
	pass



func _on_death_timer_timeout():
	
	get_tree().change_scene_to_packed(deathscreen)
	
	pass # Replace with function body.
