extends RigidBody2D

export (int) var speed = 200
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# move forward
	self.position.y += speed * delta
