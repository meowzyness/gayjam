extends Control
class_name Scanner

@export var bounds_shape: CollisionShape2D
@export var max_scale := 1.0

func update(t: Person):
	for child in bounds_shape.get_children():
		child.queue_free()
	
	if !t:
		return

	var item_textures = t.personality.baggage
	var bounds := bounds_shape.shape as RectangleShape2D
	var bounds_half := bounds.size / 2.0

	for i in range(len(item_textures)):
		item_textures[i] = item_textures[i] as Texture
		if item_textures[i] == null:
			continue

		var texture_size = item_textures[i].get_size()

		var fit_scale := minf(
			max_scale,
			minf(bounds.size.x / texture_size.x, bounds.size.y / texture_size.y)
		)

		var half_sprite_size = texture_size * fit_scale / 2.0
		var min_pos = -bounds_half + half_sprite_size
		var max_pos = bounds_half - half_sprite_size

		var sprite := Sprite2D.new()
		sprite.texture = item_textures[i]
		sprite.scale = Vector2.ONE * fit_scale

		bounds_shape.add_child(sprite)
		sprite.position = bounds_shape.position + Vector2(
			(max_pos.x - min_pos.x) * t.personality.baggage_x[i] + min_pos.x,
			(max_pos.y - min_pos.y) * t.personality.baggage_y[i] + min_pos.y
		)
