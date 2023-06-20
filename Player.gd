extends CharacterBody3D

@onready var cameraBase = $CameraBase
@onready var PlayerBase = $PlayerBase
@onready var WeaponBase = $WeaponBase
@onready var Sword = $WeaponBase/Hand/Iron_Sword
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var hitstun_component : HitstunComponent = $HitstunComponent
@onready var projectile_spawner : ProjectileSpawnerComponent = $ProjectileSpawnerComponent
@onready var hurtbox = $Hurtbox
@onready var animation_player = $AnimationPlayer
@onready var roll_cooldown = $RollCooldown

@onready var direction: Vector3
@onready var last_nonzero_direction: Vector3

const attacking_rotation_lerp: float = .1
var default_rotation_lerp: float = .5

var current_rotation_lerp: float = .5



func _ready():
	current_rotation_lerp = default_rotation_lerp
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		cameraBase.rotation.y += deg_to_rad(-event.relative.x)
		cameraBase.rotation.x += deg_to_rad(-event.relative.y)
		cameraBase.rotation.x = clamp(cameraBase.rotation.x, -PI/4, PI/4)


func _physics_process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	# Add the gravity.
	if not is_on_floor():
		velocity_component.applyGravity(delta)

	# INPUTS START HERE
	#if hitstun_component.timer.is_stopped() or true:
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += velocity_component.jump_velocity
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP, cameraBase.rotation.y)
	if direction != Vector3(0,0,0): last_nonzero_direction = direction
	if direction:
		velocity.x = velocity_component.moveIndirection(direction.x,velocity_component.speed)
		velocity.z = velocity_component.moveIndirection(direction.z,velocity_component.speed)
		#PlayerBase.rotation.y = atan2(velocity.x, velocity.z)
		PlayerBase.rotation.y = lerp_angle(PlayerBase.rotation.y, atan2(velocity.x, velocity.z), current_rotation_lerp)
		WeaponBase.rotation.y = lerp_angle(WeaponBase.rotation.y, atan2(velocity.x, velocity.z), current_rotation_lerp)
	else:
		velocity_component.deaccelerate()
	
	if Input.is_action_just_pressed("right_click") and roll_cooldown.is_stopped() and is_on_floor() and animation_player.current_animation == "sword_idle":
		animation_player.play("roll")
		velocity_component.setSpeed(velocity_component.speed*2)
		roll_cooldown.start()
		
	if Input.is_action_just_pressed("right_click"):
		Sword.secondaryAction()
	
	if Input.is_action_just_pressed("left_click"):
		Sword.primaryAction()
		#PlayerBase.rotation.y = WeaponBase.rotation.y
		#current_rotation_lerp = attacking_rotation_lerp
	else:
		if not Sword.animation_player.is_playing():
			Sword.playIdle()
			current_rotation_lerp = default_rotation_lerp
	# INPUTS END HERE
	
	move_and_slide()
	
func die():
	onDeath()
	queue_free()

func onDeath():
	pass
