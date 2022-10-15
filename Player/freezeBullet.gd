extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200
var direction = Vector2(1, 0)
var life
# Called when the node enters the scene tree for the first time.
func _ready():
	life = rand_range(2,3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + speed * direction * delta
	if life <= 0.0:
		free()
	else:
		life -= delta
	
