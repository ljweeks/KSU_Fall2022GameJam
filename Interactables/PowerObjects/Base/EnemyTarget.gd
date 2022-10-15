extends Area2D

signal enemy_hit()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func enemyHit():
	emit_signal("enemy_hit")

