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


@onready var rangezone := $Control/MarginContainer/HBoxContainer/ScannerPanel/ScannerMargin/ScannerVBox/HBoxContainer/RangeZone/CollisionShape2D.shape as RectangleShape2D
@onready var suitcase := $Control/MarginContainer/HBoxContainer/ScannerPanel/ScannerMargin/ScannerVBox/HBoxContainer/Suitcase
@onready var container := $Control/MarginContainer/HBoxContainer/ScannerPanel/ScannerMargin/ScannerVBox/HBoxContainer
@onready var spawn_zone := $Control/MarginContainer/HBoxContainer/ScannerPanel/ScannerMargin/ScannerVBox/HBoxContainer/SpawnZone as Area2D
@onready var collision_shape := spawn_zone.get_node("CollisionShape2D") as CollisionShape2D
@onready var rect_shape := collision_shape.shape as RectangleShape2D

func update_baggage(p: Personality):
	var size = rect_shape.size
	var left = size / 2.0
	var top = rangezone.size.y
	
	for child in container.get_children():
		if child is Sprite2D and child.name != "Suitcase":
			child.queue_free()
	suitcase.show()
	
	for i in range(len(p.baggage)):        
		var baggage := Sprite2D.new()
		baggage.scale = Vector2(0.3, 0.3)
		baggage.texture = p.baggage[i]
		
		var x = size.x * p.baggage_x[i]
		var y = size.y * p.baggage_y[i]
		
		baggage.position = left - Vector2(x, y + top)
		container.add_child(baggage)
