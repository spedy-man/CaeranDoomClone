extends KinematicBody

#basic variables
var velocity = Vector3()
var gravity = -30
var max_speed = 8
var mouse_senstivity = 0.002

#gun variables


#functions
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forward"):
		input_dir += -global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += -global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += global_transform.basis.x
	#input_dir  = input_dir.normalized(), this command cancels strafing
	return input_dir

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_senstivity)
		$Pivot.rotate_x(-event.relative.y * mouse_senstivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2,1.2)

func _physics_process(delta):
	#gravity
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)

func change_gun():
	pass

func _process(delta):
	pass


