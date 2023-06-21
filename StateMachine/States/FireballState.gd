extends "res://StateMachine/state.gd"
var fireballs_left: int
@export var fireball_timer: Timer
@export var projectile_spawner: ProjectileSpawnerComponent
@export var target: CharacterBody3D
@export var user: CharacterBody3D
@export var fireball_audio: AudioStreamPlayer

func processState():
	if fireballs_left > 0 and fireball_timer.is_stopped():
		projectile_spawner.spawnProjectile("fireball",user.position,target.position-user.position)
		fireball_audio.play()
		fireballs_left -= 1
		fireball_timer.start()
	if fireballs_left <= 0:
		print("fiebasl nodddee")
		#change_timer.start()
		#current_state = state.idle
		state_machine.changeState("idlestate")
