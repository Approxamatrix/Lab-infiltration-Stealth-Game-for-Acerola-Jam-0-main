extends Control

 #Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	
	LevelChanger.change_level("res://Scenes/Levels/Level1.tscn")
	#get_tree().unload_current_scene()
	#if level1:
		#get_tree().change_scene_to_packed(level1)
	pass # Replace with function body.