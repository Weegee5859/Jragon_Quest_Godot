extends "res://Projectiles/projectile.gd"
class_name Fireball

func _ready():
	hitbox_component.connect("collidedWithFloor", kill)
	hitbox_component.connect("collidedWithEntity", kill)
	#position.y += 1
	
func _physics_process(delta):
	velocity.x = velocity_component.moveIndirection(direction.x,velocity_component.speed)
	velocity.z = velocity_component.moveIndirection(direction.z,velocity_component.speed)
	velocity.y = velocity_component.moveIndirection(direction.y,velocity_component.speed)
	rotation.z += 0.1
	move_and_slide()

func onDeath():
	var temp_pos = position
	temp_pos.y -= 0
	projectile_spawner.spawnProjectile("explosion",temp_pos,Vector3(0,0,0))
	
	


#func _on_projectile_timer_timeout():
	#kill()
