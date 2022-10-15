extends Node2D

onready var overload = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var tickRate = 1
var tick = 0
func _process(delta):
	tick += delta
	if(tick > tickRate):
		overload += 1
		tick = 0
