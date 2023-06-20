extends Node3D
class_name HealthComponent

@export var max_health: int = 100
@export var healthOwner: CharacterBody3D
@export var health_bar: TextureProgressBar
@onready var health: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	if health_bar:
		updateHealthBar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
		
	if health<=0:
		if healthOwner:
			healthOwner.die()

func updateHealthBar():
	var max_hp: float = max_health
	var hp: float = health
	var percentage: float = (hp / max_hp) * 100
	print("===============================================")
	print(max_health)
	print(health)
	print(percentage )
	print("===============================================")
	health_bar.value = health
	print(health_bar.value)
	

func takeDamage(damage: int):
	health -= damage
	if health_bar:
		updateHealthBar()
	
	print(str(self.get_parent()) + "took " + str(damage) + " damage")
