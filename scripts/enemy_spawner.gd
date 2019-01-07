extends Node

var enemy_index = 0;
const Enemy = preload("res://scenes/enemy.tscn")

func get_spawners():
	var spawners = []
	var children = get_children()
	for child in children:
		if child.is_class("Node2D"):
			spawners.append(child)
	return spawners

func spawn():
	print("spawning enemy ", enemy_index)
	var spawners = get_spawners()
	
	randomize()
	var spawner = spawners[randi()%spawners.size()]
	

	var enemy = Enemy.instance()
	enemy.position = spawner.position
	self.add_child(enemy)

func _ready():
	spawn()

func _on_Timer_timeout():
	spawn()

