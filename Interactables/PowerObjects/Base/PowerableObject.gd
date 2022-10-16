extends Area2D
class_name PowerableObject


var powered = false

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var objects = get_overlapping_areas()
	var hit = false
	for b in objects:
		if b is PowerArea and b.providingPower:
			hit = true
			break;
	powered = hit
