extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 300
var direction = Vector2(1, 0)
export (int) var damage = 3


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
