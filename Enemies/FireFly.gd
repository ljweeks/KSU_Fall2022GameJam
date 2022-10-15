extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var target
export (float) var speed = 100
onready var nav = get_node("NavigationAgent2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	var targets = get_tree().get_nodes_in_group("EnemyTarget")
	if(targets.size() > 0):
		target = targets[rand_range(0, targets.size())]
		nav.set_target_location(target.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var moveTo = nav.get_next_location()
	var moveTarget = (moveTo - self.global_position).normalized()
	self.apply_central_impulse(moveTarget*speed)
