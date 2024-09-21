extends BaseInteractNode
class_name StealLoot

var StealTween
var Playerpos
@export var collision : CollisionShape3D

##Set up an interaction script:
##- First, get the parent item's lootdata.
##- Next, from that data, get the cost
##- Next, emit a signal to get the player's position
##- Next, with the player's position, tween the parent node to the player's position
##- Next, when the tween finished signal is emitted, add the cost to the player's total money amt and then call queue_free()


# Called when the node enters the scene tree for the first time.
func _ready():
	GameJamAutoload.SendPlayerPos.connect(receiveplayerpos)
	GameJamAutoload.PrimaryInteraction.connect(interact)
	pass # Replace with function body.

func receiveplayerpos(pos :Vector3):
	Playerpos = pos
	pass
	

func interact(item):
	
	if parentitem == item:
		stealaction()
		pass
	
	pass

func stealaction():
	StealTween = create_tween()
	
	GameJamAutoload.AskPlayerPos.emit()
	
	StealTween.tween_property(parentitem,"position",Playerpos,0.15)
	#set up tween stuff
	collision.disabled = true
	#collectsound.play()
	GameJamAutoload.PlayItemCollectSound.emit()
	StealTween.finished.connect(ontweenfinish)
	
	pass

func ontweenfinish():
	if parentitem.lootdata != null:
		GameJamAutoload.money += parentitem.lootdata.LootCost
		
	parentitem.queue_free()
	print(GameJamAutoload.money)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
