extends GameEntity
class_name Enemy

@export var EnemyWalkSpeed : float
@export var EnemyChaseSpeed : float
@export var EnemyPatrolSpeed: float
@export var EnemyTenseSpeed: float
@export var attackdamage : float
@export var awarenesstimer : Timer
@export var RememberPlayerPos : Timer
@export var AwarenessTimeout : Timer
@export var Navagent : NavigationAgent3D
@export var DefaultHealth : float
var playerseen : GameEntity
var oldplayerpos ## this will be what the ai pathfinds towards, When the timer runs out, this variable will stop being updated and the enemy will pathfind to that old location
var plyrdotprod : float
var Plyroutofrange:bool = false
@export var CurPatrolPoint : PatrolPoint
#@export var NextPatrolPoint : PatrolPoint
@export var LightDetectionThreshold : int
@export var EnemyAwarenessMeter : float
@export var AwarenessDecrease : float
@export var AwarenessDecreaseNoLight : float
@export var MaxAwareness : float
@export var StateMachineNode : StatemachineManager
var Suspicion : float
@export var MaxSuspicion : float
var soundawareness : float
var environsound : float
@export var Maxsoundawareness : float
var WaitTime : float
@export var Model : Node3D
@export var animplayer : AnimationPlayer
@export var BatonHit : AudioStreamPlayer3D
@export var collision : CollisionShape3D
@export var audioplayer : AudioStreamPlayer3D
@export var attackvoice : AudioStreamRandomizer
@export var chasevoice : AudioStreamRandomizer
@export var hurtvoice : AudioStreamRandomizer
@export var searchvoice : AudioStreamRandomizer
@export var suspiciousvoice : AudioStreamRandomizer


var isStunned : bool
var PlayerLastSeenMesh = preload("res://Scenes/Player/player_last_seen.tscn")

func _ready():
	GameJamAutoload.TakeDamage.connect(take_damage)
	health = DefaultHealth
	
	pass

func enemyawareness():
	
	var plyrdir = global_position.direction_to(playerseen.global_position).normalized()
	plyrdotprod = transform.basis.z.dot(plyrdir)
	
	#print(plyrdotprod)
	
	
	pass
	
	
func _on_area_3d_body_entered(body):
	
	if body.is_in_group("Player"):
		playerseen = body
		Plyroutofrange = false
		
		pass
		
	#if body is ProjectileMulti or body is NoiseNodePlyr:
		#if soundawareness > 0.4:
			#
			#playerseen = body
	else:
		playerseen = null
		pass
	
	pass # Replace with function body.


func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		Plyroutofrange = true
		#AwarenessTimeout.start()
	#if body.is_in_group("Player"):
		#RememberPlayerPos.start()
		##perhaps there could be a timer that will call a function that sets the playerseen to null
		#
		#pass
	#else:
		#
		#pass
	
	pass # Replace with function body.
	
func take_damage(damagetaken : float):
	
	if self.health <= 0:
		#die()
		pass
	else:
		self.health -= damagetaken
		print(self.health)
		#the real take damage stuff will be here
		pass
	
	
	pass


func die():
	
	if health <= 0:
		print("Enemy has died")
		StateMachineNode.changestate("EnemyInvestigateState")

		
		pass
	else:
		pass
	
	pass
	


func sight():
	#print("hiii")
	
	if plyrdotprod >= 0.7 and !Plyroutofrange:
		## checks to see if player is in range and that the enemy is looking in their direction
		#print("hiii")
		if playerseen != null and playerseen is Player:
			if playerseen.lightmeterval >= LightDetectionThreshold: ## checks to see if the player's lightmeter is bright enough for them to be spotted.
				print("i see you")
				print(awarenesstimer.time_left)
				if playerseen != null:
					EnemyAwarenessMeter += (AwarenessDecrease * ( global_position.distance_to(playerseen.global_position) * 5 / playerseen.lightmeterval * 5)) /2
					print(EnemyAwarenessMeter)
					
					if EnemyAwarenessMeter >= MaxAwareness:
						StateMachineNode.changestate("EnemyChaseState")
						#StateChangeSignal.emit("EnemyChaseState")
						pass
				
				
			if playerseen.lightmeterval <= LightDetectionThreshold: 
				EnemyAwarenessMeter -= AwarenessDecrease * 2
				#print("who's that !")
				#fill up meter before chasing
				#if EnemyObj.awarenesstimer.is_stopped():
					#EnemyObj.awarenesstimer.start()
				
				pass
		
	if plyrdotprod < 0.7 or Plyroutofrange:
		EnemyAwarenessMeter -= AwarenessDecrease * 2
		#print(EnemyAwarenessMeter)
		#if !EnemyObj.awarenesstimer.is_stopped():
			#EnemyObj.awarenesstimer.stop()
		pass
	
	
	
	
	
	pass
	


func hearing():
	
	if soundawareness > environsound: ##this allows the player to move around in places that are noisy without being heard
	
		if soundawareness < 0.1:
			#print("It was probably nothing...")
			pass
		if soundawareness >= 0.2:
			#Make the enemy look in the direction or maybe they could turn on their flashlight ?
			pass

		if soundawareness >= 0.4:
			## Maybe they could instead just investigate instead ?
			if !(StateMachineNode.EntityState.is_class("EnemyInvestigateState")):
				#print("What was that ?")
				StateMachineNode.changestate("EnemyInvestigateState")
			
			#Enter investigatestate
			pass
	
		
		pass
		
	else: ## this will have the player be noticed if their noise is louder than the stuff around them 
		
		pass


## To be used for Untitled Heist Game, 
## not this polished version of an unfinished and unreleased game jam game.
			#if environsound <= 0.9:
				##Attack in that direction
				#pass
#
			#if environsound > 0.9:
			### this will be reserved for explosions or really loud stuff
				##Enter fastinvestigatestate
				#pass
		
		
		pass
	
	
	
	pass
	
func _process(delta):
	#if rotation != Model.rotation:
		#Model.global_rotation = self.rotation
		#pass
	#if Navagent != null:
		#hearing()
	#else:
		#
		#pass
	#
	if playerseen != null:
		enemyawareness()
	EnemyAwarenessMeter = clamp(EnemyAwarenessMeter,0,MaxAwareness)
	pass


func forgotplayerpos():
	playerseen = null
	
	pass
