extends KinematicBody2D

#can change player speed
export (int) var speed = 500



#player velocity
var velocity = Vector2()
#time between shots
var attackSpeed = 0.5
var shootTime = 0.00
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#gets user input and changes the velocity
func user_input():
	velocity = Vector2()
	if Input.is_action_pressed("player_right"):
		velocity.x += 1
	if Input.is_action_pressed("player_left"):
		velocity.x -= 1
	if Input.is_action_pressed("player_down"):
		velocity.y += 1
	if Input.is_action_pressed("player_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed	
	
func shoot(delta):
	if Input.is_action_just_pressed("shoot_left"):
		leftShot()
		print("shoot")
	if Input.is_action_pressed("shoot_right"):
		if shootTime <= 0.0:
			shootTime = attackSpeed
			rightShot(delta)
		else:
			shootTime -= delta
		
		

func leftShot():
	var bullet = load("res://Player/bullet.tscn").instance()
	bullet.global_position = $ShootPoint.global_position
	bullet.look_at(bullet.global_position + bullet.direction)
	bullet.direction = (get_global_mouse_position() - bullet.global_position).normalized()
	get_parent().add_child(bullet)



func rightShot(delta):
	for i in 5:
		var freezeBullet = load("res://Player/freezeBullet.tscn").instance()
		freezeBullet.global_position = $ShootPoint.global_position
		freezeBullet.look_at(freezeBullet.global_position + freezeBullet.direction)
		freezeBullet.direction = (get_global_mouse_position() - freezeBullet.global_position).normalized().rotated(rand_range(-PI / 10, PI / 10))
		#freezeBullet.direction = freezeBullet.direction.angle
		get_parent().add_child(freezeBullet)

# Called every frame. 'delta' is the elapsed time since the previous frame.

#move the player
func _process(delta):
	user_input()
	shoot(delta)
	velocity = move_and_slide(velocity)

