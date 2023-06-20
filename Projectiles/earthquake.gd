extends "res://Projectiles/projectile.gd"

@onready var scale_height = scale.y*1.05
@onready var quake_speed = 8

func _ready():
	position.y -= 2
	print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE")

func _physics_process(delta):
	if not is_on_floor():
		velocity_component.applyGravity(delta)
		hitbox_component.disableHitbox()
	
	if is_on_floor():
		hitbox_component.enableHitbox()
		velocity.x = velocity_component.moveIndirection(direction.x,velocity_component.speed)
		velocity.z = velocity_component.moveIndirection(direction.z,velocity_component.speed)
		if not animation_player.is_playing():
			animation_player.play("earthquake")
		#if scale.y < 5:
			#hitbox_component.enableHitbox()
			#hitbox_component.collisionbox.scale.y = scale.y+10*delta
			#scale.y = scale.y+10*delta
			#scale.x = scale.x-5*delta
			#scale.z = scale.z-5*delta
		#else:
			#print("reached")
			#hitbox_component.disableHitbox()
			
			#hitbox_component.collisionbox.scale.y = 1
			#scale.y = 1
			#scale.x = 1
			#scale.z = 1
	move_and_slide()
