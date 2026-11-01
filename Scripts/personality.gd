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

const PEOPLE_M = [
	"res://Sprites/people/civ_m_001.webp",
	"res://Sprites/people/civ_m_002.webp",
	"res://Sprites/people/civ_m_003.webp",
	"res://Sprites/people/civ_m_004.webp",
	"res://Sprites/people/civ_m_006.webp",
	"res://Sprites/people/civ_m_007.webp",
	"res://Sprites/people/civ_m_008.webp",
	"res://Sprites/people/civ_m_009.webp",
	"res://Sprites/people/civ_m_010.webp",
	"res://Sprites/people/civ_m_012.webp",
	"res://Sprites/people/civ_m_0013.webp"
]

const PEOPLE_F = [
	"res://Sprites/people/civ_f_001t.webp",
	"res://Sprites/people/civ_f_002t.webp",
	"res://Sprites/people/civ_f_003.webp",
	"res://Sprites/people/civ_f_004.webp",
	"res://Sprites/people/civ_f_005.webp",
	"res://Sprites/people/civ_f_006.webp",
	"res://Sprites/people/civ_f_007.webp",
	"res://Sprites/people/civ_f_008.webp"
]

const BAGGAGE_ITEMS = [
	"res://Sprites/baggage/item_E1.png",
	"res://Sprites/baggage/item_E3.png",
	"res://Sprites/baggage/scan_item1.png",
	"res://Sprites/baggage/scan_item3.png",
	"res://Sprites/baggage/scan_item4.png",
	"res://Sprites/baggage/scan_item5.png",
	"res://Sprites/baggage/scan_item6.png"
]

const BAGGAGE_DANGER = [
	"res://Sprites/baggage/scan_danger.png",
	"res://Sprites/baggage/scan_danger1.png"
]

func is_guilty() -> bool:
	return traitor

func get_arrest_reward() -> int:
	return arrest_reward if is_guilty() else -arrest_reward

func _init():
	sex = Globals.sexes.pick_random()
	citizenship = Globals.citizenship_types.pick_random()
	var cit_attempts = 0
	while citizenship in Globals.ban['banned_citizenships'] and cit_attempts < 50:
		citizenship = Globals.citizenship_types.pick_random()
		cit_attempts += 1

	randomize_name()
	generate_age()
	texture = generate_texture()
	totaly_real_texture = texture

	var amount_of_baggage = randi_range(3, 5)
	var bag_attempts = 0
	while amount_of_baggage >= 0 and bag_attempts < 30:
		bag_attempts += 1
		var b = generate_baggage_texture()
		if b and b not in Globals.ban['banned_baggage']:
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
	var list = PEOPLE_M if sex == "М" else PEOPLE_F
	return load(list.pick_random())


func generate_baggage_texture():
	return load(BAGGAGE_ITEMS.pick_random())


func generate_baggage_danger_texture():
	return load(BAGGAGE_DANGER.pick_random())


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
		r = randi_range(3, 3)
	if r == 1:
		totaly_real_texture = generate_texture()
		var attempts = 0
		while texture == totaly_real_texture and attempts < 20:
			totaly_real_texture = generate_texture()
			attempts += 1
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
					print('Преступник появился с возрастом ', age)
				if ban_lists[i_ban_list] == 'banned_citizenships':
					citizenship = Globals.ban[ban_lists[i_ban_list]].pick_random()
					print('Преступник появился с гражданством ', citizenship)
				if ban_lists[i_ban_list] == 'banned_people':
					var p = Globals.ban['banned_people'].pick_random()
					name = p.name
					surname = p.surname
					texture = p.texture
					totaly_real_texture = texture
					print('Преступник появился с именем ', name)
				if ban_lists[i_ban_list] == 'banned_baggage':
					baggage.append(Globals.ban[ban_lists[i_ban_list]].pick_random())
					baggage_x.append(randf_range(0, 1))
					baggage_y.append(randf_range(0, 1))
					print('Преступник появился с багажом ', baggage[-1])
	else:
		traitor = false

			
		
