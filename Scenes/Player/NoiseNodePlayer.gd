extends Area3D
class_name NoiseNodePlyr

@export var plyrnode : Player
@export var noisemade : float
var oldnoise: float
@export var Enemyobj : Enemy
# Called when the node enters the scene tree for the first time.
func _ready():
	#if noisemade != 0:
		#oldnoise = noisemade
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Enemyobj != null:
		
		if oldnoise != noisemade:
			
			notifyenemy(Enemyobj)
			
			pass
		
		
		pass
	if oldnoise != noisemade:
		
		GameJamAutoload.UpdateSoundMeter.emit(noisemade)
		print(noisemade)
		oldnoise = noisemade
		pass
	
	
	pass
	

func notifyenemy(body : Enemy):
	
	body.soundawareness += noisemade
	
	
	pass


func _on_body_entered(body):
	
	if body is Enemy:
		Enemyobj = body
		body.playerseen = plyrnode;
		notifyenemy(body)
		print(oldnoise)
		pass
		
	else:
		pass
	
	pass # Replace with function body.


func _on_body_exited(body):
	
	
	if body is Enemy:
		Enemyobj = null
		body.soundawareness = 0
		#body.playerseen = null;
		
		pass
	else:
		
		pass
	pass # Replace with function body.
