extends Node

const Enemy = preload("res://scenes/enemy.tscn")

func spawn():
	randomize()
	var enemy = Enemy.instance()
	var enemy_position = Vector2()
	enemy_position.x = [0, get_viewport().size.x][randi()%2]
	enemy_position.y = [0, get_viewport().size.y][randi()%2]
	enemy.position = enemy_position
	print(enemy_position)
	get_node("container").add_child(enemy)

func _ready():
	spawn()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
