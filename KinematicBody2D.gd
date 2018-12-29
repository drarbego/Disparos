extends KinematicBody2D

export (int) var speed = 200

var velocity

func get_input():
    velocity = Vector2()
    if Input.is_action_pressed('right'):
        velocity.x += 1
    if Input.is_action_pressed('left'):
        velocity.x -= 1
    if Input.is_action_pressed('down'):
        velocity.y += 1
    if Input.is_action_pressed('up'):
        velocity.y -= 1
    velocity = velocity.normalized() * speed
    var mouse_pos = get_global_mouse_position()
    var distance = (mouse_pos-position).length()
    var new_angle = (mouse_pos-position).angle() + PI
    var x = distance * cos(new_angle) + mouse_pos.x
    var y = distance * sin(new_angle) + mouse_pos.y
    self.look_at(Vector2(x, y))
    print("new angle ", new_angle)
    print("new pos", Vector2(x, y))


func _physics_process(delta):
    get_input()
    move_and_slide(velocity)