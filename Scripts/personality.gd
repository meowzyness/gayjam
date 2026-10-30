class_name Personality

var traitor: bool
var name: String
var surname: String
var age: int
var sex: String
var skin: String
var citizenship: String
var texture: Texture2D

var sexes = ["М", "Ж"]
var first_names_m = ["Иван", "Петр", "Алексей"]
var last_names_m = ["Иванов", "Петров", "Попов"]
var first_names_f = ["Мария", "Славя", "Ксюша"]
var last_names_f = ["Летова", "Путина", "Ленина"]
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
	citizenship = citizenship_types.pick_random()
	
	var files = DirAccess.get_files_at("res://Sprites/people/")

	var textures = []
	for file in files:
		if file.ends_with(".webp") and (file.contains("m") and sex == "М") or (file.contains("f") and sex == "Ж"):
			textures.append(file)
	texture = load("res://Sprites/people/" + textures.pick_random())


func get_info():
	return "%s %s, Возраст: %d, Пол: %s, Цвет кожи: %s, Гражданство: %s" % [name, surname, age, sex, skin, citizenship]
