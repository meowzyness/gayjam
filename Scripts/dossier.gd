extends CanvasLayer

@onready var name_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/NameLabel
@onready var age_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/AgeLabel
@onready var sex_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/SexLabel
@onready var citizenship_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/CitizenshipLabel
@onready var status_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatusLabel


func _ready():
	get_tree().node_added.connect(_on_node_added)
	for node in get_tree().root.find_children("*", "CharacterBody2D", true, false):
		_setup_person(node)


func _on_node_added(node: Node):
	if node is CharacterBody2D:
		_setup_person(node)


func _setup_person(node: Node):
	if "personality" in node:
		node.input_event.connect(_on_person_input.bind(node))


func _on_person_input(_viewport: Node, event: InputEvent, _shape_idx: int, person: CharacterBody2D):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		update_info(person.personality)


func update_info(p: Personality):
	if p == null:
		return
	name_label.text = "Имя: %s %s" % [p.name, p.surname]
	age_label.text = "Возраст: %d" % p.age
	sex_label.text = "Пол: %s" % p.sex
	citizenship_label.text = "Гражданство: %s" % p.citizenship
	status_label.text = "Данные получены"
