extends Node3D
@export var OpenTrigger : Area3D
@export var TeleportTrigger : Area3D
@export var AnimationPlr : AnimationPlayer
@export var TeleTimer : Timer
@export var LevelString : String

func _on_open_trigger_body_entered(body):
	if body.is_in_group("Player"):
		AnimationPlr.play("Open")
	pass # Replace with function body.


func _on_teleport_trigger_body_entered(body):
	if body.is_in_group("Player"):
		AnimationPlr.play("Close")
		TeleTimer.start()
	pass # Replace with function body.
	
func teleporttime():
	LevelChanger.change_level(LevelString)
	#get_tree().change_scene_to_packed(TeleportScene)
	pass


func _on_timer_timeout():
	teleporttime()
	pass # Replace with function body.


func _on_open_trigger_body_exited(body):
	if body.is_in_group("Player"):
		AnimationPlr.play("Close")
	pass # Replace with function body.
