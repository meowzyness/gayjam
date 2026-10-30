class_name Personality

<<<<<<< HEAD
@export var traitor: bool
@export var name: String
@export var surname: String
@export var age: int
@export var sex: String
@export var skin: String
@export var citizenship: String
@export var texture: Texture2D
=======
var traitor: bool
var name: String
var surname: String
var age: int
var sex: String
var citizenship: String
var texture: Texture2D
>>>>>>> 659a5fedc41c1a55ba5a2b7ba5c9d81a6619a462

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

	generate_name_and_age()
	generate_texture()

	if randi_range(1, 20) == 1:
		traitor = true
	else:
		traitor = false


func generate_name_and_age() -> void:
	if citizenship in ["Трикарасье", "Новкарасье", "Чегория", "Стромыния"]:
		if sex == "М":
			name = first_names_rus_m.pick_random()
			surname = last_names_rus_m.pick_random()
		else:
			name = first_names_rus_f.pick_random()
			surname = last_names_rus_f.pick_random()
		age = randi_range(14, 70)

	elif citizenship in ["Сокологора", "Теркастан"]:
		if sex == "М":
			name = first_names_central_asian_m.pick_random()
			surname = last_names_central_asian_m.pick_random()
			age = randi_range(18, 60)
		else:
			name = first_names_central_asian_f.pick_random()
			surname = last_names_central_asian_f.pick_random()
			age = randi_range(30, 60)

	elif citizenship in ["Кашингтон", "Вернандт"]:
		if sex == "М":
			name = first_names_western_m.pick_random()
			surname = last_names_western_m.pick_random()
		else:
			name = first_names_western_f.pick_random()
			surname = last_names_western_f.pick_random()
		age = randi_range(21, 80)


func generate_texture() -> void:
	var files = DirAccess.get_files_at("res://Sprites/people/")
	var textures = []
	for file in files:

		if file.ends_with(".webp"):
			if (file.contains("m") and sex == "М") or (file.contains("f") and sex == "Ж"):
				textures.append(file)

	if textures.size() > 0:
		texture = load("res://Sprites/people/" + textures.pick_random())

func change_sex() -> void:
	if sex == "М":
		sex = "Ж"
	else:
		sex = "М"


func change_citizenship(new_citizenship: String = "") -> void:
	if new_citizenship == "":
		citizenship = citizenship_types.pick_random()
	else:
		citizenship = new_citizenship


func change_age(new_age: int) -> void:
	age = clampi(new_age, 0, 120)

func get_info():
	return "%s %s, Возраст: %d, Пол: %s, Гражданство: %s" % [name, surname, age, sex, citizenship]
