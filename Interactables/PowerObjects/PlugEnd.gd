extends RigidBody2D
class_name PlugEnd

var plugged = false setget on_plug

func on_plug(new_value):
	$CollisionShape2D.disabled = not new_value
	if (new_value):
		$PlugSprite.visible = false
	else:
		$PlugSprite.visible = true
	plugged = new_value
