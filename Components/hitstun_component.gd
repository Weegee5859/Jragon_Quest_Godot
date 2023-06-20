extends Node3D
class_name HitstunComponent

@onready var timer = $HitstunTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func takeHitstun(time: float):
	if timer.is_stopped() and time>0:
		#print(time)
		timer.wait_time = time
		timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
