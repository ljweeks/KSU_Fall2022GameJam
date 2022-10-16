extends Area2D

var current_plug = null
var collision_disable_timer = 0
export var power_area_collision_scale = 1
onready var base_radius = $PowerArea/CollisionShape2D.shape.radius
onready var Game = get_node("/root/Game")
func _ready():
	$PowerArea/CollisionShape2D.shape.radius = base_radius * power_area_collision_scale

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
		$EnemyTarget.target_active = false
		$PlugSprite.visible = true
		$PluggedSprite.visible = false
		
		add_to_group("CompassTargets")

func add_plug(body):
	body.global_position = global_position
	body.plugged = true
	body.sleeping = true
	body.force_update_transform()
	current_plug = body
	$PinJoint2D.node_b = current_plug.get_path()
	body.global_position = global_position
	body.force_update_transform()
	$AudioStreamPlayer2D.play()
	
	$PowerArea.providingPower = true
	$EnemyTarget.target_active = true
	$PlugSprite.visible = false
	$PluggedSprite.visible = true
	
	
	remove_from_group("CompassTargets")

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
	Game.addShake(12)
