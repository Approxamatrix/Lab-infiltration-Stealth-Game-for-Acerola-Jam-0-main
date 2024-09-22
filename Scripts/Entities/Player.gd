extends GameEntity
class_name Player

var InputVector : Vector3
var OldInputVector : Vector3
@export var PlayerCamera : Camera3D
@export var WalkSpd : float
@export var RunSpd : float
@export var CrouchSpd : float
@export var Fallspeed : float
@export var JumpPower : float
@export var CrouchJumpPower : float
@export var FrontLedgeCheck : RayCast3D
@export var TopLedgeCheck : RayCast3D
@export var LedgeBlockedCheck : ShapeCast3D
@export var LedgeBlockedCheckerOffset : float # -1.986 seems to be a good value for this variable
@export var maxhealth : float
@export var lightmeter : Node3D
@export var PlayerHand : PlayerHand
var lightmeterval : float
var dummy
@export var EquippedItemData : SlotData = null
@export var ItemUseRay : RayCast3D
@export var CameraNode : Node3D
@export var NoiseNode : Area3D
@export var PlayerCollider : CollisionShape3D
@export var PlayerAnim : AnimationPlayer
@export var Statemanager : StatemachineManager
@export var Flashlight : SpotLight3D
@export var BatonHit : AudioStreamPlayer3D
@export var WalkSound : AudioStreamPlayer3D
@export var WalkTimer : Timer
@export var Walksoundtime: float
@export var Runsoundtime : float
@export var inspectlabel : RichTextLabel
@export var moneyamt : RichTextLabel
@export var gameoverscene : PackedScene
@export var healthlabel : RichTextLabel
var Flashlightstate : bool
var CurrentPatrolPoint
var NextPatrolPoint
@export var itemcollectsound : AudioStreamPlayer
@export var objectivecontainer : VSplitContainer

@export var PrimaryObjectiveList : Array[Objective]
@export var SecondaryObjectiveList : Array[Objective]
var CurrentObjective : Objective

func _ready():
	GameJamAutoload.UpdatePlayerHand.connect(UpdateHand)
	GameJamAutoload.AskPlayerPos.connect(sendplayerpos)
	GameJamAutoload.PlayItemCollectSound.connect(itemcollectionsound)
	GameJamAutoload.DisplayInspectText.connect(inspecttext)
	PlayerHand.EquippedSprite.texture = null
	PlayerHand.EquippedMesh.mesh = null
	Flashlightstate = true
	
	
	if maxhealth == null or 0:
		maxhealth = 10
		pass
	else:
		health = maxhealth
	pass
	
	healthlabel.text = "Health : %d" %health
	

func inspecttext(text : String):
	inspectlabel.show()
	inspectlabel.text = "[center]" + text +"[/center]"
	
	pass
func _physics_process(delta):
	healthlabel.text = "Health : %d" %health
	moneyamt.text = "Money : %d" %GameJamAutoload.money
	if health <= 0:
		if !Statemanager.EntityState is PlayerDeathState:
			#print("Player has died")
			Statemanager.changestate("PlayerDeathState")
			
		
		
		
		
		## Play a death animation here. Just make the camera tilt and go down.
		## Also, present a restart screen. It should show the amount of money the player has gotten that run.
		## It should also have a restart button that reloads the level.
		## it should also have a button that goes abck to the menu.
		
		pass
		
	if lightmeter.global_position != global_position:
		lightmeter.global_position = global_position
	
	if lightmeter.lightmetercam.global_position != global_position:
		lightmeter.lightmetercam.global_position = global_position
		lightmeter.lightmetercam.global_position.y += 0.5
	
	if lightmeter != null:
		lightmeterval = lightmeter.finalbrightness
	
	MoveInput()
	UseInput()
	FlashlightInput()
	move_and_slide()
	pass

func FlashlightInput():
	if Input.is_action_just_pressed("Flashlight"):
		if Flashlightstate == true:
			Flashlight.light_energy = 0
			Flashlightstate = false
		else:
			Flashlight.light_energy = 3
			Flashlightstate = true
		
		pass
	
	
	pass

func sendplayerpos():
	
	
	GameJamAutoload.SendPlayerPos.emit(global_position)
	pass




func MoveInput():
	
	OldInputVector.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	OldInputVector.z = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")
	
	InputVector = OldInputVector.rotated(Vector3.UP, PlayerCamera.global_rotation.y).normalized()
	
	
	
	
	pass

func itemcollectionsound():
	
	itemcollectsound.play()
	
	pass

func takedamage(damageval):
	health -= damageval
	
func UpdateHand(playerobj : Player, data : SlotData):
	
	if data != null:
		if data.itemdata.ItemMesh == null:
			PlayerHand.EquippedSprite.texture = data.itemdata.ItemIcon
			PlayerHand.EquippedMesh.mesh = null
			EquippedItemData = data
		else:
			
			PlayerHand.EquippedMesh.mesh = data.itemdata.ItemMesh ## placeholder for until I add the mesh or scene to the itemdata datatype
			EquippedItemData = data
		print("Player currently Holding : " + data.itemdata.ItemName)
	if data == null:
		PlayerHand.EquippedSprite.texture = null
		PlayerHand.EquippedMesh.mesh = null
		EquippedItemData = null
	
	
	pass

func UseInput():
	
	if Input.is_action_just_pressed("PrimaryUse"):
		PrimaryUse()
	if Input.is_action_just_pressed("SecondaryUse"):
		SecondaryUse()
	
	pass

func PrimaryUse():
	if EquippedItemData != null:
		
		match EquippedItemData.itemdata.ItemType:
			EquippedItemData.itemdata.type.KeyCard:
				print("Maybe I can use this to unlock a door !")
				
				
			EquippedItemData.itemdata.type.Healing: ##thus should increase the player's health
				EquippedItemData.ItemAmt -= 1
				GameJamAutoload.UpdateHotbar.emit()
				print("Healed player")
				
				
			EquippedItemData.itemdata.type.RangedWeapon:
				
				EquippedItemData.ItemAmt -= 1
				##for this, when launched at that point, tween the dart to that point, and if it doesn't hit an enemy, spawn a decal and set it's collision rotation based off the collision normal 
				
				if ItemUseRay.is_colliding():
					print("Shot weapon at " + str(ItemUseRay.get_collision_point()))
					##if the ray collides with an enemy, then take out some damage based off the item data
					## I'm not giving the player a gun so this will be empty lolol
				else:
					
					print("Missed shot !")
				GameJamAutoload.UpdateHotbar.emit()
				print("Pew pew !")
				
				
				
			EquippedItemData.itemdata.type.Melee:
				
				GameJamAutoload.UpdateHotbar.emit()
				## if there is an enemy that enters the area, 
				PlayerAnim.play("MeleeAttack")
				## get dot product
				## if enemy is at the front, take damage
				## if enemy is behind, knock them out
				print("Pow !")
				
				
				
			EquippedItemData.itemdata.type.Projectile:
				## A projectile scene should be instantiated.
				## It should then have it's meshinstance value be set to the itemdata's projectile mesh
				var ProjectileScene = load("res://Scenes/Projectiles/ProjectileScene.tscn")
				#if EquippedItemData.itemdata.ItemMesh != null:
					#ProjectileScene.ProjectileMesh = EquippedItemData.itemdata.ItemMesh
				#
				EquippedItemData.ItemAmt -= 1
				
				
					
				
				if ItemUseRay.is_colliding():
					#ProjectileObj
					var Projectile : CharacterBody3D = ProjectileScene.instantiate()
					
					match EquippedItemData.itemdata.ProjectileMode:
						EquippedItemData.itemdata.Mode.Type_SHOCK:
							Projectile.ProjectileType = Projectile.Type.Type_SHOCK
							pass
						EquippedItemData.itemdata.Mode.Type_NOISE:
							Projectile.ProjectileType = Projectile.Type.Type_NOISE
							pass
						
					
					
					var ProjectileTween = create_tween()
					add_child(Projectile)
					if EquippedItemData.itemdata.ProjectileMesh != null:  ##if no ProjectileMesh is set in item's resource file
						Projectile.ProjectileMesh.mesh = EquippedItemData.itemdata.ProjectileMesh
						print(EquippedItemData.itemdata.ProjectileMesh)
					else:
						
						
						
						pass
						#print(EquippedItemData.itemdata.ProjectileMesh)
					print("Shot weapon at " + str(ItemUseRay.get_collision_point()))
					#Projectile.look_at(ItemUseRay.get_collision_normal(),Vector3.UP,false)
					#Projectile.rotation.y = Projectile.rotation.y
					Projectile.top_level = true
					
					ProjectileTween.tween_property(Projectile,"global_position", ItemUseRay.get_collision_point(),0.1)
					#Projectile.global_position = ItemUseRay.get_collision_point()
					
					##for this, when launched at that point, tween the model to that point, and set it's collision rotation based off the collision normal
					
				else: ##if the itemuse raycast did not collide with anything
						##if it doesn't collide, set the freeze value to off and apply a central impulse
						## if it collides with a surface, set the freeze value to on and set it's rotation based off the collision normal
					
					
					
					print("Could not shoot !")
					EquippedItemData.ItemAmt += 1
					
				GameJamAutoload.UpdateHotbar.emit()
				print("Deploying !")
				
				
		if EquippedItemData.ItemAmt <= 0:
			EquippedItemData = null
		print("Used Item")
	else:
		print("No item equipped !")
	
	pass



func SecondaryUse():
	if EquippedItemData != null:
		
		match EquippedItemData.itemdata.ItemType:
			EquippedItemData.itemdata.type.KeyCard:
				
				pass
			EquippedItemData.itemdata.type.Healing:
				#EquippedItemData.ItemAmt -= 1
				#GameJamAutoload.UpdateHotbar.emit()
				print("No secondary use available")
				pass
				#print("Healed player")
			EquippedItemData.itemdata.type.RangedWeapon:
				#EquippedItemData.ItemAmt -= 1
				#GameJamAutoload.UpdateHotbar.emit()
				##this could have the player aim and then when they press the primary aim, they shoot
				pass
			EquippedItemData.itemdata.type.Melee: ##this could be an attack that charges up
				#EquippedItemData.ItemAmt -= 1
				GameJamAutoload.UpdateHotbar.emit() 
				print("Pow !")
			EquippedItemData.itemdata.type.Projectile: ##this could maybe deploy sleeping gas immediately or maybe set off a shock mine or even set off an explosive
				
				## This could check through nodes in a scene and see if it is in a projectile group.
				## IF it is, it will call that projectile's secondary function
				print("Deploying !")
		
	else:
		print("No item equipped !")
	
	pass



func _on_melee_area_body_entered(body):
	## if there is an enemy that enters the area, 
	if body is Enemy:
		
		if body.plyrdotprod >= 0.38:
			
			pass
		if body.plyrdotprod <= -0.38:
			BatonHit.play()
			body.StateMachineNode.changestate("EnemyStunState")
			pass
		
		pass
	## get dot product
	## if enemy is at the front, take damage
	## if enemy is behind, knock them out
	pass # Replace with function body.


func _on_walk_timer_timeout():
	WalkSound.play()
	pass # Replace with function body.
