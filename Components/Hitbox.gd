extends Area3D
class_name HitboxComponent


@export var hitbox_owner: CharacterBody3D
@export var weapon: Weapon
@export var damage: DamageStats
@export var hitbox_enabled: bool = true
@onready var collisionbox: CollisionShape3D = $CollisionShape3D
signal collidedWithFloor
signal collidedWithEntity
#@export var hitbox_cooldown: float = 0.5
#@export var stun: int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	if "p_owner" in get_parent():
		hitbox_owner = get_parent().p_owner
		print(hitbox_owner)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not hitbox_enabled: return
	for hurtbox in self.get_overlapping_areas():
		#print(item)
		if hurtbox is HurtboxComponent:
			if hurtbox.hurtbox_owner == hitbox_owner: continue
			if not hurtbox.hurtbox_enabled: continue
			if weapon:
				hurtbox.hurtboxAction(weapon.damage)
				continue
			if damage:
				hurtbox.hurtboxAction(damage)
				emit_signal("collidedWithEntity")
				continue
			

	for floor in self.get_overlapping_bodies():
		#print(hurtbox)
		if floor is GridMap:
			emit_signal("collidedWithFloor")
			
			#print("HurtBOX found, should be taking dmg")

func disableHitbox():
	hitbox_enabled = false
	
func enableHitbox():
	hitbox_enabled = true
