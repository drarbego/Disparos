extends Timer
var secondsLeft
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func set_wait_time(time):
	self.wait_time = time
	self.secondsLeft = time
	print('wait time set to ', time)

func _ready():
	secondsLeft = self.get_wait_time()

func _process(delta):
	var diff = secondsLeft - get_time_left()
	if diff >= 1:
		secondsLeft = secondsLeft - 1
		print('secondsLeft = ', secondsLeft)
		get_node('/root/world/').setOverheat(secondsLeft)
