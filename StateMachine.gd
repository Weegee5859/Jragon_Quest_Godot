extends Node3D
class_name StateMachine
var states: Dictionary
var current_state: State

#Fireball variables
@export var fireball_timer: Timer
@export var projectile_spawner: ProjectileSpawnerComponent
@export var target: CharacterBody3D
@export var fireball_audio: AudioStreamPlayer
#Idle
@export var attack_range : AttackRangeComponent
@export var character: CharacterBody3D
@export var change_timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			child.state_machine = self
			states[child.name.to_lower()] = child
			print(child.name)
			# If no current_state is defined
			# set it to first defined state
			if not current_state:
				current_state = child
	print("--------------------------")
	if current_state:
		current_state.enterState()
	else:
		print("StateMachine: No States Given, Deleting self...")
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state.processState()
		
func changeState(new_states_name: String):
	if not states[new_states_name.to_lower()]:
		print("changeState: State doesnt exist in statemachine's state list!")
		return
	
	#exit current state
	current_state.exitState()
	#change state
	current_state = states[new_states_name.to_lower()]
	#Enter State
	current_state.enterState()
