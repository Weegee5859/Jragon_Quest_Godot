extends "res://Projectiles/projectile.gd"


func _physics_process(delta):
	#velocity.x = velocity_component.moveIndirection(direction.x,speed)
	#velocity.z = velocity_component.moveIndirection(direction.z,speed)
	scale = lerp(scale, scale*1.05 ,0.4)
	move_and_slide()
