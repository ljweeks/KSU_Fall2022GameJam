extends ProgressBar


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var Game = get_node("/root/Game")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
		self.value = Game.overload
