extends Node2D


var person_scene := preload("res://character_body_2d.tscn")

func _ready() -> void:
	$Timer.start()

func _on_timer_timeout() -> void:
	var person := person_scene.instantiate()
	get_tree().current_scene.add_child(person)
	var offset := Vector2(randf_range(-20, 20), 0)
	person.global_position = global_position + offset
	person.global_scale.y = randf_range(1, 2)

	$Timer.wait_time = randf_range(0.5, 1)
	$Timer.start()
