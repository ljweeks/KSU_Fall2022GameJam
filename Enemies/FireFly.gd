extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 10
var target
export (float) var speed = 100
onready var nav = get_node("NavigationAgent2D")
# Called when the node enters the scene tree for the first time.

func find_new_target():
	var targets = get_tree().get_nodes_in_group("EnemyTarget")
	if(targets.size() > 0):
		target = targets[rand_range(0, targets.size())]
		nav.set_target_location(target.global_position)

func _ready():
	#collision_layer 
	#collision_mask += 2
	contact_monitor = true;
	contacts_reported = 10000
	connect("body_entered", self, "collide")
	find_new_target()
		

var distanceToAttackFrom = rand_range(100,200)
var attackTime = 0
var attackSpeed = 2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var moveTo = nav.get_next_location()
	var distance = nav.distance_to_target()
	attackTime += delta
	if(distance < distanceToAttackFrom):
		if  attackTime > attackSpeed:
			attack()
			attackTime = 0
	else:
		var moveTarget = (moveTo - self.global_position).normalized()
		self.apply_central_impulse(moveTarget*speed)
	
	if target == null or not target.is_in_group("EnemyTarget"):
		find_new_target()
	
func collide(body):
	if body is Fan:
		if body.powered == true:
			queue_free()

var bulletSpeed = 200
func attack():
	
	var bullet = load("res://Enemies/enemyBullet.tscn").instance()
	get_parent().add_child(bullet)
	bullet.direction = (target.global_position - self.global_position).normalized()
	bullet.global_position = self.global_position + bullet.direction*100
	bullet.look_at(bullet.global_position + bullet.direction)
	bullet.apply_central_impulse(bullet.direction*bulletSpeed)
	self.apply_central_impulse(bullet.direction*-5000)


func damaged(amount):
	health -= amount
	if(health <=0):
		queue_free()
