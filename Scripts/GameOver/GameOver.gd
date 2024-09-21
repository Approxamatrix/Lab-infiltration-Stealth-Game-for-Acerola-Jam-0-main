extends Control

@export var title : PackedScene
@export var moneyamt : RichTextLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	moneyamt.text = "[center]" + "Money : " + str(GameJamAutoload.money) + "[/center]"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if title:
		get_tree().change_scene_to_packed(title)
	pass # Replace with function body.
