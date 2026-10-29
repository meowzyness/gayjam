extends CharacterBody2D


var is_walker := randi_range(0, 1)
var SPEED := randf_range(70, 100)
var time = 0.0


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
