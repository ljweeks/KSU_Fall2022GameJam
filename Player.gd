class_name Player
extends KinematicBody2D

#can change player speed
export (int) var speed = 500

onready var animTree = $AnimationTree
onready var animationState = animTree.get("parameters/playback")
onready var Game = get_node("/root/Game")
var walking = false
var sicko = false

#player velocity
var velocity = Vector2()
#time between shots
var attackSpeed = 0.2
var shootTime = 0.00
# Called when the node enters the scene tree for the first time.
func _ready():
	animTree.active = true

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
	
	if velocity.length() > 0 and not walking:
		walking = true
		animationState.travel("Walk")
	elif velocity.length() <= 0 and walking:
		walking = false
		animationState.travel("Idle")
	
	if walking:
		print(velocity.normalized())
		animTree.set("parameters/Idle/blend_position", velocity.normalized())
		animTree.set("parameters/Walk/blend_position", velocity.normalized())
	
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
		
		

var bulletSpeed = 1000

func leftShot():
	var bullet = load("res://Player/bullet.tscn").instance()
	bullet.global_position = $ShootPoint.global_position
	bullet.look_at(bullet.global_position + bullet.direction)
	bullet.direction = (get_global_mouse_position() - bullet.global_position).normalized()
	var impulseDir = Vector2(bullet.direction.x, bullet.direction.y)
	bullet.apply_central_impulse(impulseDir*bulletSpeed)
	get_parent().add_child(bullet)



func rightShot(delta):
	for i in 3:
		var freezeBullet = load("res://Player/freezeBullet.tscn").instance()
		get_parent().add_child(freezeBullet)
		freezeBullet.global_position = $ShootPoint.global_position
		freezeBullet.look_at(freezeBullet.global_position + freezeBullet.direction)
		freezeBullet.direction = (get_global_mouse_position() - freezeBullet.global_position).normalized().rotated(rand_range(-PI / 10, PI / 10))
		#freezeBullet.direction = freezeBullet.direction.angle


# Called every frame. 'delta' is the elapsed time since the previous frame.

#move the player
func _process(delta):
	user_input()
	shoot(delta)
	if(Game.overload > 100):
		sicko(true)
	if(Game.overload < 90):
		sicko(false)

func sicko(input):
	if(input):
		attackSpeed = 0.1
		speed = 750
		bulletSpeed = 2000
	else:
		attackSpeed = 0.2
		speed = 500
		bulletSpeed = 1000

func _physics_process(delta):
	velocity = move_and_slide(velocity)

