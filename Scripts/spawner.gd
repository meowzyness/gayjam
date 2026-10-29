extends Node2D


var person_scene := preload("res://Scenes/person.tscn")

var sex = ["М", "Ж"]
var first_names_m = ["Иван", "Петр", "Алексей"]
var last_names_m = ["Иванов", "Петров", "Попов"]
var first_names_f = ["Мария", "Славя", "Ксюша"]
var last_names_f = ["Летова", "Путина", "Ленина"]
var skin_types = ["Белая", "Смуглая", "Темная", "Чёрная", "Жёлтая"]
var citizenship_types = ["Россия", "Казахстан", "Китай", "Иран", "Индия"]

func _ready():
	$Timer.start()

func _on_timer_timeout():
	var new_person := person_scene.instantiate() as PersonCharacter
	
	var random_sex = sex.pick_random()
	var random_name: String
	var random_last_name: String
	if random_sex == "М":
		random_name = first_names_m.pick_random()
		random_last_name = last_names_m.pick_random()
	else:
		random_name = first_names_f.pick_random()
		random_last_name = last_names_f.pick_random()
		
	var random_age = randi_range(14, 70)
	var random_skin = skin_types.pick_random()
	var random_citizenship = citizenship_types.pick_random()
	
	var person_data = Person.new(random_name, random_last_name, random_age, random_sex, random_skin, random_citizenship)
	
	new_person.person_data = person_data
	
	add_child(new_person)
	
	var offset := Vector2(randf_range(-20, 20), 0)
	new_person.global_position = global_position + offset
	new_person.global_scale.y = randf_range(1, 2)

	$Timer.wait_time = randf_range(0.5, 1)
	$Timer.start()
