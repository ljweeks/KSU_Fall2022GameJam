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
		$PinJoint2D.node_b = NodePath()
		current_plug.plugged = false
		current_plug = null
		collision_disable_timer = 1

func _on_Area2D_body_entered(body):
	if body is PlugEnd and current_plug == null:
		body.plugged = true
		body.sleeping = true
		body.global_position = global_position
		current_plug = body
		$PinJoint2D.node_b = current_plug.get_path()
		body.global_position = global_position
		#yield(get_tree().create_timer(1), "timeout")
		#release_plug()
		
func _physics_process(delta):
	if (current_plug != null):
		current_plug.angular_velocity = 0
		current_plug.linear_velocity = Vector2.ZERO
		$PinJoint2D.position = Vector2.ZERO
		current_plug.rotation = 0


func _on_EnemyTarget_enemy_hit():
	release_plug()
