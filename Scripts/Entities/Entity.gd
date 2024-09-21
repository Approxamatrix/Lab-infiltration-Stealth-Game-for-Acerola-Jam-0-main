extends CharacterBody3D
class_name GameEntity


@export var health : float

func take_damage(damagetaken : float):
	
	health -= damagetaken
	print("Health :")
	print(health)
	
	pass

func takedamage(damage : float):
	
	take_damage(damage)
	print(damage)
	
	pass

func die():
	
	pass


func heal():
	
	
	
	pass
