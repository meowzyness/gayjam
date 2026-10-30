extends Node2D


@onready var person_scene: PackedScene = preload("res://Scenes/person.tscn")


func _ready():
	$Timer.start()

func _on_timer_timeout():
	var new_person: Node2D = person_scene.instantiate()

	add_child(new_person)
	
	var offset: Vector2 = Vector2(randf_range(-20, 20), randf_range(-10, 20))
	new_person.global_position = global_position + offset

	$Timer.wait_time = randf_range(0.5, 1)
	$Timer.start()
