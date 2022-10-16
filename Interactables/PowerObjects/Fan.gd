class_name Fan

extends StaticBody2D
enum direction {blow_up, blow_down, blow_left, blow_right}
export (direction) var fanDirection 
onready var powerableObject = $PowerableObject as PowerableObject
onready var Game = get_node("/root/Game")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var powered
# Called when the node enters the scene tree for the first time.
func _ready():
	fanDir()
export (float) var tickRate = 0.25
var tick = 0

func fanDir():
	if(fanDirection == direction.blow_up):
			$AnimatedSprite.play("blow_up", false)
	if(fanDirection == direction.blow_down):
			$AnimatedSprite.play("blow_down", false)
	if(fanDirection == direction.blow_left):
			$AnimatedSprite.play("blow_left", false)
	if(fanDirection == direction.blow_right):
			$AnimatedSprite.play("blow_right", false)

export (float) var coolPower = 0.75
func _process(delta):
	tick += delta
	if powerableObject.powered:
		powered = true
		$AudioStreamPlayer2D.play()
		$AnimatedSprite.material.set_shader_param("heat", -1)
		if tick > tickRate:
			Game.overload -= coolPower
			fanDir()
			tick = 0
	else:
		powered = false
		$AudioStreamPlayer2D.stop()
		$AnimatedSprite.material.set_shader_param("heat", 0)
		$AnimatedSprite.stop()
