extends CanvasLayer

@onready var name_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/NameLabel
@onready var age_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/AgeLabel
@onready var sex_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/SexLabel
@onready var citizenship_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/CitizenshipLabel
@onready var status_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatusLabel


func update_info(p: Personality):
	if p == null:
		return
	name_label.text = "Имя: %s %s" % [p.name, p.surname]
	age_label.text = "Возраст: %d" % p.age
	sex_label.text = "Пол: %s" % p.sex
	citizenship_label.text = "Гражданство: %s" % p.citizenship
	status_label.text = "Данные получены %s" % p.traitor
