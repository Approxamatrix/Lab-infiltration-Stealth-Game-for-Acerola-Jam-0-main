extends Node
class_name PlayerInteractionManager

@export var InteractRay : RayCast3D
@export var InteractLabel : RichTextLabel
@export var InteractListNode : VBoxContainer
@export var InspectLabel : RichTextLabel
#var loopcount : int
#var interactionarray : Array[BaseInteractNode]
var InteractIndicator = preload("res://Scenes/Interaction_System/interaction_label.tscn")
func _process(delta):
	checkforinteraction()
	
	pass

func checkforinteraction():
	var item = InteractRay.get_collider()
	if item != null:
		#print(item)
		if item.is_in_group("interact"):
			#print("AAAAAAAA")
			InteractionList(item)
			#print(item)
			
			for child in item.get_children():
				
				if child is InteractionManager:
					
					InteractLabel.text = "[center]" + child.ItemName + "[/center]"
					#print(child.ItemName)
					InteractLabel.show()
					pass
				else:
					#InteractLabel.hide()
					pass
				pass
			
			#enables a label telling players to interact
			#InteractLabel.text = item. #have this show the 
			
			
			if Input.is_action_just_pressed("Interact"):
				#item.interact()
				GameJamAutoload.PrimaryInteraction.emit(item)
			if Input.is_action_just_pressed("Inspect"):
				GameJamAutoload.SecondaryInteraction1.emit(item)
			pass
		else:
			InteractLabel.text = " "
			InteractLabel.hide()
			InspectLabel.text = " "
			InspectLabel.hide()
			
			for child in InteractListNode.get_children():
			
				child.queue_free()
			#loopcount = 0
			pass
			
	else:
		InteractLabel.text = " "
		InteractLabel.hide()
		#InspectLabel.text = " "
		#InspectLabel.hide()
		
		
		for child in InteractListNode.get_children():
			
			child.queue_free()
			#loopcount = 0
			pass
		pass

func InteractionList(interactednode : CharacterBody3D):
	for child in interactednode.get_children():
		## make the instantiate stuff etc, etc, not repeat for every baseinteraction node.
		if child is InteractionManager:
			if InteractListNode.get_child_count() < child.get_child_count():
				for interactions in child.get_children():
					var interactionitem = InteractIndicator.instantiate()
					print(interactions)
					
					if interactions is BaseInteractNode:
						interactionitem.text = interactions.InteractionName
						InteractListNode.add_child(interactionitem)
					else:
						interactionitem.text = "No interaction text set !"
						InteractListNode.add_child(interactionitem)
					pass
					#loopcount += 1
			else:
				pass
			pass
		
		pass
		
	pass
