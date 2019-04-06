extends Node2D
var score

func _ready():
	score = 0

func addToScore(diff):
	score = score + diff
	var GUI = get_node('GUI')
	GUI.updateScore(score)
