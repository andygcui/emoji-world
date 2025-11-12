extends StaticBody2D
var player_inattack_zone = false
var health = 1

func _physics_process(delta):
	deal_with_damage()
	rocks_knocked()

func rocks_knocked():
	if health == 0:
		$AnimatedSprite2D.play("knockdown")
		health = -1
		await get_tree().create_timer(1.0).timeout
		self.queue_free()

func deal_with_damage():
	if player_inattack_zone and Input.is_action_just_pressed("knockdown"):
		health -= 1

func _on_rocks_hitbox_body_entered(body):
	if body.is_in_group("player"):
		player_inattack_zone = true
