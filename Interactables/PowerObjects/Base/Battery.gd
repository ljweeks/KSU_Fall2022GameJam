extends RigidBody2D
class_name Battery

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startMass

# Called when the node enters the scene tree for the first time.
func _ready():
	startMass = self.mass
	self.friction = 1

export (float) var coldTime = 5
var curColdTime = 0
var froze = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(froze and curColdTime<coldTime):
		self.mode = RigidBody2D.MODE_STATIC
		curColdTime += delta
	else:
		froze = false
		self.mode = RigidBody2D.MODE_RIGID
		curColdTime = 0

func freeze():
	pass
	#froze = true
