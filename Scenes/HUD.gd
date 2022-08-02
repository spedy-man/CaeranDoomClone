extends CanvasLayer

onready var armour = $MarginContainer/Stats/Values/ArmourValue
onready var health = $MarginContainer/Stats/Values/HealthValue
onready var ammo = $MarginContainer/Stats/Ammo/AmmoValue

func _process(delta):
	var current_gun = PlayerStats.current_gun
	armour.text = PlayerStats.get_armor()
	health.text = PlayerStats.get_health()
	
	if current_gun == "Pistol":
		ammo.text = PlayerStats.get_pistol_ammo()
	if current_gun == "Shotgun":
		ammo.text = PlayerStats.get_shotgun_ammo()
	if current_gun == "Rapid":
		ammo.text = PlayerStats.get_pistol_ammo()
	if current_gun == "Heart":
		ammo.text = PlayerStats.get_blood_ammo()
	
