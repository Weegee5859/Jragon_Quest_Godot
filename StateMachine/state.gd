extends Node3D
class_name State
var state_machine: StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent() is StateMachine:
		state_machine = get_parent()
	else:
		print("State: State Machine is not parent, deleting..." + str(self.name))
		queue_free()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func enterState():
	pass
	
func exitState():
	pass
	
func processState():
	pass
