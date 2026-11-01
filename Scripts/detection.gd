extends Node2D


@export var scan_origin: Node2D
@export_flags_2d_physics var occlusion_mask: int = 1

@export var scan_interval := 0.5
var scan_timer := 0.0

func _ready() -> void:
	z_as_relative = false
	z_index = 4096

func visibility_score(target: Area2D, rect: Rect2, targets: Array) -> float:
	var visible := 0
	var total := 9

	for x in range(1, 4):
		for y in range(1, 4):
			var point := rect.position + rect.size * Vector2(x, y) / 4.0
			var covered := false

			for other in targets:
				if other == target:
					continue
				
				if not other is Person:
					#other = other as Area2D
					if other.get_overlapping_areas().has(target):
						covered = true
						break
					continue
				if other.render_rank > target.render_rank and other.get_detection_rect().has_point(point):
					covered = true
					break

			if not covered:
				visible += 1

	return float(visible) / total


var tracked_boxes: Dictionary = {}
var tracked_targets: Dictionary = {}
var update_wait: Dictionary = {}
var hidden_time: Dictionary = {}

func _process(delta: float) -> void:
	var previous_tracks := tracked_boxes
	tracked_boxes = {}

	var targets := get_tree().get_nodes_in_group("detectable")

	for target in targets:
		if not target is Person:
			continue

		var id: int = target.get_instance_id()
		var rect: Rect2 = target.get_detection_rect()
		var score := visibility_score(target, rect, targets)

		if score <= 0.9:
			target.input_pickable = false
			continue

		var hidden := float(hidden_time.get(id, 0.0))
		if hidden > 0.0:
			hidden_time[id] = maxf(0.0, hidden - scan_interval)
			target.input_pickable = false
			continue

		#if randf() < 0.01:
			#hidden_time[id] = randf_range(0.12, 0.36)
			#continue

		if score < 0.5 and randf() < 0.05:
			hidden_time[id] = randf_range(1.0, 3.0)
			target.input_pickable = false
			continue

		var noisy_rect := rect
		if randf() < 0.5:
			noisy_rect.position += Vector2(
				randf_range(-2.0, 2.0),
				randf_range(-2.0, 2.0)
			)
			noisy_rect.size *= randf_range(0.96, 1.04)
			
		if randf() < 0.05:
			noisy_rect.position += Vector2(
				randf_range(-20.0, 2.0),
				randf_range(-1.0, 1.0)
			)
			noisy_rect.size *= randf_range(0.8, 1.1)

		var display_rect := noisy_rect
		if previous_tracks.has(id):
			var previous: Rect2 = previous_tracks[id]
			var wait := float(update_wait.get(id, 0.0))

			if wait > 0.0:
				display_rect = previous
				update_wait[id] = maxf(0.0, wait - scan_interval)
			else:
				display_rect = Rect2(
					previous.position.lerp(noisy_rect.position, 0.35),
					previous.size.lerp(noisy_rect.size, 0.35)
				)
				#if randf() < 0.8:
					#display_rect = noisy_rect
				#else:
				update_wait[id] = randf_range(0.08, 0.2)

		target.input_pickable = true
		tracked_targets[id] = target
		tracked_boxes[id] = display_rect

	queue_redraw()


func _draw() -> void:
	for i in tracked_boxes.keys():
		var rect = tracked_boxes[i]
		var label := "%0.2f" % tracked_targets[i].personality.sussyness
		var font := ThemeDB.fallback_font
		var width := 2.0
		
		var color := Color.WHITE
		if tracked_targets[i].personality.sussyness < 1:
			color = Color.RED
		if tracked_targets[i].personality.sussyness < 0.75:
			color = Color.ORANGE
		if tracked_targets[i].personality.sussyness < 0.5:
			color = Color.YELLOW
		if tracked_targets[i].personality.sussyness < 0.25:
			color = Color.GREEN
		if tracked_targets[i].hovered == true:
			color = color.darkened(0.1)
			label = tracked_targets[i].personality.name
		if tracked_targets[i] == $/root/Node2D/CanvasLayer/UI.target:
			color = Color.LIGHT_BLUE
			label = tracked_targets[i].personality.name
			width = 4.0

		draw_rect(rect, color, false, width)
		draw_string(
			font,
			Vector2(rect.position.x, rect.position.y - 6),
			label,
			HORIZONTAL_ALIGNMENT_LEFT,
			-1,
			14,
			color
		)
