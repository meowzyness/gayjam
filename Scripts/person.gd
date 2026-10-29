extends CharacterBody2D


var is_walker := randi_range(0, 1)
var SPEED := randf_range(70, 100)
var time = 0.0
var personality: Personality = Personality.new()


func _ready():
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
	var direction: Vector2 = Vector2.RIGHT
	if is_walker:
		position.y = -abs(sin(time * SPEED/8) * 4)
		velocity = direction * SPEED
	else:
		velocity = direction * 50.0

	if position.x > 1500:
		queue_free()
	move_and_slide()
