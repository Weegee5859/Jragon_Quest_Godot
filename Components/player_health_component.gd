extends "res://Components/health_component.gd"
class_name PlayerHealthComponent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if health<=0:
		if healthOwner:
			print("u dead boi")
			#healthOwner.die()
	


