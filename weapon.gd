extends Node3D
class_name Weapon

@onready var damage: DamageStats = $DamageStats
@export var hitbox_component: HitboxComponent = null
@export var animation_player: AnimationPlayer
@export var projectile_spawner: ProjectileSpawnerComponent
@export var entity: CharacterBody3D
@onready var swipe = $Swipe
@onready var swipe2 = $Swipe2


func primaryAction():
	print(animation_player.current_animation)
	print(animation_player.current_animation_position)
	if animation_player.current_animation == "sword_swipe_1" and animation_player.current_animation_position >= 0.3 and projectile_spawner:
		projectile_spawner.spawnProjectile("sword_strash",entity.position,entity.last_nonzero_direction.normalized())
		playAnimation("sword_spin",true)
	if animation_player.current_animation == "sword_idle":
		playAnimation("sword_swipe_1",true)
	enableHitbox()

func secondaryAction():
	return

		
	

func playIdle():
	playAnimation("sword_idle")
	disableHitbox()
	
	
func playAnimation(animation_name="",override=false):
	if animation_player:
		if animation_player.is_playing() and override==false: return
		animation_player.play(animation_name)

func disableHitbox():
	if hitbox_component:
		hitbox_component.disableHitbox()
	
func enableHitbox():
	if hitbox_component:
		hitbox_component.enableHitbox()
