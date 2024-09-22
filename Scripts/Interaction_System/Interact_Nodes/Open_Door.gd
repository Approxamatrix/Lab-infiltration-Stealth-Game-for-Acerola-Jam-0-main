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

## for some reason, setting locked to true with closed and which to false works fine for doors that need the 2nd keycard
## but, setting locked to true and having which to true for the 1st keycard doesn't work properly and instead, the door's just unlocked for some reason
func interact(item):
	if parentitem == item:
		if parentitem.IsLocked == true and parentitem.whichone == true: ##checks if door is locked
			if GameJamAutoload.keycardcollected == true:  ##checks if player has keycard
				print("door unlocked with keycard1")
				body.locksound.play()
				#print("door unlocked !") 
				parentitem.IsLocked  = false ##since the player has the keycard, the door will now be set to be unlocked
				inspectitem.InspectText = " "
				open() ## opens door
			if GameJamAutoload.keycardcollected == false:
				
				inspectitem.InspectText = "The door is locked"
				pass
			
		
		if parentitem.IsLocked == true and parentitem.whichone == false:
			if GameJamAutoload.secondkeycardcollected == true:
				body.locksound.play()
				
				#print("door unlocked !")
				parentitem.IsLocked = false
				inspectitem.InspectText = " "
		if parentitem.IsLocked == false:
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
