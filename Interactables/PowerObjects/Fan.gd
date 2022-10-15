extends StaticBody2D

onready var powerableObject = $PowerableObject as PowerableObject

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if powerableObject.powered:
		print("powered")
	else:
		pass
