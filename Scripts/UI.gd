extends Control
class_name UI

var target: Person
var personality: Personality
var balance: int = 0

@export var scanner: Scanner
@export var dossier: Dossier

@export var button_inspect: Button
@export var button_arrest: Button
@export var status_label: Label
@export var balance_label: Label

@export var banned_people: Control
@export var banned_person: PackedScene
@export var banned_citizenships: Label

func _ready() -> void:
	balance = 0
	scanner = get_tree().root.find_child("Scanner", true, false)
	generate_random_events()
	
	button_arrest.pressed.connect(_on_arrest_pressed)
	button_inspect.pressed.connect(_on_inspect_pressed)
	update(null)

func _unhandled_input(event):
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		target = null
		personality = null
		update(null)
	elif event is InputEventKey and event.keycode == KEY_SPACE:
		_on_arrest_pressed()

func update(t: Person):
	if scanner:
		scanner.update(t)
		
	if dossier:
		dossier.update(t)

	if t:
		target = t
		personality = t.personality
	
	while Globals.ban['banned_people'].size() > banned_people.get_children().size():
		banned_people.add_child(banned_person.instantiate())
	while Globals.ban['banned_people'].size() < banned_people.get_children().size():
		banned_people.get_child(0).free()

	for i in range(banned_people.get_children().size()):
		if len(Globals.ban['banned_people']) > 0:
			banned_people.get_children()[i].get_child(0).texture = Globals.ban['banned_people'][i].texture
			banned_people.get_children()[i].get_child(1).text = Globals.ban['banned_people'][i].name + " " + Globals.ban['banned_people'][i].surname
	var banned_counries = []
	for country in Globals.ban['banned_citizenships']:
		if country in Globals.citizenship_types:
			banned_counries.append(country)
	banned_citizenships.text = "Запрещенные страны: " + str(banned_counries)

func skipped(t: Person):
	var guilty: bool = t.personality.is_guilty()

	var reward: int = t.personality.get_arrest_reward()
	if guilty:
		balance -= reward
		update_balance()
		status_label.text = "Преступник упущен (-%d$)" % reward
		status_label.modulate = Color(0.9, 0.3, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		AudioManager.play_ui_sound("incorrect")
		for p in Globals.ban['banned_people']:
			if t.personality.name == p.name and t.personality.surname == p.surname and t.personality.texture == p.texture:
				Globals.ban['banned_people'].erase(p)

func _on_arrest_pressed() -> void:
	if target == null:
		print("никто не выбран для задержания")
		return

	var reward: int = target.personality.get_arrest_reward()
	balance += reward
	update_balance()
	
	var guilty: bool = target.personality.is_guilty()

	if guilty:
		status_label.text = "Преступник задержан (+%d$)" % reward
		status_label.modulate = Color(0.3, 0.9, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		AudioManager.play_ui_sound("correct")
	else:
		status_label.text = "Задержан невиновный (%d$)" % reward
		status_label.modulate = Color(0.9, 0.3, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		AudioManager.play_ui_sound("incorrect")
		

	for p in Globals.ban['banned_people']:
		if target.personality.name == p.name and target.personality.surname == p.surname and target.personality.texture == p.texture:
			Globals.ban['banned_people'].erase(p)

	if target:
		target.is_walker = false

	target.personality = null
	target = null
	update(null)

func _on_inspect_pressed() -> void:
	if target == null:
		print("никто не выбран для досмотра")
		return
	print("отправлен на досмотр: ", target.personality.name)


func update_balance() -> void:
	balance_label.text = "Баланс: %d$" % balance
	if balance > 0:
		balance_label.modulate = Color(0.3, 0.9, 0.3)
	elif balance < 0:
		balance_label.modulate = Color(0.9, 0.3, 0.3)
	else:
		balance_label.modulate = Color.WHITE


func _on_timer_timeout() -> void:
	status_label.visible = false


func generate_random_events():
	await get_tree().create_timer(10.0).timeout
	var r = randi_range(1, 11)
	if r == 1:
		Globals.add_ban(randi_range(1, 14), 'banned_ages')
		print(Globals.ban['banned_ages'])
	if r == 2:
		Globals.add_ban(randi_range(100, 1000), 'banned_ages')
		print(Globals.ban['banned_ages'])
	if r == 3 and 'ЗЕБЕСТКАНТРИ' not in Globals.ban['banned_citizenships']:
		Globals.add_ban('ЗЕБЕСТКАНТРИ', 'banned_citizenships')
		print(Globals.ban['banned_citizenships'])
	if r == 4 and 'гойдана' not in Globals.ban['banned_citizenships']:
		Globals.add_ban('гойдана', 'banned_citizenships')
		print(Globals.ban['banned_citizenships'])
	if r == 5 and 'орбистан' not in Globals.ban['banned_citizenships']:
		Globals.add_ban('орбистан', 'banned_citizenships')
		print(Globals.ban['banned_citizenships'])
	if r == 6:
		var c = Globals.citizenship_types.pick_random()
		Globals.add_ban(c, 'banned_citizenships')
		var text = 'теперь запрещен въезд гражданам из страны ' + c
		status_label.text = text
		status_label.modulate = Color(0.9, 0.3, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		print(text)
		print(Globals.ban['banned_citizenships'])
	if r == 7 and len(Globals.ban['banned_citizenships']) > 0:
		var c = Globals.ban['banned_citizenships'].pick_random()
		Globals.del_ban(c, 'banned_citizenships')
		var text = 'теперь разрешён въезд гражданам из страны ' + c
		status_label.text = text
		status_label.modulate = Color(0.3, 0.9, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		print(text)
		print(Globals.ban['banned_citizenships'])
	if r == 8 and len(Globals.ban['banned_people']) == 0:
		var p = Personality.new()
		Globals.add_ban(p, 'banned_people')
		var text = 'необходимо задержать преступника ' + p.name + ' ' + p.surname
		status_label.text = text
		status_label.modulate = Color(0.9, 0.3, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		print(text)
		print(Globals.ban['banned_people'])
	if r == 9 and len(Globals.ban['banned_people']) != 0:
		var p = Globals.ban['banned_people'].pick_random()
		Globals.del_ban(p, 'banned_people')
		var text = 'задержен преступник: ' + p.name + ' ' + p.surname
		status_label.text = text
		status_label.modulate = Color(0.3, 0.9, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		print(text)
		print(Globals.ban['banned_people'])
	if r == 10 and len(Globals.ban['banned_baggage']) == 0:
		Globals.add_ban(load('res://Sprites/baggage/scan_item1.png'), 'banned_baggage')
		status_label.text = 'теперь запрещено перевозить тыкву в багаже'
		status_label.modulate = Color(0.9, 0.3, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		print(Globals.ban['banned_baggage'])
	if r == 11 and len(Globals.ban['banned_baggage']) != 0:
		Globals.del_ban(load('res://Sprites/baggage/scan_item1.png'), 'banned_baggage')
		status_label.text = 'теперь разрешено перевозить тыкву в багаже'
		status_label.modulate = Color(0.3, 0.9, 0.3)
		status_label.visible = true
		status_label.get_child(0).start()
		print(Globals.ban['banned_baggage'])
	generate_random_events()
