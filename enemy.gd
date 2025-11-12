extends CharacterBody2D

var speed = 60
var player_chase = false
var player = null
var health = 400
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta):
	update_health()
	deal_with_damage()
	if player_chase:
		position += (player.position - position) / speed
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	if health > 0:
		$AnimatedSprite2D.play("idle")
	if health <= 0:
		$AnimatedSprite2D.play("defeat")
		print("enemy dead...you win")
		Global.game_first_loadin = true
		Global.transition_scene = true
		Global.finish_changescene()
		get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass


func _on_enemy_hitbox_body_entered(body):
	if body.is_in_group("player"):
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.is_in_group("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack == true:
		if can_take_damage == true:
			$hit_sound.play()
			health -= 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("Demon health: " + str(health))
			if health <= 0: 
				$AnimatedSprite2D.play("defeat")
				self.queue_free()

func update_health():
	var health_bar = $health_bar
	health_bar.value = health
	
	if health >= 400:
		health_bar.visible = false
	else:
		health_bar.visible = true


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
