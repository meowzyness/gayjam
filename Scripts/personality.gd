class_name Personality

@export var sussyness: float
@export var traitor: bool
@export var name: String
@export var surname: String
@export var age: int
@export var sex: String
@export var skin: String
@export var citizenship: String
@export var texture: Texture2D
@export var totaly_real_texture: Texture2D
@export var having_bomb = false
@export var arrest_reward: int = 300

func is_guilty() -> bool:
	return traitor

func get_arrest_reward() -> int:
	return arrest_reward if is_guilty() else -arrest_reward

var sexes = ["М", "Ж"]
var first_names_rus_m = [
  "Иван", "Петр", "Алексей", "Игорь", "Марк", "Тарас",
  "Сергей", "Дмитрий", "Андрей", "Михаил", "Николай", "Владимир",
  "Александр", "Павел", "Роман", "Егор", "Артём", "Максим",
  "Кирилл", "Олег", "Виктор", "Григорий", "Фёдор", "Борис",
  "Даниил", "Тимофей", "Степан", "Лев", "Клим"
]

var last_names_rus_m = [
  "Иванов", "Петров", "Попов", "Бульба",
  "Смирнов", "Кузнецов", "Соколов", "Лебедев", "Козлов", "Новиков",
  "Морозов", "Волков", "Соловьёв", "Васильев", "Зайцев", "Павлов",
  "Семёнов", "Голубев", "Виноградов", "Богданов", "Воробьёв",
  "Фёдоров", "Михайлов", "Беляев", "Тарасов", "Белов"
]

var first_names_rus_f = [
  "Мария", "Славя", "Ксюша",
  "Анна", "Елена", "Ольга", "Наталья", "Ирина", "Татьяна",
  "Светлана", "Екатерина", "Юлия", "Дарья", "Алина", "Полина",
  "Вера", "Надежда", "Любовь", "Софья", "Валентина", "Галина",
  "Лидия", "Нина", "Оксана", "Виктория", "Елизавета"
]

var last_names_rus_f = [
  "Летова", "Ленина",
  "Смирнова", "Кузнецова", "Соколова", "Лебедева", "Козлова", "Новикова",
  "Морозова", "Волкова", "Соловьёва", "Васильева", "Зайцева", "Павлова",
  "Семёнова", "Голубева", "Виноградова", "Богданова", "Воробьёва",
  "Фёдорова", "Михайлова", "Беляева", "Тарасова", "Белова"
]

var first_names_central_asian_m = [
  "Алишер", "Тимур", "Рустам", "Бахтиёр", "Шохрух",
  "Джахонгир", "Улугбек", "Азамат", "Ерлан", "Нурлан",
  "Айбек", "Бакыт", "Данияр", "Арман", "Санжар",
  "Фарход", "Камол", "Далер", "Фирдавс", "Мердан",
  "Сердар", "Абдулла", "Ислам", "Мурат", "Тахир"
]

var last_names_central_asian_m = [
  "Каримов", "Рахимов", "Исмаилов", "Ахметов", "Сейткалиев",
  "Жумабаев", "Абдуллаев", "Юсупов", "Назаров", "Сафаров",
  "Мирзоев", "Шарипов", "Умаров", "Хасанов", "Бекмуратов",
  "Алиев", "Гафуров", "Давлатов", "Собиров", "Турсунов",
  "Кулиев", "Оразов", "Атаев", "Бердиев", "Сапаров"
]

var first_names_central_asian_f = [
  "Айгуль", "Гульнара", "Динара", "Зарина", "Мадина",
  "Нилуфар", "Шахноза", "Малика", "Дилноза", "Лола",
  "Гульмира", "Асель", "Аида", "Айжан", "Сауле",
  "Жанар", "Ботагоз", "Мээрим", "Айпери", "Наргиза",
  "Фарида", "Мехри", "Гозель", "Лейла", "Амина"
]

var last_names_central_asian_f = [
  "Каримова", "Рахимова", "Исмаилова", "Ахметова", "Сейткалиева",
  "Жумабаева", "Абдуллаева", "Юсупова", "Назарова", "Сафарова",
  "Мирзоева", "Шарипова", "Умарова", "Хасанова", "Бекмуратова",
  "Алиева", "Гафурова", "Давлатова", "Собирова", "Турсунова",
  "Кулиева", "Оразова", "Атаева", "Бердиева", "Сапарова"
]

var first_names_western_m = [
  "Джеймс", "Джон", "Майкл", "Роберт", "Дэвид",
  "Уильям", "Ричард", "Джозеф", "Томас", "Чарльз",
  "Дэниел", "Мэттью", "Энтони", "Марк", "Дональд",
  "Стивен", "Пол", "Эндрю", "Джошуа", "Кевин",
  "Брайан", "Джордж", "Эдвард", "Райан", "Джек"
]

var last_names_western_m = [
  "Смит", "Джонсон", "Уильямс", "Браун", "Джонс",
  "Гарсия", "Миллер", "Дэвис", "Родригес", "Мартинес",
  "Эрнандес", "Лопес", "Гонсалес", "Уилсон", "Андерсон",
  "Томас", "Тейлор", "Мур", "Джексон", "Мартин",
  "Ли", "Перес", "Томпсон", "Уайт", "Харрис"
]

var first_names_western_f = [
  "Мэри", "Патриша", "Дженнифер", "Линда", "Элизабет",
  "Барбара", "Сьюзен", "Джессика", "Сара", "Карен",
  "Нэнси", "Лиза", "Бетти", "Маргарет", "Сандра",
  "Эшли", "Кимберли", "Эмили", "Донна", "Мишель",
  "Кэрол", "Аманда", "Дороти", "Мелисса", "Дебора"
]

var last_names_western_f = [
  "Смит", "Джонсон", "Уильямс", "Браун", "Джонс",
  "Гарсия", "Миллер", "Дэвис", "Родригес", "Мартинес",
  "Эрнандес", "Лопес", "Гонсалес", "Уилсон", "Андерсон",
  "Томас", "Тейлор", "Мур", "Джексон", "Мартин",
  "Ли", "Перес", "Томпсон", "Уайт", "Харрис"
]

var citizenship_types = ["Трикарасье", "Новкарасье", "Чегория", "Стромыния", "Сокологора", "Теркастан", "Кашингтон", "Вернандт"]

func _init():
	sex = sexes.pick_random()
	citizenship = citizenship_types.pick_random()

	randomize_name()
	generate_age()
	texture = generate_texture()
	totaly_real_texture = texture

	sussyness = pow(randf(), 3)
	if randf() <= sussyness:
		traitor = true
		var r = randi_range(1, 2)
		if r == 1:
			totaly_real_texture = generate_texture()
			while texture == totaly_real_texture:
				totaly_real_texture = generate_texture()
		if r == 2:
			having_bomb = true
	else:
		traitor = false


func generate_texture():
	var files = DirAccess.get_files_at("res://Sprites/people/")
	var textures = []
	for file in files:
		if file.ends_with(".webp"):
			if (file.contains("m") and sex == "М") or (file.contains("f") and sex == "Ж"):
				textures.append(file)

	if textures.size() > 0:
		return load("res://Sprites/people/" + textures.pick_random())


func generate_age():
	if citizenship in ["Трикарасье", "Новкарасье", "Чегория", "Стромыния"]:
		age = randi_range(14, 70)
	elif citizenship in ["Сокологора", "Теркастан"]:
		if sex == "М":
			age = randi_range(18, 60)
		else:
			age = randi_range(30, 60)
	elif citizenship in ["Кашингтон", "Вернандт"]:
		age = randi_range(21, 80)


func randomize_name() -> void:
	if citizenship in ["Трикарасье", "Новкарасье", "Чегория", "Стромыния"]:
		if sex == "М":
			name = first_names_rus_m.pick_random()
			surname = last_names_rus_m.pick_random()
		else:
			name = first_names_rus_f.pick_random()
			surname = last_names_rus_f.pick_random()

	elif citizenship in ["Сокологора", "Теркастан"]:
		if sex == "М":
			name = first_names_central_asian_m.pick_random()
			surname = last_names_central_asian_m.pick_random()
		else:
			name = first_names_central_asian_f.pick_random()
			surname = last_names_central_asian_f.pick_random()

	elif citizenship in ["Кашингтон", "Вернандт"]:
		if sex == "М":
			name = first_names_western_m.pick_random()
			surname = last_names_western_m.pick_random()
		else:
			name = first_names_western_f.pick_random()
			surname = last_names_western_f.pick_random()


func change_sex():
	if sex == "М":
		return "Ж"
	else:
		return "М"


func change_citizenship() -> String:
	var new_cit = citizenship
	while citizenship == new_cit:
		new_cit = citizenship_types.pick_random()
	return new_cit


func change_age():
	var new_age = age
	while new_age == age:
		new_age = randi_range(14, 80)
	return new_age


func change_name():
	var names = [name, surname]
	while names[0] == name or names[1] == surname:
		var r = randi_range(1, 3)
		if sex == "М":
			if r == 1:
				names = [first_names_rus_m.pick_random(), 
				last_names_rus_m.pick_random()]
			if r == 2:
				names = [first_names_central_asian_m.pick_random(),
				last_names_central_asian_m.pick_random()]
			if r == 3:
				names = [first_names_western_m.pick_random(),
				last_names_western_m.pick_random()]
		else:
			if r == 1:
				names = [first_names_rus_f.pick_random(),
				last_names_rus_f.pick_random()]
			if r == 2:
				names = [first_names_central_asian_f.pick_random(),
				last_names_central_asian_f.pick_random()]
			if r == 3:
				names = [first_names_western_f.pick_random(),
				last_names_western_f.pick_random()]
	return names


func change_texture():
	pass


func get_info():
	return "%s %s, Возраст: %d, Пол: %s, Гражданство: %s" % [name, surname, age, sex, citizenship]
