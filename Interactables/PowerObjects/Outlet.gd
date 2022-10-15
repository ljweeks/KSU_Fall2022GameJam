extends Area2D

var current_plug = null
var collision_disable_timer = 0

func _process(delta):
	if collision_disable_timer > 0:
		collision_disable_timer -= delta
		if collision_disable_timer <= 0:
			$CollisionShape2D.disabled = false

func release_plug(direction):
	if (current_plug != null):
		$CollisionShape2D.disabled = true
		$PinJoint2D.node_b = NodePath()
		current_plug.plugged = false
		current_plug.apply_central_impulse(direction * 500)
		current_plug = null
		collision_disable_timer = 1
		$PowerArea.providingPower = false

func add_plug(body):
	body.plugged = true
	body.sleeping = true
	body.global_position = global_position
	current_plug = body
	$PinJoint2D.node_b = current_plug.get_path()
	body.global_position = global_position
	
	$PowerArea.providingPower = true

func _on_Area2D_body_entered(body):
	if body is PlugEnd and current_plug == null:
		add_plug(body)
		
func _physics_process(delta):
	if (current_plug != null):
		current_plug.angular_velocity = 0
		current_plug.linear_velocity = Vector2.ZERO
		$PinJoint2D.position = Vector2.ZERO
		current_plug.rotation = 0


func _on_EnemyTarget_enemy_hit(direction):
	release_plug(direction)
