extends Area2D
class_name PowerArea

export var providingPower = true
export (int) var size = 100

func _ready():
	#$CollisionShape2D.shape.Radius = size
	pass
