extends Spatial

onready var gun_sprite = $CanvasLayer/Control/GunSprite
onready var gun_rays = $GunRays.get_children()
onready var flash = preload("res://Scenes/Flash.tscn")
onready var blood = preload("res://Scenes/Blood.tscn")

var can_shoot = true
var damage = 8
var repeat = false
export var rapid_fire = false


func _ready():
	gun_sprite.play("idle")

func check_hit():
	for ray in gun_rays:
		if ray.is_colliding():
			if ray.get_collider().is_in_group("Enemy"):
				ray.get_collider().take_damage(damage)
				var new_blood = blood.instance()
				get_node("/root/World").add_child(new_blood)
				new_blood.global_transform.origin = ray.get_collision_point()
				new_blood.emitting = true

func make_flash():
	var f = flash.instance()
	add_child(f)

func _process(delta):
	if Input.is_action_pressed("shoot") and can_shoot and repeat == false and PlayerStats.ammo_pistol > 0:
		gun_sprite.play("shoot")
		yield (gun_sprite,"animation_finished")
		repeat = true
	if Input.is_action_pressed("shoot") and can_shoot and repeat and PlayerStats.ammo_pistol > 0:
		gun_sprite.play("shooting")
		make_flash()
		check_hit()
		$Timer.start()
		PlayerStats.change_pistol_ammo(-1)
		can_shoot = false
		yield (gun_sprite,"animation_finished")
	if Input.is_action_just_released("shoot"):
		gun_sprite.play("cooldown")
		yield (gun_sprite,"animation_finished")
		gun_sprite.play("idle")
		repeat = false
		can_shoot = true

func _on_Timer_timeout():
	can_shoot = true
	
