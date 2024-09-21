extends BaseInteractNode
class_name CollectItem

@export var collision : CollisionShape3D
#@export var ItmDataNode : ItemDataNode
var StealTween : Tween
var Playerpos

func _ready():
	InteractionName = GetActionKey.get_key("Collect") + "Collect"
	GameJamAutoload.PrimaryInteraction.connect(interact)
	GameJamAutoload.SendPlayerPos.connect(receiveplayerpos)

func tweentoplayer():
	
	StealTween = create_tween()
	
	GameJamAutoload.AskPlayerPos.emit()
	
	StealTween.tween_property(parentitem,"position",Playerpos,0.15)
	#set up tween stuff
	if collision:
		collision.disabled = true
	GameJamAutoload.PlayItemCollectSound.emit()
	StealTween.finished.connect(ontweenfinish)


func receiveplayerpos(pos :Vector3):
	Playerpos = pos
	pass
	

func ontweenfinish():
	
	
	parentitem.queue_free()
	pass
	

func interact(item):
	
	if parentitem == item:
		print("collecting keycard !")
		if GameJamAutoload.keycardcollected != true:
			GameJamAutoload.keycardcollected = true
		else:
			GameJamAutoload.secondkeycardcollected = true
		tweentoplayer()
		GameJamAutoload.AddItemSignal.emit(parentitem.pickupslot,parentitem)
		#parentitem.queue_free()
	
	
	
	pass
