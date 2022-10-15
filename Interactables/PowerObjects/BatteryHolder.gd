extends Node2D
class_name BatteryHolder


onready var powerArea = $PowerArea

var myBattery

# Called when the node enters the scene tree for the first time.
func _ready():
	$AttachPoint/BatterySprite.visible = false
		
func removeBattery():
	if myBattery is Battery:
		
		$BatteryGrabArea/CollisionShape2D.disabled = true
		
		myBattery.mode = RigidBody2D.MODE_RIGID
		$PowerArea.providingPower = false
		$AttachPoint/BatterySprite.visible = false
		# myBattery.get_parent().remove_child(myBattery)
		get_parent().add_child(myBattery)
		myBattery.position = position + $AttachPoint.position
		myBattery = null
		
		yield(get_tree().create_timer(1), "timeout")
		$BatteryGrabArea/CollisionShape2D.disabled = false

func addBattery(newBattery):
	if myBattery != null:
		return
	
	if newBattery is Battery:
		myBattery = newBattery
		newBattery.get_parent().remove_child(newBattery)
		$AttachPoint/BatterySprite.visible = true
		# add_child(newBattery)
		newBattery.set_mode(RigidBody2D.MODE_KINEMATIC)
		newBattery.position = $AttachPoint.position
		newBattery.rotation = $AttachPoint.rotation
		newBattery.sleeping = true
		$PowerArea.providingPower = true
		
		#yield(get_tree().create_timer(1.0), "timeout")
		#removeBattery()


func _on_BatteryGrabArea_body_entered(body):
	if body is Battery:
		addBattery(body)


func _on_EnemyTarget_enemy_hit():
	if (myBattery):
		var lastBattery = myBattery
		removeBattery()
		lastBattery.queue_free()
