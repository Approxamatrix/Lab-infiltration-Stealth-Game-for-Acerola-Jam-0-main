extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	GameJamAutoload.UpdateLightMeter.connect(lightmeterupdate)
	
	pass # Replace with function body.

func lightmeterupdate(lightmeterval):
	if lightmeterval != value:
		value = lightmeterval
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
