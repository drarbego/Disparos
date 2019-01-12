extends Area2D

export (int) var speed = 200
var Bullet = preload('res://scenes/bullet.tscn')

func get_velocity(delta):
	var velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	return velocity.normalized() * speed * delta

func fire_listener():
	if Input.is_action_just_released('click'):
		var bullet = Bullet.instance()
		bullet.position = position
		var world = get_node('/root/world')
		world.add_child(bullet)

func look_at_mouse():
	var mouse_pos = get_global_mouse_position()
	var angle = position.angle_to_point(mouse_pos)
	rotation = angle + PI/2

func _ready():
	set_process(true)

func _process(delta):
	look_at_mouse()
	fire_listener()
	position += get_velocity(delta)
