extends Area2D

var current_plug = null
var collision_disable_timer = 0

func _process(delta):
	if collision_disable_timer > 0:
		collision_disable_timer -= delta
		if collision_disable_timer <= 0:
			$CollisionShape2D.disabled = false

func release_plug():
	if (current_plug != null):
		$CollisionShape2D.disabled = true
		current_plug.plugged = false
		collision_disable_timer = 1

func _on_Area2D_body_entered(body):
	if body is PlugEnd and current_plug == null:
		body.plugged = true
		body.sleeping = true
		body.global_position = global_position
		current_plug = body
