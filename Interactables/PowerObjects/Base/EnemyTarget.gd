extends Area2D

signal enemy_hit()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "enemyHit")


func enemyHit(body):
	if body is enemyBullet:
		emit_signal("enemy_hit")
		body.queue_free()

