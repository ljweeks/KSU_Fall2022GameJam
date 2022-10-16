extends Node2D


onready var rot_node = $Node2D
onready var compass_sprite = $Node2D/CompassPiece
onready var plr = get_node("/root/Game/YSort/Player")

func update_for_objective(node):
	var heat = -1
	var plrDiff = (node.global_position - plr.global_position)
	var dist = plrDiff.length()
	
	if node.get("thisHeat"):
		heat = node.thisHeat
	
	var weight = clamp(500 - dist, 100, 500)/100
	
	rot_node.look_at(global_position + plrDiff.normalized())
	
	# rot_node.visible = dist < 1
	compass_sprite.modulate = Color.red.linear_interpolate(Color(0.4, 0.4, 1), 1 - heat/3)
	compass_sprite.modulate.a = clamp(1 - weight/5, 0.2, 1) - 0.2
	if heat <= 0:
		compass_sprite.modulate.a *= 0.5
	compass_sprite.scale = Vector2.ONE * (weight)
	
