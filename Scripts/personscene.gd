extends Area2D

var person_data: Person

func _ready():
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if person_data:
			print("--- Данные человека ---")
			print(person_data.get_info())
