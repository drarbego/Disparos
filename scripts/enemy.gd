extends Area2D

export(int) var speed
export(float) var freezeTime
var isFrozen = false

func _process(delta):
	if not isFrozen:
		var player = get_node('/root/world/player')
		var direction = (player.position - position).normalized()
		position += direction * speed * delta

func freeze():
	print('I have to freeze')
	isFrozen = true
	var timer = get_node('freeze')
	timer.wait_time = freezeTime
	timer.start()
	print(get_position_in_grid())

func get_position_in_grid():
	var cell_size = 10
	var cell_width = get_viewport().size.x / cell_size
	var cell_height = get_viewport().size.y / cell_size
	return Vector2(int(position.x / cell_width), int(position.y / cell_height))

func _on_freeze_timeout():
	isFrozen = false
