extends CanvasLayer

signal balance_changed(new_balance: int, change: int)
signal person_arrested(personality: Personality, was_guilty: bool, reward: int)

@onready var button_inspect: Button = $Control/MarginContainer/HBoxContainer/ActionsPanel/ActionsMargin/ActionsVBox/MarginContainer/ButtonsVBox/ButtonInspect
@onready var button_arrest: Button = $Control/MarginContainer/HBoxContainer/ActionsPanel/ActionsMargin/ActionsVBox/MarginContainer/ButtonsVBox/ButtonArrest

var current_person: Node = null
var current_personality: Personality = null
var player_balance: int = 0

func _ready() -> void:
	button_arrest.pressed.connect(_on_arrest_pressed)
	button_inspect.pressed.connect(_on_inspect_pressed)

func set_target(person: Node, p: Personality) -> void:
	current_person = person
	current_personality = p

func _on_arrest_pressed() -> void:
	if current_personality == null:
		print("никто не выбран для задержания")
		return

	var reward: int = current_personality.get_arrest_reward()
	player_balance += reward
	var guilty: bool = current_personality.is_guilty()

	balance_changed.emit(player_balance, reward)
	person_arrested.emit(current_personality, guilty, reward)

	if guilty:
		print("пойман преступник! +%d$ (баланс: %d$)" % [reward, player_balance])
	else:
		print("задержан невиновный! %d$ (баланс: %d$)" % [reward, player_balance])

	if is_instance_valid(current_person):
		current_person.queue_free()

	current_person = null
	current_personality = null

func _on_inspect_pressed() -> void:
	if current_personality == null:
		print("никто не выбран для досмотра")
		return
	print("отправлен на досмотр: ", current_personality.name)
