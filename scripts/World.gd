extends Node2D

onready var window_size = OS.get_window_size()
onready var player = get_node('player')
onready var player_world_pos = get_player_grid_pos()

var score
var overheat

func _ready():
	score = 0
	overheat = 0

func get_player_grid_pos():
	var player_pos = player.position
	var x = floor(player_pos.x / window_size.x)
	var y = floor(player_pos.y / window_size.y)
	return Vector2(x, y)

func addToScore(diff):
	var newScore = score + diff 
	score =  newScore if newScore >= 0 else 0
	var GUI = get_node('GUI')
	GUI.updateScore(score)

func setOverheat(value):
	overheat = value
	var GUI = get_node('GUI')
	GUI.updateOverheat(value)

func countEnemiesAttachedToPlayer():
	var counter = 0
	for enemy in get_tree().get_nodes_in_group('enemies'):
		if enemy.isAttachedToPlayer:
			counter = counter + 1
	return counter

func freezeAllEnemies():
	for enemy in get_tree().get_nodes_in_group('enemies'):
		enemy.freeze()

func _on_player_moving():
	var new_player_grid_pos = get_player_grid_pos()
	var transform = Transform2D()

	if new_player_grid_pos != player_world_pos:
		print('se salió de la pantalla')
		player_world_pos = new_player_grid_pos
		transform = get_viewport().get_canvas_transform()
		transform[2] = -player_world_pos * window_size
		get_viewport().set_canvas_transform(transform)
