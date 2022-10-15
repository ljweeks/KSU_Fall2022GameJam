extends Node2D
class_name BatteryHolder


export var battery: NodePath
onready var powerArea = $PowerArea

# Called when the node enters the scene tree for the first time.
func _ready():
	if !battery.is_empty():
		addBattery($battery)
		
func removeBattery():
	var curBattery = $battery as Battery
	if curBattery is Battery:
		curBattery.mode = RigidBody2D.MODE_RIGID
		battery = NodePath()
		$PowerArea.providingPower = false
		get_tree().root.add_child(curBattery)

func addBattery(newBattery):
	if newBattery is Battery:
		removeBattery()
		add_child(newBattery)
		battery = newBattery.get_path()
		newBattery.mode = RigidBody2D.MODE_STATIC
		newBattery.position = $AttachPoint.position
		newBattery.rotation = $AttachPoint.rotation
		$PowerArea.providingPower = true


func _on_BatteryGrabArea_body_entered(body):
	if body is Battery and battery.is_empty():
		addBattery(body)
