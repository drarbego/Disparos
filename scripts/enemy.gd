extends Area2D

export(int) var speed
export(float) var freezeTime
export(int) var numberOfCells
var isFrozen = false
var neighbors = {}

var defaultTexture = preload('res://sprites/enemy.png')
var frozenTexture = preload('res://sprites/enemy__frozen.png')

onready var CELL_WIDTH = get_viewport().size.x / numberOfCells
onready var CELL_HEIGHT = get_viewport().size.y / numberOfCells

func _process(delta):
	if not isFrozen:
		var player = get_node('/root/world/player')
		var direction = (player.position - position).normalized()
		position += direction * speed * delta

func getGridPosition(offsetX, offsetY):
	var cellWidth = get_viewport().size.x / numberOfCells
	var cellHeight = get_viewport().size.y / numberOfCells
	offsetX *= cellWidth
	offsetY *= cellHeight
	return Vector2(position.x + offsetX, position.y + offsetY)

func updateNeighbors():
	# TODO use this information to build a map of tiles and enemies
	var enemies = get_tree().get_nodes_in_group('enemies')
	for enemy in enemies:
		if enemy.isFrozen:
			var hasNeighbors = false
			if position == enemy.getGridPosition(-1, 0):
				neighbors['e'] = enemy
				enemy.queue_free()
				hasNeighbors = true
			if position == enemy.getGridPosition(1, 0):
				neighbors['w'] = enemy
				enemy.queue_free()
				hasNeighbors = true
			if position == enemy.getGridPosition(0, -1):
				neighbors['n'] = enemy
				enemy.queue_free()
				hasNeighbors = true
			if position == enemy.getGridPosition(0, 1):
				neighbors['s'] = enemy
				enemy.queue_free()
				hasNeighbors = true
			if hasNeighbors:
				queue_free()

func freeze():
	isFrozen = true
	snapToGrid()
	get_node('sprite').texture = frozenTexture
	updateNeighbors()
	print('neighbors = ', neighbors)
	var timer = get_node('freeze')
	timer.wait_time = freezeTime
	timer.start()

func snapToGrid():
	var x = int(position.x / CELL_WIDTH) * CELL_WIDTH + CELL_WIDTH/2
	var y = int(position.y / CELL_HEIGHT) * CELL_HEIGHT + CELL_HEIGHT/2
	position = Vector2(x, y)

func _on_freeze_timeout():
	isFrozen = false
	get_node('sprite').texture = defaultTexture

func _on_enemy_area_entered(area):
	if area.is_in_group("player") && isFrozen:
		var angle = rad2deg(area.position.angle_to_point(position) + PI)
		if angle >= 315 || angle < 45:
			# TODO make sure there is no frozen enemy on the tile at the right
			position.x += CELL_WIDTH
		if angle >= 45 && angle < 135:
			position.y += CELL_HEIGHT
		if angle >= 135 && angle < 225:
			position.x -= CELL_WIDTH
		if angle >= 225 && angle < 315:
			position.y -= CELL_HEIGHT
