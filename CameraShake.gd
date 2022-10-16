extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





var shake = 0;
var shakeAmount = 0;


 
func _physics_process(delta):
	if(shakeAmount > 0.2):
		shake()

func shake():
	self.set_offset(Vector2(rand_range(-1.0, 1.0) * shakeAmount, rand_range(-1.0, 1.0) * shakeAmount))
	shakeAmount *= 0.85
 
func addShake(amount):
	shakeAmount += amount

