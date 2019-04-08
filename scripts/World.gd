extends Node2D
var score
var overheat

func _ready():
	score = 0
	overheat = 0

func addToScore(diff):
	var newScore = score + diff 
	score =  newScore if newScore >= 0 else 0
	var GUI = get_node('GUI')
	GUI.updateScore(score)

func setOverheat(value):
	overheat = value
	var GUI = get_node('GUI')
	GUI.updateOverheat(value)

func getGunWaitTime():
	var counter = 0
	for enemy in get_tree().get_nodes_in_group('enemies'):
		if enemy.isAttachedToPlayer:
			counter = counter + 1
	var waitTime = counter if counter > 1 else 1
	setOverheat(waitTime)
	return waitTime
