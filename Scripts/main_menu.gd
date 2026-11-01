extends Control

func _ready() -> void:
	AudioManager.play_music_infinity("menu")

func lvl1():
	AudioManager.play_ui_sound("click")
	#AudioManager.play_music_infinity("game")
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")

func sound():
	AudioManager.play_ui_sound("click")

func quit():
	get_tree().quit()

func lvl2() -> void:
	AudioManager.play_ui_sound("click")
	AudioManager.play_music_infinity("2")
	get_tree().change_scene_to_file("res://Scenes/level2.tscn")

func menu() -> void:
	#AudioManager.play_music_infinity("menu")
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
