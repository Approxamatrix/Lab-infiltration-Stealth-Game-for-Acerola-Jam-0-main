extends GameEntity
class_name ProjectileMulti


@export var NoiseTimer : Timer

@export var ProjectileMesh : MeshInstance3D

enum Type {Type_SHOCK,Type_NOISE}

enum State {STATE_IDLE,STATE_ACTIVATE,STATE_DESTROY}

var ProjectileState : State
@export var ProjectileType : Type
@export var EnemyDetector : Area3D


@export var ShockDamage : float

## Set up an enum to handle the different types of projectiles (so far noisemaker and the shock


## if the projectile is set to shock then run the shock function and vice versa for noisemaker


## there should also be a separate enum for the projectile's state (idle , active and  used)

##idle will be when it's not doing anything (self explanatory)

## and active will be transitioned to (from idle) when the detection area3d is triggered by an enemy

## where the used enum will disable the model, emit particles and then run the queue_free function


# Called when the node enters the scene tree for the first time.
func _ready():
	if ProjectileType == Type.Type_NOISE:
		NoiseTimer.start()
	ProjectileState = State.STATE_IDLE
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	match ProjectileState:
		State.STATE_IDLE:
			#print("idle")
			
			
			
			pass
		
		
		State.STATE_DESTROY:
			queue_free()
			#print("RIP")
	
	
	
	pass


func _on_enemy_detector_body_entered(body):
	if body.is_in_group("Enemy"):
		if ProjectileType == Type.Type_SHOCK:
			match ProjectileState:
				State.STATE_IDLE:
					print("attacking !")
					
					ProjectileState = State.STATE_ACTIVATE
					ActivateEffect(body)
					pass
					
	pass # Replace with function body.

func ActivateEffect(body:Enemy):
	
	match ProjectileType:
		Type.Type_SHOCK:
			
			body.StateMachineNode.changestate("EnemyStunState")
			## do shock stuff
			ProjectileState = State.STATE_DESTROY ## This sets the state to the destroy state as these projectiles
			#print("Shock stuff !")
			
			pass
		Type.Type_NOISE:
			print("NOISE !!")
			## Use the sound emitted area3d to get access to enemies
			body.soundawareness += 0.4
			print(body.soundawareness)
			## do Noise stuff
			#print("Noise stuff !")
			
			pass
	#body.queue_free()
		
	
	
	
	## this will run a check on the projectile's mode, depending on the mode, a specific effect will be run
	
	 
	##only have 1 use after being deployed
	
	pass


func _on_sound_emitted_body_entered(body):
	if body.is_in_group("Enemy"):
		print("Enemy heard us !")
		if ProjectileType == Type.Type_NOISE:
			match ProjectileState:
				State.STATE_IDLE:
					body.playerseen = self
					ProjectileState = State.STATE_ACTIVATE
					ActivateEffect(body)
					pass
	pass

func NoiseTimeout():
	ProjectileState = State.STATE_DESTROY
	pass




func _on_sound_emitted_body_exited(body):
	if body.is_in_group("Enemy"):
		body.playerseen = null
	pass # Replace with function body.
