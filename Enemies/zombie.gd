extends "res://Enemies/EnemyBase.gd"

var fireball = preload("res://Projectiles/fireball.tscn")

func _physics_process(delta):
	velocity_component.applyGravity(delta)
	velocity.x = 0
	velocity.z = 0
	for entity in attack_range.get_overlapping_bodies():
		var dir = (entity.position-position).normalized()
		#print("Player:" + str(item.position))
		#print("Enemy:" + str(position))
		velocity.x = velocity_component.moveIndirection(dir.x,velocity_component.speed)
		velocity.z = velocity_component.moveIndirection(dir.z,velocity_component.speed)
		#var bullet = fireball.instantiate()
		#bullet.direction = (entity.position-position).normalized()
		#bullet.position = position
		#bullet.position.y += 1
		#get_tree().get_root().get_child(0).add_child(bullet)
		#projectile_spawner.spawnProjectile("fireball",self.position,entity.position-self.position)
		#queue_free()
	move_and_slide()
