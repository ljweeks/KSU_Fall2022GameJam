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
		self.mass = 1000
		
		curColdTime += delta
	else:
		froze = false
		self.mass = startMass
		curColdTime = 0

func freeze():
	froze = true
