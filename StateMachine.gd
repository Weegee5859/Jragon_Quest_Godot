extends Node3D
class_name StateMachine
@export var states: Array[State]
var current_state: State

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state.runState()
	
func changeState(newState: State):
	if current_state:
		current_state.endState()
	# Change current state to new state
	current_state = newState
	current_state.readyState()
