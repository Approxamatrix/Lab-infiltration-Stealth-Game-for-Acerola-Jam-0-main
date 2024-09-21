extends Button
@export var goldtext : RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	goldtext.text = "Gold :  %d" %GameJamAutoload.money 
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.mouse_mode == Input.MouseMode.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MouseMode.MOUSE_MODE_VISIBLE
	
	pass


func _on_pressed() -> void:
	LevelChanger.change_level("res://Scenes/Title Screen/TitleScreen.tscn")
	pass # Replace with function body.
