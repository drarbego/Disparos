extends Area2D

export (int) var speed = 300

func _ready():
	set_process(true)
	pass

func _process(delta):
	var player = get_node("../../player")
	var direction = player.position - position
	var dist = sqrt(direction.x*direction.x + direction.y*direction.y)
	if dist > 16:
		position += direction.normalized() * speed * delta
