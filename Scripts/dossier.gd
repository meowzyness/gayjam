extends Control
class_name Dossier

@export var name_label: Label
@export var age_label: Label
@export var sex_label: Label
@export var citizenship_label: Label
@export var profile_pic: TextureRect


func update(t: Person):
	if !t:
		profile_pic.texture = null
		name_label.text = "Имя: -"
		age_label.text = "Возраст: -"
		sex_label.text = "Пол: -"
		citizenship_label.text = "Гражданство: -"
		return

	var p: Personality = t.personality

	profile_pic.texture = t.personality.texture
	name_label.text = "Имя: %s %s" % [t.personality.name, t.personality.surname]
	age_label.text = "Возраст: %d" % t.personality.age
	sex_label.text = "Пол: %s" % t.personality.sex
	citizenship_label.text = "Гражданство: %s" % t.personality.citizenship
