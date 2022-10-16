extends Area2D
class_name PowerArea

export var providingPower = true setget power_changed

func power_changed(new_val):
	if new_val:
		$PowerOn.play()
	else:
		$PowerDown.play()
		

func _ready():
	#$CollisionShape2D.shape.Radius = size
	pass
