extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var thunk = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$DeathPlayer.play()
	if thunk:
		$DeathPlayer2.play()


func _on_DeathPlayer_finished():
	queue_free()
