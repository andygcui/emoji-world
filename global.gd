extends Node

var current_scene = "world"
var transition_scene = false
var player_current_attack = false

var regen_opened = 0
var music_opened = 0
var speed_opened = 0
var background_opened = 0
var invis_opened = 0
var chests_collected = false
var number_chests = 0
var regen = 0
var speed = 0
var change = 0
var invisible = 0
var speed_back = false

func player_regen():
	regen += 20

func player_speed():
	speed += 20

func player_invisible():
	invisible += 20
	await get_tree().create_timer(10.0).timeout
	invisible += 20

func collected():
	if number_chests == 5:
		chests_collected = true
		play_message()
		number_chests = 9
	else:
		chests_collected = false

func play_message():
	await get_tree().create_timer(5.0).timeout
	DialogueManager.show_example_dialogue_balloon(load("res://chests_collected.dialogue"), "chests_collected")

var player_exit_house_posx = 290
var player_exit_house_posy = 287
var player_start_posx = -300
var player_start_posy = 200

var game_first_loadin = true

var found_slime_item = false
var given_slime_item = false

func finish_changescene():
	if transition_scene == true:
		if current_scene == "world":
			current_scene = "house"
		else:
			current_scene = "world"
		transition_scene = false
