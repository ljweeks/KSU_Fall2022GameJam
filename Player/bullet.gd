extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 300
var direction = Vector2(1, 0)
export (int) var baseDamage = 3
onready var damage = baseDamage
onready var Game = get_node("/root/Game")

func _process(delta):
	if(Game.overload > 100):
		sicko(true)
	if(Game.overload < 90):
		sicko(false)

func sicko(input):
	if(input):
		damage = 10
	else:
		damage = baseDamage

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "collide")
	contact_monitor = true;
	contacts_reported = 10
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_body_entered(body):
	if(not body is Player):
		if body.has_method("damaged"):
			body.damaged(damage)
		queue_free()
		
func collide(body):
	queue_free()
