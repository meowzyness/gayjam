extends Node2D

@export var person_scene: PackedScene = preload("res://person.tscn")

var sex = ["М", "Ж"]
var first_names_m = ["Иван", "Петр", "Алексей"]
var last_names_m = ["Иванов", "Петров", "Попов"]
var first_names_f = ["Мария", "Славя", "Ксюша"]
var last_names_f = ["Летова", "Путина", "Ленина"]
var skin_types = ["Белая", "Смуглая", "Темная", "Чёрная", "Жёлтая"]
var citizenship_types = ["Россия", "Казахстан", "Китай", "Иран", "Индия"]

func _ready():
	for i in range(5):
		spawn_random_person()

func spawn_random_person():
	var new_person_instance = person_scene.instantiate()
	
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
	
	new_person_instance.person_data = person_data
	
	var viewport_size = get_viewport_rect().size
	new_person_instance.position = Vector2(
		randf_range(50, viewport_size.x - 50),
		randf_range(50, viewport_size.y - 50)
	)
	
	# 6. Добавляем экземпляр на сцену
	add_child(new_person_instance)
