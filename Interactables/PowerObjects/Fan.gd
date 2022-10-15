class_name Fan

extends StaticBody2D

onready var powerableObject = $PowerableObject as PowerableObject
onready var Game = get_node("/root/Game")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var powered
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
export (float) var tickRate = 1
var tick = 0

export (float) var coolPower = 5
func _process(delta):
	tick += delta
	if powerableObject.powered:
		powered = true
		if tick > tickRate:
			Game.overload -= coolPower
			tick = 0
	else:
		powered = false
