extends "res://Enemies/EnemyBase.gd"


enum state {walk, idle, fireball, charge, superjump, earthquake}
@onready var current_state: int = state.walk
@onready var change_timer = $ChangeTimer
@onready var delay_timer = $DelayTimer
@onready var target_direction
@onready var static_direction
@onready var hurtbox = $Hurtbox
@onready var hitbox = $Hitbox
@onready var enemy_collision = $EnemyCollision
@onready var fireball_timer = $FireballTimer
@onready var boss_theme = $BossTheme

# Intro Vars
@onready var first_encounter: bool = true

# Audio
@onready var roar = $Roar
@onready var fireball_audio = $fireball_audio


@onready var fireballs_left: int



func _physics_process(delta):
	
	for entity in attack_range.get_overlapping_bodies():
		if not entity.name == "Player": return
		if first_encounter:
			roar.play()
			boss_theme.play()
			first_encounter = false
		target_direction = (entity.position-self.position).normalized()
		EnemyBase.rotation.y = lerp_angle(EnemyBase.rotation.y, atan2(target_direction.x, target_direction.z), 1)
		hurtbox.rotation.y = lerp_angle(EnemyBase.rotation.y, atan2(target_direction.x, target_direction.z), 1)
		hitbox.rotation.y = lerp_angle(EnemyBase.rotation.y, atan2(target_direction.x, target_direction.z), 1)
		enemy_collision.rotation.y = lerp_angle(EnemyBase.rotation.y, atan2(target_direction.x, target_direction.z), 1)
		ui_base.rotation.y = lerp_angle(ui_base.rotation.y, atan2(target_direction.x, target_direction.z), 1)
		# Walk
		if current_state == state.walk:
			velocity.x = velocity_component.moveIndirection(entity.position.x-position.x,velocity_component.speed)
			velocity.z = velocity_component.moveIndirection(entity.position.z-position.z,velocity_component.speed)
		# EarthQuake
		if current_state == state.earthquake:
			if is_on_floor() and velocity.y<=0:
				# place slightly above ground
				var target_pos = entity.position
				var offset: int = 2
				# straight line earthquake
				projectile_spawner.spawnProjectile("earthquake",self.position,target_direction)
				# right earth quake
				target_pos = entity.position
				target_pos.x += offset
				projectile_spawner.spawnProjectile("earthquake",self.position,target_pos-self.position)
				#left earthquake
				target_pos = entity.position
				target_pos.z += offset
				projectile_spawner.spawnProjectile("earthquake",self.position,target_pos-self.position)
				current_state = state.idle
		if current_state == state.idle:
			#hurtbox.enableHurtbox()
			velocity = Vector3(0,0,0)
		if current_state == state.fireball:
			if fireballs_left > 0 and fireball_timer.is_stopped():
				projectile_spawner.spawnProjectile("fireball",position,entity.position-self.position)
				fireball_audio.play()
				fireballs_left -= 1
				fireball_timer.start()
			if fireballs_left <= 0:
				print("fiebasl nodddee")
				change_timer.start()
				current_state = state.idle
		if current_state == state.charge:
			#hurtbox.enableHurtbox()
			if animation_player.current_animation == "charge":
				velocity.x = 0
				velocity.z = 0
				static_direction = entity.position-position
				print(static_direction)
				print(target_direction)
				continue
			print("--------------")
			print(static_direction)
			print(target_direction)
			velocity.x = velocity_component.moveIndirection(static_direction.x,velocity_component.speed*5)
			velocity.z = velocity_component.moveIndirection(static_direction.z,velocity_component.speed*5)
	velocity_component.applyGravity(delta)
	
	
	move_and_slide()


func _on_change_timer_timeout():
	var attack_array = [state.earthquake,state.fireball,state.charge]
	var rand_attack = attack_array[randi() % attack_array.size()]
	print("change states! times up!")
	#Done with walking
	if current_state == state.walk:
		print("walk done")
		change_timer.wait_time = randi_range(1,2)
		change_timer.start()
		static_direction = target_direction
		current_state = rand_attack
		#current_state = state.earthquake
		#hurtbox.disableHurtbox()
		if current_state == state.charge:
			animation_player.play("charge")
		if current_state == state.earthquake:
			velocity.x = 0
			velocity.z = 0
			velocity.y = 5
		if current_state == state.fireball:
			change_timer.stop()
			fireballs_left = randi_range(3,5)
			#fireball_timer.start()
		return
	# Done with EarthQuake
	if current_state == state.earthquake:
		print("earthquake timer done")
		current_state = state.idle
	if current_state == state.fireball:
		print("fireball timer done")
		current_state = state.idle
	if current_state == state.charge:
		print("charge timer done")
		current_state = state.idle
	# Done with Idle
	if current_state == state.idle:
		print("idle timer done")
		change_timer.wait_time = randi_range(1,2)
		change_timer.start()
		current_state = state.walk
	
