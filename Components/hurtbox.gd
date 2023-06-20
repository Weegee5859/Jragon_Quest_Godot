extends Area3D
class_name HurtboxComponent

@export var health_component : HealthComponent = null
@export var hitstun_component : HitstunComponent = null
@export var velocity_component : VelocityComponent = null
@export var hurtbox_owner: CharacterBody3D
@export var hurtbox_enabled: bool = true

@onready var collision = $CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for item in self.get_overlapping_areas():
		if item is HitboxComponent:
			pass
			#hurtboxAction()
			
func hurtboxAction(damagestats: DamageStats):
	if not health_component: return
	if not hitstun_component: return
	if hurtbox_enabled == false: return
	if hitstun_component.timer.is_stopped():
		health_component.takeDamage(damagestats.damage)
		hitstun_component.takeHitstun(damagestats.hitstun)
		if velocity_component:
			velocity_component.takeKnockback(damagestats.position,damagestats.knockback)
			
func disableHurtbox():
	hurtbox_enabled = false
	
func enableHurtbox():
	hurtbox_enabled = true
