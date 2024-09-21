extends BaseState
class_name EnemyChaseState

@export var EnemyObj : Enemy

var nextpathpos : Vector3
var chasevelocity :Vector3
var Playerdir : Vector3

func enter():
	#print(" I see you !")
	print("Chase")
	
	EnemyObj.animplayer.play("Guard/Run")
	
	EnemyObj.audioplayer.stream = EnemyObj.chasevoice
	EnemyObj.audioplayer.play()
	
	pass

func exit():
	EnemyObj.soundawareness = 0
	#print("must have been the wind !")
	#EnemyObj.animplayer.stop()
	#EnemyObj.Model.rotation =  EnemyObj.rotation.lerp(Vector3(0,deg_to_rad(180),0),1)
	pass

func chaselogicandrotation():
	
	
	
	if EnemyObj.playerseen != null:
		Playerdir = EnemyObj.global_position.direction_to(EnemyObj.playerseen.global_position)
		
		EnemyObj.Navagent.target_position = EnemyObj.playerseen.global_position # Sets the pathfinding position to the player's position

		nextpathpos = EnemyObj.Navagent.get_next_path_position()
		
		var pathdirection = EnemyObj.global_position.direction_to(nextpathpos)
		var pathangle = atan2(-pathdirection.x, pathdirection.z)
		chasevelocity = EnemyObj.EnemyChaseSpeed * EnemyObj.global_position.direction_to(nextpathpos)
		EnemyObj.Navagent.set_velocity(chasevelocity)
		
		#var Lookangle = atan2(EnemyObj.velocity.x,-EnemyObj.velocity.z) # Gets the angle from the result of the distance_to function
		EnemyObj.rotation = EnemyObj.rotation.lerp(Vector3(0,-pathangle,0),0.5) # sets the y rotation to the result of lookangle
		#EnemyObj.rotation = EnemyObj.Model.rotation
	
	
	
	
	pass


	
func update():
	##Pathfinds to player position
	
	## When enemy is close, they will attack
	var currentpos = EnemyObj.global_position
	
	EnemyObj.sight()
	
	chaselogicandrotation()
	
	if EnemyObj.EnemyAwarenessMeter <= 0:
		StateChangeSignal.emit("EnemyTensePatrolState")
		pass
	
	pass
	

func UpdateLastPos():
	if EnemyObj.playerseen:
		EnemyObj.oldplayerpos = EnemyObj.playerseen.global_position
	pass

func LoseTrackofPlyr():
	#if EnemyObj.playerseen != null:
		#EnemyObj.playerseen = null
	if EnemyObj.oldplayerpos != null:
		StateChangeSignal.emit("EnemySearchState")
		pass
	else:
		StateChangeSignal.emit("EnemyTensePatrolState")
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	
	EnemyObj.velocity = EnemyObj.velocity.move_toward(safe_velocity,0.5)
	EnemyObj.move_and_slide()
	
	
	pass # Replace with function body.


func _on_navigation_agent_3d_target_reached():
	
	if EnemyObj.StateMachineNode.EntityState is EnemyChaseState:
		#print("target reached !")
		if EnemyObj.playerseen:
			
			StateChangeSignal.emit("EnemyAttackState")
				
			pass
		else:
			#print("could not attack !")
			pass
	pass # Replace with function body.
