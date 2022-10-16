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
	$AnimatedSprite.playing = true


func _on_DeathPlayer_finished():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	queue_free()
