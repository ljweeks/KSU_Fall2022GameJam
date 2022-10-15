extends Area2D
class_name PowerArea
export var providingPower = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var objects = get_overlapping_bodies()
	for b in objects:
		if b is PowerableObject:
			b.powered = true
	


func _on_PowerArea_body_entered(body):
	if body is PowerableObject:
		body.powered = true


func _on_PowerArea_body_exited(body):
	if body is PowerableObject:
		body.powered = false
