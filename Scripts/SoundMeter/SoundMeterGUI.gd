extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	GameJamAutoload.UpdateSoundMeter.connect(soundmeterupdate)
	
	pass # Replace with function body.

func soundmeterupdate(soundmeterval):
	if soundmeterval != value:
		value = soundmeterval * 100
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
