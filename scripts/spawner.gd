extends Node

var Enemy = preload('res://scenes/enemy.tscn')

var timer

export(float) var minWaitTime
export(float) var maxWaitTime

func _ready():
	randomize()
	timer = get_node('timer')
	timer.wait_time = rand_range(minWaitTime, maxWaitTime)
	timer.start()

func spawn():
	var enemy = Enemy.instance()
	var stickTo = randi() % 2;
	if stickTo == 0:
		enemy.position.x = 0
		enemy.position.y = randi() % int(get_viewport().size.y)
	else:
		enemy.position.x = randi() % int(get_viewport().size.x)
		enemy.position.y = 0


	self.get_parent().add_child(enemy)
	timer.wait_time = rand_range(minWaitTime, maxWaitTime)
	timer.start()

func _on_timer_timeout():
	spawn()
