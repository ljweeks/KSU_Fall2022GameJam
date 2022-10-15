extends Area2D

signal enemy_hit()

export var target_active = true setget target_changed

func target_changed(new_value):
	if (new_value):
		add_to_group("EnemyTarget")
	else:
		remove_from_group("EnemyTarget")
	target_active = new_value

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "enemyHit")
	target_changed(target_active)
	


func enemyHit(body):
	if body is enemyBullet:
		emit_signal("enemy_hit", (body.global_position - global_position).normalized())
		body.queue_free()

