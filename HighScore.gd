extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_font_override("font",load("res://MiscResources/hacker_font.tres"))
	var t = "High score: %0.2f"
	self.text = t % Scores.Scores.max()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
