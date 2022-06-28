extends Spatial

var can_shoot = true
onready var gunsprite = $CanvasLayer/Control/GunSprite
onready var spawn_location = $Position3D
onready var explosion
onready var blood = preload("res://Scenes/explosion.tscn")

func launch_projectile():
	var new_blood = blood.instance()
	get_node("/root/World").add_child(new_blood)
	new_blood.global_transform = spawn_location.global_transform

func _process(delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		gunsprite.play("shoot")
		launch_projectile()
		can_shoot = false
		yield(gunsprite,"animation_finished")
		can_shoot = true
		gunsprite.play("idle")
		
