extends CharacterBody3D


@onready var EnemyBase = $EnemyBase
@onready var velocity_component : VelocityComponent = $VelocityComponent
@onready var hitstun_component : HitstunComponent = $HitstunComponent
@onready var attack_range : AttackRangeComponent = $AttackRangeComponent
@onready var projectile_spawner : ProjectileSpawnerComponent = $ProjectileSpawnerComponent
@onready var animation_player = $AnimationPlayer
@onready var ui_base = $UIBase


func die():
	onDeath()
	queue_free()

func onDeath():
	pass

func _physics_process(delta):
	pass
