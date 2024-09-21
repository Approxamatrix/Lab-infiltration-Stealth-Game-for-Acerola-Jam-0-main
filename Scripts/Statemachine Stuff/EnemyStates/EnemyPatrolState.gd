extends BaseState
class_name EnemyPatrolState

@export var EnemyObj : Enemy
var nextpathpos
var chasevelocity
var Pointdir
var Patrolspeed

func enter():
	#print("hi")
	print("Patrolling :D")
	if EnemyObj.animplayer != null:
		EnemyObj.animplayer.play("Guard/Walk")
	else:
		print("animplayer is null")
	Patrolspeed = EnemyObj.EnemyPatrolSpeed
	EnemyObj.velocity = Vector3.ZERO
	pass

func exit():
	#print("bye")
	pass
	
	
func update():
	#print(EnemyObj.plyrdotprod)
	## Enemy does not move in thie state
	## if they see a player, they will either chase or look in their direction
	## based on the player's light meter
	EnemyObj.hearing()
	if EnemyObj.health <= 0:
		StateChangeSignal.emit("EnemyDeathState")
		
	
	patroltopoint()
	
	if EnemyObj.playerseen != null:
		EnemyObj.sight()
		pass
	
	pass

	
func playerhealing():
	if EnemyObj.Suspicion >= EnemyObj.MaxSuspicion:
		StateChangeSignal.emit("EnemyInvestigateState")
		pass
	
	
	pass
	

func patroltopoint():
	## make the enemy patrol to the specific point
	## when they meet the point, trigger a signal that changes the point and then
	## re-calls the patroltopoint func
	var currentpos = EnemyObj.global_position
	if EnemyObj.CurPatrolPoint != null:
		set_process(false)
		await get_tree().process_frame
		set_process(true)
		Pointdir = EnemyObj.global_position.direction_to(EnemyObj.CurPatrolPoint.global_position)
		var Lookangle = atan2(Pointdir.x,Pointdir.z) # Gets the angle from the result of the distance_to function
		EnemyObj.rotation = EnemyObj.rotation.lerp(Vector3(0,Lookangle,0),0.5) # sets the y rotation to the result of lookangle
		if EnemyObj.Navagent.target_position != null:
			EnemyObj.Navagent.target_position = EnemyObj.CurPatrolPoint.global_position # Sets the pathfinding position to the player's position
			nextpathpos = EnemyObj.Navagent.get_next_path_position()
			chasevelocity = Patrolspeed * EnemyObj.global_position.direction_to(nextpathpos)
			EnemyObj.Navagent.set_velocity(chasevelocity)
		else:
			pass
		
	else:
		StateChangeSignal.emit("EnemyIdleState")
		
		
		pass
	
	pass
#
#func chaseplayer():
	#
	#StateChangeSignal.emit("EnemyChaseState")
	#
	#pass


func changepoint():
	#print("changing point")
	if EnemyObj.StateMachineNode.EntityState is EnemyPatrolState :
	
		if EnemyObj.CurPatrolPoint != null:
			
			if EnemyObj.CurPatrolPoint.nextpoint != null:
				
				EnemyObj.CurPatrolPoint = EnemyObj.CurPatrolPoint.nextpoint
				if EnemyObj.CurPatrolPoint.Action == EnemyObj.CurPatrolPoint.Act.Normal:

					patroltopoint()
					EnemyObj.WaitTime = 0
					pass

					
					pass
				if EnemyObj.CurPatrolPoint.Action == EnemyObj.CurPatrolPoint.Act.Wait:
					
					#print("i have to wait here")
					StateChangeSignal.emit("EnemyWaitState")
					EnemyObj.WaitTime = EnemyObj.CurPatrolPoint.waitlength
					pass
				
				
		else:
			EnemyObj.velocity = Vector3.ZERO
			#print("the current patrolpoint is null !")
			pass
		pass
	else:
		pass
		#print("cannot change point !")


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	if EnemyObj.StateMachineNode.EntityState is EnemyPatrolState:
		EnemyObj.velocity = EnemyObj.velocity.move_toward(safe_velocity,5)
		EnemyObj.move_and_slide()
	
	
	
	pass
