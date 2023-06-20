extends Node3D
class_name ProjectileSpawnerComponent
@export var p_spawner_owner: CharacterBody3D


func spawnProjectile(name,position,direction):
	print("res://Projectiles/"+name+".tscn")
	var directory = DirAccess.open("res://Projectiles/"+name+".tscn")
	if not directory:
		print("Projectile doesn't exists")
	#var projectileExists = directory.dir_exists("res://Projectiles/"+name+".tscn")

	var projectile = load("res://Projectiles/"+name+".tscn")
	var projectileInstance = projectile.instantiate()
	projectileInstance.direction = (direction).normalized()
	projectileInstance.position = position
	if get_parent().get("p_owner"):
		projectileInstance.setOwner(get_parent().p_owner)
	else:
		projectileInstance.setOwner(p_spawner_owner)
	#projectileInstance.p_owner = p_spawner_owner
	#projectileInstance.hitbox_component.hitbox_owner = p_owner
	#print(p_spawner_owner)
	#return
	#projectileInstance.position.y += 1
	get_tree().get_root().get_child(0).add_child(projectileInstance)
