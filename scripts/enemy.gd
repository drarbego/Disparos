extends Area2D

export(int) var speed
export(float) var freezeTime
var isFrozen = false
var isAttachedToPlayer = false
var lifePoints = 1

var defaultTexture = preload('res://sprites/enemy.png')
var frozenTexture = preload('res://sprites/enemy__frozen.png')

onready var world = get_node('/root/world')
onready var player = get_node('/root/world/player')
onready var enemy_state = {
	'freezeTimer': get_node('freeze')
}

func setSpeed(s):
	speed = s

func getSpeed():
	return speed

func setLifePoints(p):
	lifePoints = p

func getLifePoints():
	return lifePoints

func decreaseLife(points):
	setLifePoints(getLifePoints() - abs(points))
	if getLifePoints() <= 0:
		die()

func increaseLife(points):
	setLifePoints(getLifePoints() + abs(points))

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

func _process(delta):
	if isFrozen:
		return
	elif isAttachedToPlayer:
		position += get_velocity(delta)
	else:
		var direction = (player.position - position).normalized()
		position += direction * speed * delta

func resetFreezeWaitTime():
	enemy_state.freezeTimer.set_wait_time(freezeTime)
	enemy_state.freezeTimer.start()

func freeze():
	isFrozen = true
	get_node('sprite').texture = frozenTexture
	resetFreezeWaitTime()

func die():
	world.addToScore(1)
	queue_free()

func explode():
	die()

func attachToPlayer():
	if isAttachedToPlayer:
		explode()
	isAttachedToPlayer = true
	# get_node('sprite').texture = attachedTexture

func merge(area):
	# calculate position
	increaseLife(area.getLifePoints())
	setSpeed(getSpeed() + area.getSpeed())

func _on_freeze_timeout():
	isFrozen = false
	get_node('sprite').texture = defaultTexture
	pass

func _on_enemy_area_entered(area):
	if self.is_queued_for_deletion():
		return

	if area.is_in_group("player"):
		print('muerto por jugarle al vergas')
		get_tree().quit()
	elif area.is_in_group("enemies"):
		# TODO cuando choquen los enemigos, se combinan en uno mas poderoso
		merge(area)
		area.queue_free()
