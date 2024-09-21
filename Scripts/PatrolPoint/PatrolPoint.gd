extends Node3D
class_name PatrolPoint

@export var nextpoint : PatrolPoint
enum Act {Normal,Wait}
@export var icon : Sprite3D

@export var Action: Act


@export var waitlength : float
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#icon.texture = null
	#icon.hide()
	#icon.queue_free()
	#else:
		#print("no icon node set in editor view !")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if icon != null:
		get_child(0).queue_free()
		
	pass
