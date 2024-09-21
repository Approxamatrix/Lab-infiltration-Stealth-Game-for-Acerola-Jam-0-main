@tool

extends Node
class_name Loot
@export var updateloot : bool
var lootname : String
var cost : int
#@export var lootobjdata : LootObjectData
@export var lootdata : LootItemData
@export var Itemname : String
@export var Statemachine : InteractionManager
@export var Meshinstance : MeshInstance3D
@export var Collision : CollisionShape3D

## set it up so it works like the slotdata and itemdata stuff 
## first make a lootitem script, that holds, the object's model, name and scale
## next, make a lootobject script that holds the lootitem data as well as the cost


# Called when the node enters the scene tree for the first time.
func _ready():
	checklootdata()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if updateloot == true:
		checklootdata()
		updateloot = false
	pass

func checklootdata():
	
	if lootdata != null:
	
		##next set the mesh value on the meshinstance to the mesh value from the loot.
		##next, set the cost value to the lootdata's cost
		##next , set the lootname val to the loot's name
		## next, set a thing to make the scale of the meshinstance be set to the scale from the lootdata.
		##make this a toolscript so it can be seen in the editor
		if lootdata.LootModel != null and Meshinstance != null:
			Meshinstance.mesh = lootdata.LootModel
		lootname = lootdata.LootItemName
		if lootdata.LootCost != 0:
			cost = lootdata.LootCost
		if lootdata.LootModelScale != Vector3.ZERO:
			Meshinstance.scale = lootdata.LootModelScale
		Collision.position = lootdata.Collisionpos
		if lootdata.collisionscale != Vector3.ZERO:
			Collision.scale = lootdata.collisionscale
			pass
		if Itemname != null:
			
			Statemachine.ItemName = "[center]" + lootname + "[/center]"
			
			pass
		else:
			
			Itemname = "item name not set"
			Statemachine.ItemName = Itemname
			pass
		
		
		pass
		pass
	else:
		if Meshinstance.mesh != null:
			Meshinstance.mesh = null
	
	pass
##first check the slotdata to see if it exists
## next see if the slot's lootdata exists.
