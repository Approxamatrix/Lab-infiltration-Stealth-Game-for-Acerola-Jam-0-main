extends BaseState
class_name EnemyInvestigateState

##TODO: THE ENEMY WILL PATHFIND OVER TO THE SOURCE. JUST STEAL THE SEARCH STATE'S CODE.
##FOR THE ENEMY TO BE SUSPICIOUS, THERE WILL BE A SUSPICIOUS METER IN THE 
## PATROL STATE. IF IT IS ABOVE A CERTAIN AMOUNT, THEN THE ENEMY WILL BE IN THE TENSE PATROL STATE.
## IF THEY GET EVEN MORE SUSPICIOUS, THEN THE ENEMY GOES TO THE INVESTIGATE STATE AND WILL 
## GO TO THE SOURCE OF THE NOISE

@export var EnemyObj : Enemy
var Lookangle
var nextpathpos : Vector3
var chasevelocity :Vector3
var Playerdir : Vector3
var oldplayerpos : Vector3
func enter():
	if EnemyObj.animplayer != null:
		EnemyObj.animplayer.play("Guard/Walk")
	if EnemyObj.playerseen != null:
		print(" Investigating !")
		oldplayerpos = EnemyObj.playerseen.global_position
	else:
		print("Playerseen is null")
		StateChangeSignal.emit("EnemyPatrolState")
	
	EnemyObj.audioplayer.stream = EnemyObj.suspiciousvoice
	EnemyObj.audioplayer.play()
	
	
	
	gototarget()
	pass

func exit():
	#print("must have been the wind !")
	if EnemyObj.CurPatrolPoint != null:
		nextpathpos = EnemyObj.CurPatrolPoint.global_position
	EnemyObj.soundawareness = 0
	chasevelocity = Vector3.ZERO
	#EnemyObj.playerseen = null
	pass
	
	
func gototarget():
	
	
	#UpdateLastPos()
	## When enemy is close, they will attack
	var currentpos = EnemyObj.global_position
	#if EnemyObj.playerseen != null:
	Playerdir = EnemyObj.global_position.direction_to(oldplayerpos)
	
	#EnemyObj.rotation = EnemyObj.rotation.lerp(Vector3(0,Lookangle,0),0.1) # sets the y rotation to the result of lookangle
	#if (EnemyObj.rotation != EnemyObj.Model.global_rotation):
		#print("Does not match rotation !")
	#else:
		#print("rotation stuff is okay :) !")
	EnemyObj.Navagent.target_position = oldplayerpos # Sets the pathfinding position to the player's position
	nextpathpos = EnemyObj.Navagent.get_next_path_position()
	chasevelocity = EnemyObj.EnemyTenseSpeed * EnemyObj.global_position.direction_to(nextpathpos)
	EnemyObj.Navagent.set_velocity(chasevelocity)
	EnemyObj.sight()
	pass
func update():
	if EnemyObj.playerseen == null:
		#print("Playerseen is null")
		StateChangeSignal.emit("EnemyTensePatrolState")
		pass
		
	EnemyObj.hearing()
	##Pathfinds to player position
	Lookangle = atan2(EnemyObj.velocity.x,EnemyObj.velocity.z) # Gets the angle from the result of the distance_to function
	EnemyObj.rotation = EnemyObj.rotation.lerp(Vector3(0,Lookangle,0),0.1) # sets the y rotation to the result of lookangle
	EnemyObj.sight()
	
	pass
	


func UpdateLastPos():
	if EnemyObj.playerseen:
		EnemyObj.oldplayerpos = EnemyObj.playerseen.global_position
	if EnemyObj.playerseen == null:
		#StateChangeSignal.emit("EnemyTensePatrolState")
		pass
	pass

func LoseTrackofPlyr():
	#StateChangeSignal.emit("EnemyTensePatrolState")
	#EnemyObj.queue_free()
	
	pass
#

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	EnemyObj.velocity = EnemyObj.velocity.move_toward(safe_velocity,0.5)
	EnemyObj.move_and_slide()
	pass


func _on_navigation_agent_3d_target_reached():
	if EnemyObj.StateMachineNode.EntityState is EnemyInvestigateState:
		#print("target reached !")
		if EnemyObj.playerseen:
			
			StateChangeSignal.emit("EnemyTensePatrolState")
				
			pass
		else:
			#print("could not attack !")
			pass
	
	pass # Replace with function body.
