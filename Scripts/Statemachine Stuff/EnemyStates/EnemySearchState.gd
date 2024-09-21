extends BaseState
class_name EnemySearchState


@export var EnemyObj : Enemy
var nextpathpos : Vector3
var chasevelocity :Vector3
var Playerdir : Vector3

func enter():
	
	if EnemyObj.oldplayerpos != null:
		
		pass
	if EnemyObj.oldplayerpos == null:
		print("I don't know where the player is !")
		StateChangeSignal.emit("EnemyPatrolState")
	
	EnemyObj.audioplayer.stream = EnemyObj.searchvoice
	EnemyObj.audioplayer.play()
	EnemyObj.hearing()
	#print(" I see you !")
	print("Search")
	EnemyObj.animplayer.play("Guard/Walk")
	pass

func exit():
	print("must have been the wind !")
	pass
	
	
func update():
	##Pathfinds to player position
	
	## When enemy is close, they will attack
	var currentpos = EnemyObj.global_position
	if EnemyObj.playerseen != null:
		Playerdir = EnemyObj.global_position.direction_to(EnemyObj.oldplayerpos)
		var Lookangle = atan2(Playerdir.x,Playerdir.z) # Gets the angle from the result of the distance_to function
		EnemyObj.rotation = EnemyObj.rotation.lerp(Vector3(0,Lookangle,0),0.05) # sets the y rotation to the result of lookangle
		EnemyObj.Navagent.target_position = EnemyObj.oldplayerpos # Sets the pathfinding position to the player's position
		nextpathpos = EnemyObj.Navagent.get_next_path_position()
		chasevelocity = EnemyObj.EnemyChaseSpeed * EnemyObj.global_position.direction_to(nextpathpos)
		EnemyObj.Navagent.set_velocity(chasevelocity)
	EnemyObj.sight()
	
	pass
	



func ForgetPlayerPos():
	if EnemyObj.playerseen != null:
		EnemyObj.playerseen = null
	StateChangeSignal.emit("EnemyTensePatrolState")
	print("They might still be here ! Gotta be on guard !")
	
	#EnemyObj.queue_free()
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	
	EnemyObj.velocity = EnemyObj.velocity.move_toward(safe_velocity,0.5)
	EnemyObj.move_and_slide()
	
	
	pass # Replace with function body.


func _on_navigation_agent_3d_target_reached():
	if EnemyObj.StateMachineNode.EntityState is EnemySearchState:
		if !EnemyObj.playerseen:
			StateChangeSignal.emit("EnemyTensePatrolState")
			pass
			
		else:
			ForgetPlayerPos()
			pass
	
	pass # Replace with function body.
	
