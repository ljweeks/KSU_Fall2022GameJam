extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Game = get_node("/root/Game")
export (float) var baseHeat = -7.5
export (float) var maxHeat = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var thisHeat : float = 0
export (float) var tickRate = 3
var tick = 0
func _process(delta):
	tick += delta
	if(tick > tickRate):
		tick = 0
		Game.overload += thisHeat
		thisHeat += 1
		if(thisHeat > maxHeat):
			thisHeat = maxHeat
		$Sprite.modulate = Color((thisHeat/5), 0, (-thisHeat/5))

func freeze():
	thisHeat -= 3
	if(thisHeat < baseHeat):
		thisHeat = baseHeat
