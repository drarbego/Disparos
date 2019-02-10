extends Area2D

export(int) var speed
export(float) var freezeTime
var isFrozen = false

var defaultTexture = preload('res://sprites/enemy.png')
var frozenTexture = preload('res://sprites/enemy__frozen.png')

func _process(delta):
	if not isFrozen:
		var player = get_node('/root/world/player')
		var direction = (player.position - position).normalized()
		position += direction * speed * delta

func checkEnemyIsFrozen():
	# TODO this function will check if frozen enemies
	# are alligned, if so, they will disapear and score will
	# increment
	var frozenEnemies = 0
	var enemies = get_tree().get_nodes_in_group('enemies')
	for enemy in enemies:
		if enemy.isFrozen:
			frozenEnemies += 1
	print('frozen enemies = ', frozenEnemies)


func freeze():
	isFrozen = true
	position = get_position_in_grid()
	var timer = get_node('freeze')
	get_node('sprite').texture = frozenTexture
	checkEnemyIsFrozen()
	timer.wait_time = freezeTime
	timer.start()

func get_position_in_grid():
	var numberOfCells = 10
	var cellWidth = get_viewport().size.x / numberOfCells
	var cellHeight = get_viewport().size.y / numberOfCells
	var x = int(position.x / cellWidth) * cellWidth + cellWidth/2
	var y = int(position.y / cellHeight) * cellHeight + cellHeight/2
	return Vector2(x, y)

func _on_freeze_timeout():
	isFrozen = false
	get_node('sprite').texture = defaultTexture
