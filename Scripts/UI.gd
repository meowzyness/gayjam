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
	
	while Globals.banned_people.size() > banned_people.get_children().size():
		banned_people.add_child(banned_person.instantiate())
	while Globals.banned_people.size() < banned_people.get_children().size():
		banned_people.get_child(0).free()

	for i in range(banned_people.get_children().size()):
		banned_people.get_children()[i].get_child(0).texture = Globals.banned_people[i].texture
		banned_people.get_children()[i].get_child(1).text = Globals.banned_people[i].name + " " + Globals.banned_people[i].surname
	banned_citizenships.text = "Запрещенные страны: " + str(Globals.banned_citizenships)

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
		for p in Globals.banned_people:
			if t.personality.name == p.name and t.personality.surname == p.surname and t.personality.texture == p.texture:
				Globals.banned_people.erase(p)

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
		

	for p in Globals.banned_people:
		if target.personality.name == p.name and target.personality.surname == p.surname and target.personality.texture == p.texture:
			Globals.banned_people.erase(p)

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
