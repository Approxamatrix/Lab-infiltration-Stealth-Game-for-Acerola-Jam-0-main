extends Node
class_name ObjectiveManager


## maybe there can be an objective list on the player objects
## then the new objective checks for objects of type player,
## and then changes the objective_list[0] bc the 0th one will be the one displayed


enum Obj_Type {Primary, Secondary}

func add_objective_primary(text : String, id : String):
	
	var newobj : Objective
	newobj.objid = id
	newobj.objtext = text
	
	for node in get_tree().get_nodes_in_group("Player"):
		node.PrimaryObjectiveList.append(newobj)
		pass
		
	
	pass


func add_new_objective_secondary(text : String, id : String):
	
	var newobj : Objective
	newobj.objid = id
	newobj.objtext = text
		

	for node in get_tree().get_nodes_in_group("Player"):
		node.SecondaryObjectiveList.append(newobj)
		pass
		
	
	
	pass



func delete_objective_primary(id : String):
	
	for node in get_tree().get_nodes_in_group("Player"):
		for obj in node.PrimaryObjectiveList:
			if obj.id == id:
				node.PrimaryObjectiveList.remove_at(node)
			pass
		pass
	
	pass




func delete_objective_secondary(id : String):
	
	for node in get_tree().get_nodes_in_group("Player"):
		for obj in node.SecondaryObjectiveList:
			if obj.id == id:
				node.SecondaryObjectiveList.remove_at(node)
			pass
		pass
	
	pass


func clear_all_objectives(type : Obj_Type):
	
	if type == Obj_Type.Primary:
		
		for node in get_tree().get_nodes_in_group("Player"):
			node.PrimaryObjectiveList.clear()
			
			pass
		
		
		pass
		
	if type == Obj_Type.Secondary:
			
		for node in get_tree().get_nodes_in_group("Player"):
			node.SecondaryObjectiveList.clear()
			
			pass
		
		
		
		pass
	
	
	pass
















#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
