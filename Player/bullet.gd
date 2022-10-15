extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 300
var direction = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_body_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + speed * direction * delta


func _on_body_entered(body):
	if(not body is Player):
		queue_free()
