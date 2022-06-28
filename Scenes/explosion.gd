extends Area

var blood_speed = 15
var blood_damage = 25

func deal_damage():
	var enemies = get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group("Enemy"):
			body.take_damage(blood_damage)
	enemies = $SplashDamage.get_overlapping_bodies()
	for body in enemies:
		if body.is_in_group("Enemy"):
			body.take_damage(blood_damage)

func _process(delta):
	translate(Vector3.FORWARD * blood_speed * delta)

func _on_explosion_body_entered(body):
	if body.is_in_group("Player"):
		return
	set_process(false)
	$AnimatedSprite3D.play("explode")
	deal_damage()
	yield($AnimatedSprite3D,"animation_finished")
	queue_free()

func _on_SplashDamage_body_entered(body):
	pass
