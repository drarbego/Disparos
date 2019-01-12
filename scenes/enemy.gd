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


func _on_freeze_timeout():
	isFrozen = false
