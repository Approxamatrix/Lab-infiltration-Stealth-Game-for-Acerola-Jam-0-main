extends BaseState
class_name EnemyAttackState

@export var EnemyObj : Enemy
@export var attackcooldown : Timer
var oldpos
##have an area3d
## activate it in the animation.
## set up the thing so that when the area detects something, it calls attack

func enter():
	oldpos = EnemyObj.global_position
	
	EnemyObj.audioplayer.stream = EnemyObj.attackvoice
	EnemyObj.audioplayer.play()
	
	#EnemyObj.Model.rotation =  EnemyObj.rotation.lerp(Vector3(0,deg_to_rad(180),0),1)
	if attackcooldown:
		if attackcooldown.is_stopped():
			attack()
	pass

func exit():
	
	pass
	
	
func update():
	EnemyObj.soundawareness = 0
	EnemyObj.global_position = oldpos
	if !EnemyObj.animplayer.is_playing():
			StateChangeSignal.emit("EnemyChaseState")
	
	#if EnemyObj.plyrdotprod <= 0.8:
		#StateChangeSignal.emit("EnemyPatrolState")
	#else:
		#if EnemyObj.playerseen.lightmeterval < 5:
			#StateChangeSignal.emit("EnemyPatrolState")
	#
	
	#attack()
	
	pass
	
func attack():
	print("hihihi")
	if EnemyObj.playerseen != null:
		EnemyObj.playerseen.takedamage(EnemyObj.attackdamage)
		#EnemyObj.playerseen.health -= 3
		EnemyObj.animplayer.play("Guard/Attack")
		#EnemyObj.playerseen.queue_free()
		print(EnemyObj.playerseen.health)
		attackcooldown.start()
		
	pass




func _on_attack_area_body_entered(body):
	if body is Player:
		EnemyObj.BatonHit.play()
		attack()
		
	pass # Replace with function body.


func _on_attack_detection_body_entered(body):
	
	if body is Player:
		EnemyObj.BatonHit.play()
		attack()
	
	pass # Replace with function body.
