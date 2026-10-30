extends CharacterBody2D


var is_walker: bool = randi_range(0, 1)
var speed: float = randf_range(70, 120)
var time: float = 0.0
var personality: Personality
var direction: Vector2 = Vector2.LEFT


func _ready():
	personality =  Personality.new()
	var sprite: Sprite2D = $Sprite2D as Sprite2D
	sprite.texture = personality.texture
	
	input_pickable = true 

	if not input_event.is_connected(_on_input_event):
		input_event.connect(_on_input_event)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		if personality:
			print("--- Данные человека ---")
			print(personality.get_info())


func _physics_process(delta: float) -> void:
	time += delta
	if is_walker:
		position.y = -abs(sin(time * speed/8) * 4)
		velocity = direction * speed
	else:
		velocity = direction * 50.0

	if position.x > 1500:
		queue_free()
	move_and_slide()
