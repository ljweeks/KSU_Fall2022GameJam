extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bat = false
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_exited", self, "left")





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = get_overlapping_bodies()
	for item in bodies:
		if item is Battery:
			bat = true

func left(body):
	if body is Battery:
		bat = false
	
