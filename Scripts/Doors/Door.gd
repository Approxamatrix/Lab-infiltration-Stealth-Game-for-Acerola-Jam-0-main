extends Node3D
class_name Door
@export var OpenTrigger : Area3D
@export var CloseTrigger : Area3D
@export var animplyr : AnimationPlayer

var whichone : bool # true is first, false is second

@export var IsLocked : bool

@export var locksound : AudioStreamPlayer3D


#
#
#func _on_close_trigger_body_entered(body):
	#
	#if body.is_in_group("Player") and GameJamAutoload.keycardcollected == true:
		#animplyr.play("Close")
		#OpenTrigger.queue_free()
		#print("open")
	#
	#pass # Replace with function body.
#
#
#func _on_open_trigger_body_entered(body):
	#
	#if body.is_in_group("Player") and GameJamAutoload.keycardcollected == true:
		#animplyr.play("Open")
		#CloseTrigger.queue_free()
	#
	#pass # Replace with function body.
