extends MarginContainer

func updateScore(score):
	var scoreLabel = get_node('container/score')
	scoreLabel.set_text(str(score))

func updateOverheat(overheat):
	var overheatLbl = get_node('container/overheat')
	overheatLbl.set_text(str(overheat))
