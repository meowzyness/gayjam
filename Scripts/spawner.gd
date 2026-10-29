extends Node2D


var person_scene := preload("res://Scenes/person.tscn")


func _ready():
	$Timer.start()

func _on_timer_timeout():
	var new_person := person_scene.instantiate()

	add_child(new_person)
	
	var offset := Vector2(randf_range(-20, 20), 0)
	new_person.global_position = global_position + offset
	new_person.global_scale.y = randf_range(1, 2)

	$Timer.wait_time = randf_range(0.5, 1)
	$Timer.start()
