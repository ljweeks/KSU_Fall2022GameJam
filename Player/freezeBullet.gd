extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 200
var direction = Vector2(1, 0)
var life


onready var Game = get_node("/root/Game")




func sicko(input):
	if(input):
		speed = 600
	else:
		speed = 200
# Called when the node enters the scene tree for the first time.
func _ready():
	life = rand_range(2,3)
	connect("body_entered", self, "_on_body_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Game.overload > 100):
		sicko(true)
	if(Game.overload < 90):
		sicko(false)
	position = position + speed * direction * delta
	if life <= 0.0:
		queue_free()
	else:
		life -= delta
	
func _on_body_entered(body):
	if(not body is Player):
		if(body.has_method("freeze")):
			body.freeze()
		queue_free()
