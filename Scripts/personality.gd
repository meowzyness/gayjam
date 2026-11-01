class_name Personality

@export var sussyness: float
@export var traitor: bool
@export var name: String
@export var surname: String
@export var age: int
@export var sex: String
@export var citizenship: String
@export var texture: Texture2D
@export var totaly_real_texture: Texture2D
@export var arrest_reward: int = 300

@export var baggage = []
@export var baggage_x = []
@export var baggage_y = []
@export var having_danger = false


func is_guilty() -> bool:
	return traitor

func get_arrest_reward() -> int:
	return arrest_reward if is_guilty() else -arrest_reward

func _init():
	sex = Globals.sexes.pick_random()
	citizenship = Globals.citizenship_types.pick_random()
	while citizenship in Globals.ban['banned_citizenships']:
		citizenship = Globals.citizenship_types.pick_random()

	randomize_name()
	generate_age()
	texture = generate_texture()
	totaly_real_texture = texture

	var amount_of_baggage = randi_range(4, 10)
	while amount_of_baggage >= 0:
		var b = generate_baggage_texture()
		if b not in Globals.ban['banned_baggage']:
			baggage_x.append(randf_range(0, 1))
			baggage_y.append(randf_range(0, 1))
			baggage.append(b)
			amount_of_baggage -= 1

	sussyness = pow(randf(), 2)
	if 1 - pow(randf(), 2) <= sussyness:
		getting_traitor()
	
	for p in Globals.ban['banned_people']:
		if name == p.name and surname == p.surname and texture == p.texture:
			if not traitor:
				randomize_name()


func generate_texture():
	var files = DirAccess.get_files_at("res://Sprites/people/")
	var textures = []
	for file in files:
		if file.ends_with(".webp"):
			if (file.contains("m") and sex == "М") or (file.contains("f") and sex == "Ж"):
				textures.append(file)

	if textures.size() > 0:
		return load("res://Sprites/people/" + textures.pick_random())


func generate_baggage_texture():
	var files = DirAccess.get_files_at("res://Sprites/baggage/")
	var textures = []
	for file in files:
		if file.ends_with(".png") and file.contains("item"):
			textures.append(file)

	if textures.size() > 0:
		return load("res://Sprites/baggage/" + textures.pick_random())


func generate_baggage_danger_texture():
	var files = DirAccess.get_files_at("res://Sprites/baggage/")
	var textures = []
	for file in files:
		if file.ends_with(".png") and file.contains("danger"):
			textures.append(file)

	if textures.size() > 0:
		return load("res://Sprites/baggage/" + textures.pick_random())


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
			name = Globals.first_names_rus_m.pick_random()
			surname = Globals.last_names_rus_m.pick_random()
		else:
			name = Globals.first_names_rus_f.pick_random()
			surname = Globals.last_names_rus_f.pick_random()

	elif citizenship in ["Сокологора", "Теркастан"]:
		if sex == "М":
			name = Globals.first_names_central_asian_m.pick_random()
			surname = Globals.last_names_central_asian_m.pick_random()
		else:
			name = Globals.first_names_central_asian_f.pick_random()
			surname = Globals.last_names_central_asian_f.pick_random()

	elif citizenship in ["Кашингтон", "Вернандт"]:
		if sex == "М":
			name = Globals.first_names_western_m.pick_random()
			surname = Globals.last_names_western_m.pick_random()
		else:
			name = Globals.first_names_western_f.pick_random()
			surname = Globals.last_names_western_f.pick_random()


func getting_traitor():
	traitor = true
	var r: int
	if Globals.amount_of_banning_lists == 0:
		r = randi_range(1, 2)
	else:
		r = randi_range(1, 3)
	if r == 1:
		totaly_real_texture = generate_texture()
		while texture == totaly_real_texture:
			totaly_real_texture = generate_texture()
	elif r == 2:
		having_danger = true
		baggage_x.append(randf_range(0, 1))
		baggage_y.append(randf_range(0, 1))
		baggage.append(generate_baggage_danger_texture())
	elif r == 3:
		r = randi_range(1, Globals.amount_of_banning_lists)
		var ban_lists = Globals.get_ban_lists()
		for i_ban_list in range(len(ban_lists)):
			if i_ban_list == (r - 1):
				if ban_lists[i_ban_list] == 'banned_ages':
					age = Globals.ban[ban_lists[i_ban_list]].pick_random()
				if ban_lists[i_ban_list] == 'banned_citizenship':
					citizenship = Globals.ban[ban_lists[i_ban_list]].pick_random()
				if ban_lists[i_ban_list] == 'banned_people':
					var p = Globals.ban['banned_people'].pick_random()
					name = p.name
					surname = p.surname
					texture = p.texture
					totaly_real_texture = texture
				if ban_lists[i_ban_list] == 'banned_baggage':
					baggage.append(Globals.ban[ban_lists[i_ban_list]].pick_random())
					baggage_x.append(randf_range(0, 1))
					baggage_y.append(randf_range(0, 1))
	else:
		traitor = false

			
		
