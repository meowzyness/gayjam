extends Node2D

@export var miss_chance := 0.15
@export var jitter := 3.0
@export var scan_interval := 0.01

var boxes: Array[Rect2] = []
var scan_timer := 0.0

func _process(delta: float) -> void:
	scan_timer -= delta
	if scan_timer > 0.0:
		return

	scan_timer = scan_interval
	boxes.clear()

	for target in get_tree().get_nodes_in_group("detectable"):
		if not target.has_method("get_detection_rect"):
			continue
		#if randf() < miss_chance:
			#continue

		var rect: Rect2 = target.get_detection_rect()
		#rect.position += Vector2(
			#randf_range(-jitter, jitter),
			#randf_range(-jitter, jitter)
		#)
		boxes.append(rect)

	queue_redraw()

func _draw() -> void:
	for rect in boxes:
		draw_rect(rect, Color(0.2, 1.0, 0.3, 0.9), false, 2.0)
