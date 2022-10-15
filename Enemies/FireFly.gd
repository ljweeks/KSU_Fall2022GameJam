extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 10
var target
export (float) var speed = 100
onready var nav = get_node("NavigationAgent2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer += 2
	collision_mask += 2
	contact_monitor = true;
	contacts_reported = 10000
	connect("body_entered", self, "collide")
	var targets = get_tree().get_nodes_in_group("EnemyTarget")
	if(targets.size() > 0):
		target = targets[rand_range(0, targets.size())]
		nav.set_target_location(target.global_position)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var moveTo = nav.get_next_location()
	var moveTarget = (moveTo - self.global_position).normalized()
	self.apply_central_impulse(moveTarget*speed)

func collide(body):
	if body is Fan:
		queue_free()

func damaged(amount):
	health -= amount
	if(health <=0):
		queue_free()
