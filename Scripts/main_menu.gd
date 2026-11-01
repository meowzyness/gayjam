extends Control

func _ready() -> void:
	AudioManager.play_music_infinity("menu")
	AudioManager.play_music_infinity("game")
	Banned.add_ban(load("res://Sprites/baggage/scan_item4.png"), 'banned_baggage')

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
