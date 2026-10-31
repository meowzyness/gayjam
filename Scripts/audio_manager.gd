extends Node

@onready var main_menu_music: AudioStreamPlayer = $MainMenuMusic
@onready var ui_sound: AudioStreamPlayer = $UiSound

var tracks = {
	"menu": load("res://Music/MainMenuMusic.mp3"),
	"game": preload("res://Music/pizdecRepv2.mp3")
}

var sounds = {
	"click": preload("res://Sounds/Soundpad_clickV2.mp3"),
	"correct": preload("res://Sounds/Soundpad_correct.mp3"),
	"incorrect": preload("res://Sounds/Soundpad_incorrect.mp3"),
	"detected": preload("res://Sounds/Soundpad_detectorV1.mp3"),
	"police": preload("res://Sounds/Soundpad_detectorV2.mp3")
}

var playing_music: String


func get_track(track_name: String):
	var track = tracks[track_name]
	return track


func play_music_once(track_name: String):
	if main_menu_music.stream == tracks[track_name] and main_menu_music.playing:
		return
		
	main_menu_music.stream = tracks[track_name]
	main_menu_music.play()


func play_music_infinity(track_name: String):
	if main_menu_music.stream == tracks[track_name] and main_menu_music.playing:
		return
	
	main_menu_music.stream = tracks[track_name]
	tracks[track_name].loop = true
	playing_music = track_name
	main_menu_music.play()


func play_ui_sound(sound_name: String):
	ui_sound.stream = sounds[sound_name]
	ui_sound.play()
