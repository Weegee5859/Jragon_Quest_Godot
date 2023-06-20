extends CharacterBody3D
class_name Projectile

@export var speed: float = 2
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var hitbox_component: HitboxComponent = $Hitbox
@onready var projectile_spawner : ProjectileSpawnerComponent = $ProjectileSpawnerComponent
@onready var direction: Vector3
@onready var animation_player = $AnimationPlayer
@onready var p_owner: CharacterBody3D


func setOwner(real_owner):
	p_owner = real_owner
	print(p_owner)
	position.y += 1
	#if "p_owner" in get_parent():
		#hitbox_owner = get_parent().p_owner
		#print(hitbox_owner)

func _ready():
	pass

func _physics_process(delta):
	velocity.x = velocity_component.moveIndirection(direction.x,velocity_component.speed)
	velocity.z = velocity_component.moveIndirection(direction.z,velocity_component.speed)
	rotation.y += 0.3
	move_and_slide()

func onDeath():
	pass

func kill():
	onDeath()
	print("projectile dead")
	queue_free()



func _on_projectile_timer_timeout():
	kill()
