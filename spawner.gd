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

func _on_timer_timeout():
	print('spawning')
	var enemy = Enemy.instance()
	enemy.position.x = get_viewport().size.x
	enemy.position.y = get_viewport().size.y
	self.get_parent().add_child(enemy)
	timer.wait_time = rand_range(minWaitTime, maxWaitTime)
	timer.start()
