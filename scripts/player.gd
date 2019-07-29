extends Area2D

export (int) var speed = 200
var Bullet = preload('res://scenes/bullet.tscn')
onready var world = get_node('/root/world')
var player_state

signal move

func createBullet():
	var bullet = Bullet.instance()
	bullet.position = position
	world.add_child(bullet)
	player_state.canShoot = false

func resetOverheatWaitTime():
	var waitTime = world.countEnemiesAttachedToPlayer() + 1
	player_state.canShootTimer.set_wait_time(waitTime)
	player_state.canShootTimer.start()
	world.setOverheat(waitTime)

func getVelocity(delta):
	var velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	if velocity != Vector2(0, 0):
		# TODO connect this signal to the camera in order to move to a different room
		emit_signal('move')
	return velocity.normalized() * speed * delta

func handleUserInput():
	# TODO move input handling to world 
	if Input.is_action_just_released('click') && player_state.canShoot:
		createBullet()
		resetOverheatWaitTime()
	if Input.is_action_just_released('powerUp') && player_state.canShoot:
		world.freezeAllEnemies()


func _ready():
	set_process(true)
	player_state = {
		'canShoot': true,
		'canShootTimer': get_node('canShoot')
	}

func _process(delta):
	handleUserInput()
	position += getVelocity(delta)

func _on_canShoot_timeout():
	player_state.canShoot = true
	world.setOverheat(0)
