extends Area2D

export(int) var speed
var direction = Vector2()
var damage = 1

func _ready():
	direction = (get_global_mouse_position() - position).normalized()

func setDamage(points):
	damage = points

func isOutOfTheScreen():
	var isInsideX = position.x <= get_viewport().size.x && position.x >= 0
	var isInsideY = position.y <= get_viewport().size.y && position.y >= 0
	return !(isInsideX && isInsideY)

func _process(delta):
	if isOutOfTheScreen():
		queue_free()
	position += direction * speed * delta

func _on_bullet_area_entered(area):
	if area.is_in_group('enemies'):
		# area.attachToPlayer()
		area.decreaseLife(damage)
		queue_free() # destroy bullet
