extends RigidBody2D
class_name PlugEnd

var plugged = false setget on_plug

func on_plug(new_value):
	if (new_value):
		#set_mode(RigidBody2D.MODE_CHARACTER)
		pass
	else:
		#set_mode(RigidBody2D.MODE_RIGID)
		pass
	plugged = new_value
