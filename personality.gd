class_name Person

var traitor: bool
var first_name: String
var surname: String
var age: int
var sex: String
var skin_color: String
var citizenship: String

func _init(p_first_name: String = "Unknown", p_surname: String = "Unknown", p_age: int = 0, p_sex: String = "Unknown", p_skin_color: String = "Unknown", p_citizenship: String = "Unknown"):
	first_name = p_first_name
	surname = p_surname
	age = p_age
	sex = p_sex
	skin_color = p_skin_color
	citizenship = p_citizenship

func get_info():
	return "%s %s, Возраст: %d, Пол: %s, Цвет кожи: %s, Гражданство: %s" % [first_name, surname, age, sex, skin_color, citizenship]
