extends VSplitContainer
@export var plyr : Player

var objectivenode = preload("res://Scripts/Objectives/objective_item_base.gd")

func _process(delta: float) -> void:
	if plyr.PrimaryObjectiveList.size() <= self.get_child_count():
		for item in plyr.PrimaryObjectiveList.size():
			var objective = objectivenode.instantiate()
			objective.label.text = plyr.PrimaryObjectiveList[item]
			pass
		pass
	
	pass
