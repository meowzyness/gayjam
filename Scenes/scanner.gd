extends CanvasLayer

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
