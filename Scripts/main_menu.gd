extends Control

func _ready() -> void:
	AudioManager.play_music_infinity("menu")
	AudioManager.play_music_infinity("game")

func _on_start_button_pressed():
	AudioManager.play_ui_sound("click")
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")

func _on_exit_button_pressed():
	get_tree().quit()


func sound() -> void:
	AudioManager.play_ui_sound("click2")
