extends Node3D

@export var Cameranode : Camera3D
@export var FrontLedgeCheck : RayCast3D
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		
		rotate_y(0.008 * -event.relative.x)
		Cameranode.rotate_x(0.008 * -event.relative.y)
		Cameranode.rotation.x = clamp(Cameranode.rotation.x,deg_to_rad(-90),deg_to_rad(90))
		FrontLedgeCheck.rotation.y = rotation.y
		
	
	pass
	
func _process(delta):
	
	if Input.is_action_just_pressed("Pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
	
	pass
