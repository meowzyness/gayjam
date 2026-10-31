extends Area2D

var time: float = 0.0
@export var is_walker: bool = randi_range(0, 1)
@export var direction: Vector2 = Vector2.LEFT
@export var speed: float = randf_range(70, 120)
var personality: Personality
var hovered: bool = false

@export var box_size := Vector2(70, 100)
@export var box_offset := Vector2(0, -70)
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

	if !input_event.is_connected(_on_input_event):
		input_event.connect(_on_input_event)

	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if personality:
			if has_node("/root/Node2D/Dossier"):
				$/root/Node2D/Dossier.update_info(self, personality)
			if has_node("/root/Node2D/Scanner"):
				$/root/Node2D/Scanner.set_target(self, personality)
				$/root/Node2D/Scanner.update_baggage(personality)

func _on_mouse_entered() -> void:
	hovered = true

func _on_mouse_exited() -> void:
	hovered = false


func _physics_process(delta: float) -> void:
	time += delta
	var velocity
	if is_walker:
		position.y = -abs(sin(time * speed/8) * 4)
		velocity = direction * speed
	else:
		velocity = direction * 50.0

	if position.x < -2500:
		queue_free()
	position += velocity * delta
