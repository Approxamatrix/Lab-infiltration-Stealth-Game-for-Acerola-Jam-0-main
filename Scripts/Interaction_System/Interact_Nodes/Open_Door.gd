extends BaseInteractNode
class_name OpenDoor

@export var parent : Node3D
@export var closed :bool
@export var body : CharacterBody3D
@export var inspectitem : Inspect
## The interact function in this script is so fucked lmao

func _ready():
	if parent:
		closed  = parent.closed
	else:
		closed = true
	InteractionName = GetActionKey.get_key("Interact") + "Open"
	GameJamAutoload.PrimaryInteraction.connect(interact)


func interact(item):
	if parentitem == item:
		if parentitem.IsLocked == true and parentitem.whichone == true: ##checks if door is locked
			if GameJamAutoload.keycardcollected == true:  ##checks if player has keycard
				body.locksound.play()
				#print("door unlocked !") 
				parentitem.IsLocked  = false ##since the player has the keycard, the door will now be set to be unlocked
				inspectitem.InspectText = " "
				open() ## opens door
			else:
				#print("The door is locked !") ##says that the door is locked
				pass
		if parentitem.IsLocked == true and parentitem.whichone == false:
			if GameJamAutoload.secondkeycardcollected == true:
				body.locksound.play()
				
				#print("door unlocked !")
				parentitem.IsLocked = false
				inspectitem.InspectText = " "
		else:
			if closed == true:
				open()
			elif closed == false:
				close()
			pass
	pass
	
func open():
	parentitem.animplyr.play("Open")
	closed = false
	pass
	
func close():
	parentitem.animplyr.play("Close")
	closed = true
	pass
