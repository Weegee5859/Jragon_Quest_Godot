extends "res://Projectiles/projectile.gd"


func _ready():
	hitbox_component.connect("collidedWithFloor", kill)
	hitbox_component.connect("collidedWithEntity", kill)

func _physics_process(delta):
	velocity.x = velocity_component.moveIndirection(direction.x,velocity_component.speed)
	velocity.z = velocity_component.moveIndirection(direction.z,velocity_component.speed)
	rotation.y += 0.4
	scale.z -= 0.01
	move_and_slide()

func onDeath():
	pass

func kill():
	onDeath()
	print("projectile dead")
	queue_free()



func _on_projectile_timer_timeout():
	kill()

