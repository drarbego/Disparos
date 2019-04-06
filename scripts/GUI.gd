extends MarginContainer

func updateScore(score):
	var scoreLabel = get_node('score')
	scoreLabel.set_text(str(score))
