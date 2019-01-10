extends RigidBody2D

var player_position = Vector2()
var direction = Vector2()

func init(player_pos, dir):
	direction = dir
	player_position = player_pos

func _ready():
	print(player_position)
	position = player_position
	apply_impulse(position, direction)
