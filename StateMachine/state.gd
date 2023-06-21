extends Node3D
class_name State
@export var state_machine: StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	# state machine with have a variable named states
	if "states" in get_parent():
		print("state machine found!")
		state_machine = get_parent()
	else:
		print("State Machine not found, DELETETING")
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func runState():
	pass
	
func readyState():
	pass
	
func endState():
	pass
