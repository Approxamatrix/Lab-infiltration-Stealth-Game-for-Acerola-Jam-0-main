extends Node3D
@export var Locked : bool
@export var door : Door
@export var closed : bool
@export var which : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	if door != null:
		door.IsLocked = Locked
		door.whichone = which
	#if closed:
		#closed = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
