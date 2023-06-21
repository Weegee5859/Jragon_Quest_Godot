extends "res://StateMachine/state.gd"
@export var attack_range : AttackRangeComponent
@export var character: CharacterBody3D
@export var change_timer: Timer


func returnplayerInRange():
	if not attack_range: return null
	for entity in attack_range.get_overlapping_bodies():
		if not entity.name == "Player": return null
		return entity
		
func enterState():
	if change_timer:
		change_timer.wait_time = randi_range(1,2)
		change_timer.start()
		
func processState():
	var player = returnplayerInRange()
	if player:
		state_machine.changeState("fireballstate")
	if character:
		character.velocity = Vector3(0,0,0)
		
