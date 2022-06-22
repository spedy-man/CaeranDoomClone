extends Area

var blood_speed = 10

func deal_damage(amount):
	var enemies = get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group("Enemy"):
			body.take_damage(projectile_damage)
	enemies = $SplashDamage.get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group("Enemy"):
			body.take_damage(projectile_splash)

func _process(delta):
	translate(Vector3.FORWARD * speed * delta)

func _on_explosion_body_entered(body):
	pass


func _on_SplashDamage_body_entered(body):
	pass
