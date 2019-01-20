extends Area2D

export(int) var speed = 800
var direction = Vector2()

func _ready():
	direction = (get_global_mouse_position() - position).normalized()

func _process(delta):
	position += direction * speed * delta

func _on_bullet_area_entered(area):
	if area.is_in_group('enemies'):
		area.freeze()
		queue_free()
