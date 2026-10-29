class_name Personality

var traitor: bool
var name: String
var surname: String
var age: int
var sex: String
var skin: String
var citizenship: String

var sexes = ["М", "Ж"]
var first_names_m = ["Иван", "Петр", "Алексей"]
var last_names_m = ["Иванов", "Петров", "Попов"]
var first_names_f = ["Мария", "Славя", "Ксюша"]
var last_names_f = ["Летова", "Путина", "Ленина"]
var skin_types = ["Белая", "Смуглая", "Темная", "Чёрная", "Жёлтая"]
var citizenship_types = ["Россия", "Казахстан", "Китай", "Иран", "Индия"]

func _init():
	sex = sexes.pick_random()
	if sex == "М":
		name = first_names_m.pick_random()
		surname = last_names_m.pick_random()
	else:
		name = first_names_f.pick_random()
		surname = last_names_f.pick_random()
		
	age = randi_range(14, 70)
	skin = skin_types.pick_random()
	citizenship = citizenship_types.pick_random()

func get_info():
	return "%s %s, Возраст: %d, Пол: %s, Цвет кожи: %s, Гражданство: %s" % [name, surname, age, sex, skin, citizenship]
