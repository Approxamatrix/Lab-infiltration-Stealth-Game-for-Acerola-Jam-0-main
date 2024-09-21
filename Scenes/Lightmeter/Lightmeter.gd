extends Node3D
@export var Subviewport : SubViewport
var brightness : float
var finalbrightness: float
@export var lightmetercam : Camera3D
var newlum
var pixel
func _ready():
	Subviewport.debug_draw = Viewport.DEBUG_DRAW_LIGHTING


func _process(delta):
	metercalculations()
	
	pass
	
	
func metercalculations():
	
	var subviewimg = Subviewport.get_texture().get_image()
	
	for hpixel in subviewimg.get_width():
		for vpixel in subviewimg.get_height():
			
			pixel = subviewimg.get_pixel(hpixel,vpixel)
			newlum = pixel.get_luminance()
			if (newlum >=  brightness):
				brightness = newlum
			
	finalbrightness = brightness * 10
	newlum  = 0
	brightness = 0
	#print(finalbrightness)

	GameJamAutoload.UpdateLightMeter.emit(finalbrightness)
	
	
	
	pass
