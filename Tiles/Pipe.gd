extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Game = get_node("/root/Game")
export (float) var baseHeat = -2
export (float) var maxHeat = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var thisHeat : float = 0
export (float) var tickRate = 1
var tick = 0
export (float) var heatIncreaseAmountPerTick = 0.05

func _process(delta):
	tick += delta
	if(tick > tickRate):
		tick = 0
		Game.overload += thisHeat
		thisHeat += heatIncreaseAmountPerTick
		if(thisHeat > maxHeat):
			thisHeat = maxHeat
		#$Sprite.modulate = Color((thisHeat/5), 0, (-thisHeat/5))
	
	var heatPer = (thisHeat - baseHeat)/(maxHeat - baseHeat)
	$Sprite.material.set_shader_param("heat", clamp(heatPer * 2 - 1, -1, 1))

func freeze():
	thisHeat -= 3
	if(thisHeat < baseHeat):
		thisHeat = baseHeat


func _on_EnemyTarget_enemy_hit(item):
	thisHeat += 2
