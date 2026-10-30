extends Area2D

var time: float = 0.0
@export var is_walker: bool = randi_range(0, 1)
@export var direction: Vector2 = Vector2.LEFT
@export var speed: float = randf_range(70, 120)
var personality: Personality

@export var box_size := Vector2(70, 150)
@export var box_offset := Vector2(0, -50)
var render_rank := randi_range(0, 50)

func get_detection_rect() -> Rect2:
	return Rect2(global_position + box_offset - box_size / 2.0, box_size)

func _ready():
	personality = Personality.new()
	var sprite: Sprite2D = $Sprite2D as Sprite2D
	sprite.texture = personality.totaly_real_texture
	
	if !is_walker:
		sprite.modulate = "#555555"
		$CollisionShape2D.disabled = true;
		remove_from_group("detectable")
	else:
		z_index = render_rank
		input_pickable = true 

	if not input_event.is_connected(_on_input_event):
		input_event.connect(_on_input_event)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if personality:
			$/root/Node2D/Dossier.update_info(personality)


func _physics_process(delta: float) -> void:
	time += delta
	var velocity
	if is_walker:
		position.y = -abs(sin(time * speed/8) * 4)
		velocity = direction * speed
	else:
		velocity = direction * 50.0

	if position.x < -1500:
		queue_free()
	position += velocity * delta
