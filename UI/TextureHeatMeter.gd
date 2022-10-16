extends Control

onready var textureProgress = $TextureProgress
onready var Game = get_node("/root/Game")

onready var Music = get_node("/root/Game/Music")

var overload = false
var overloadTimer = 0.0
var postOverloadTimer = 0.5

func _ready():
	$OverloadLabel.visible = false

func _process(delta):
	textureProgress.material.set_shader_param("heat", (textureProgress.value/textureProgress.max_value) * 2 - 1)
	if Game != null:
		textureProgress.value = Game.overload
	
	if overload:
		overloadTimer += delta
		if fmod(overloadTimer, 1.0) < 0.5 and overloadTimer < 2:
			$OverloadLabel.visible = true
		else:
			$OverloadLabel.visible = false
	
	if postOverloadTimer > 0:
		postOverloadTimer -= delta
	
	if textureProgress.value > 80 and not overload:
		$AudioStreamPlayer.play()
		$OverloadLabel.visible = true
		overloadTimer = 0.0
		overload = true
		Music.pitch_scale = 1.2
	elif textureProgress.value <= 80 and overload and postOverloadTimer <= 0:
		$AudioStreamPlayer.stop()
		$OverloadLabel.visible = false
		postOverloadTimer = 1
		overload = false
		Music.pitch_scale = 1

