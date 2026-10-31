extends Control
class_name UI

var target: Area2D
var personality: Personality
var balance: int = 0

@export var scanner: Scanner
@export var dossier: Dossier

@export var button_inspect: Button
@export var button_arrest: Button
@export var status_label: Label
@export var balance_label: Label

func _ready() -> void:
	balance = 0
	scanner = get_tree().root.find_child("Scanner", true, false)

	button_arrest.pressed.connect(_on_arrest_pressed)
	button_inspect.pressed.connect(_on_inspect_pressed)


func update(t: Person):
	if t == null:
		return

	if scanner and target != t:
		scanner.update(t)
		
	if dossier and target != t:
		dossier.update(t)

	target = t
	personality = t.personality

func skipped(t: Person):
	var guilty: bool = t.personality.is_guilty()

	var reward: int = t.personality.get_arrest_reward()
	if guilty:
		print("лох")
		balance -= reward
		balance_label.text = "Баланс: %d$" % balance
		if balance > 0:
			balance_label.modulate = Color(0.3, 0.9, 0.3)
		elif balance < 0:
			balance_label.modulate = Color(0.9, 0.3, 0.3)
		else:
			balance_label.modulate = Color.WHITE
	else:
		print("норм")

func _on_arrest_pressed() -> void:
	if target == null:
		print("никто не выбран для задержания")
		return

	var reward: int = target.personality.get_arrest_reward()
	balance += reward
	balance_label.text = "Баланс: %d$" % balance
	if balance > 0:
		balance_label.modulate = Color(0.3, 0.9, 0.3)
	elif balance < 0:
		balance_label.modulate = Color(0.9, 0.3, 0.3)
	else:
		balance_label.modulate = Color.WHITE
	
	var guilty: bool = target.personality.is_guilty()

	if guilty:
		print("пойман преступник! +%d$ (баланс: %d$)" % [reward, balance])
		status_label.text = "Преступник задержан! (+%d$)" % reward
		status_label.modulate = Color(0.3, 0.9, 0.3)
	else:
		print("задержан невиновный! %d$ (баланс: %d$)" % [reward, balance])
		status_label.text = "Ошибка! Задержан невиновный (%d$)" % reward
		status_label.modulate = Color(0.9, 0.3, 0.3)

	if is_instance_valid(target):
		target.is_walker = false

	target.personality = null
	target = null

func _on_inspect_pressed() -> void:
	if target.personality == null:
		print("никто не выбран для досмотра")
		return
	print("отправлен на досмотр: ", target.personality.name)
