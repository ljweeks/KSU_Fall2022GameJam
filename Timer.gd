extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Game = get_node("/root/Game")
# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_font_override("font",load("res://MiscResources/hacker_font.tres"))
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = "%0.1f"
	self.text = t % Game.totalTime
