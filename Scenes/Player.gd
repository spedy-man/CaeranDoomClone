extends KinematicBody

#basic variables
var velocity = Vector3()
var gravity = -30
var max_speed = 8
var mouse_senstivity = 0.002

#gun variables
onready var pistol = preload("res://Scenes/Pistol.tscn")
onready var shotgun = preload("res://Scenes/Shotgun.tscn")
onready var rapid = preload("res://Scenes/Rapid.tscn")
onready var heart = preload("res://Scenes/Heart.tscn")
var current_gun = 0
onready var carried_guns = [pistol,shotgun,rapid,heart]

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

func _input(event):
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
	if Input.is_action_just_pressed("jump"):
		velocity.y = 10
	velocity = move_and_slide(velocity, Vector3.UP, true)

func change_gun(gun):
	$Pivot/Gun.get_child(0).queue_free()
	var new_gun = carried_guns[gun].instance()
	$Pivot/Gun.add_child(new_gun)
	PlayerStats.current_gun = new_gun.name

func _process(delta):
	if Input.is_action_just_pressed("next_gun"):
		current_gun+=1
		if current_gun > len(carried_guns)-1:
			current_gun = 0
		change_gun(current_gun)
	elif Input.is_action_just_pressed("prev_gun"):
		current_gun -= 1
		if current_gun < 0:
			current_gun = len(carried_guns)-1
		change_gun(current_gun)
	elif Input.is_action_just_pressed("use"):
		if $InteractCast.is_colliding():
			if $InteractCast.get_collider().is_in_group("Door"):
				$InteractCast.get_collider().get_node("AnimationPlayer").play("OpenDoor")
				print("Door Open")
