extends CanvasLayer

@onready var name_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/NameLabel
@onready var age_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/AgeLabel
@onready var sex_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/SexLabel
@onready var citizenship_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/InfoList/CitizenshipLabel
@onready var status_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/StatusLabel
@onready var profile_pic = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/PortraitBox/TextureRect
@onready var balance_label = $Control/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/BalanceLabel

var balance: int = 0

func _ready() -> void:
	update_balance(0)
	call_deferred("_connect_scanner")

func _connect_scanner() -> void:
	var scanner = get_tree().root.find_child("Scanner", true, false)
	if scanner:
		if scanner.has_signal("balance_changed"):
			scanner.balance_changed.connect(_on_scanner_balance_changed)
		if scanner.has_signal("person_arrested"):
			scanner.person_arrested.connect(_on_scanner_person_arrested)

func _on_scanner_balance_changed(new_balance: int, _change: int) -> void:
	update_balance(new_balance)

func _on_scanner_person_arrested(_p: Personality, was_guilty: bool, reward: int) -> void:
	if was_guilty:
		status_label.text = "Преступник задержан! (+%d$)" % reward
		status_label.modulate = Color(0.3, 0.9, 0.3)
	else:
		status_label.text = "Ошибка! Задержан невиновный (%d$)" % reward
		status_label.modulate = Color(0.9, 0.3, 0.3)

func update_balance(new_balance: int) -> void:
	balance = new_balance
	if balance_label:
		balance_label.text = "Баланс: %d$" % balance
		if balance > 0:
			balance_label.modulate = Color(0.3, 0.9, 0.3)
		elif balance < 0:
			balance_label.modulate = Color(0.9, 0.3, 0.3)
		else:
			balance_label.modulate = Color.WHITE

func update_info(p: Personality):
	if p == null:
		return
	status_label.modulate = Color.WHITE
	profile_pic.texture = p.texture
	name_label.text = "Имя: %s %s" % [p.name, p.surname]
	age_label.text = "Возраст: %d" % p.age
	sex_label.text = "Пол: %s" % p.sex
	citizenship_label.text = "Гражданство: %s" % p.citizenship
	status_label.text = "Данные получены"
