extends Node3D
class_name VelocityComponent

@export var character: CharacterBody3D

@export var default_speed: float = 5.0
var speed: float = 5.0
@export var jump_velocity: int = 5.5
@export var gravity: float = 12.5
@export var knockback_resistance: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = default_speed

func moveIndirection(direction:float,speed:float):
	return direction * speed

func setSpeed(new_speed):
	speed = new_speed
	
func setSpeedToDefault():
	speed = default_speed

func applyGravity(delta):
	character.velocity.y -= gravity * delta
	
func deaccelerate():
	character.velocity.x = move_toward(character.velocity.x, 0, speed)
	character.velocity.z = move_toward(character.velocity.z, 0, speed)

func takeKnockback(target_pos:Vector3,knockback: float):
	var final_knockback = knockback-knockback_resistance
	if final_knockback<=0: return
	
	var dir = (target_pos-character.position).normalized() * final_knockback
	dir.y=final_knockback
	character.velocity = dir

	#character.velocity.x += dir.x
	#character.velocity.y += dir.y
	#character.velocity.y += velocity_component.jump_velocity
	#character.velocity.z += dir.z

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
