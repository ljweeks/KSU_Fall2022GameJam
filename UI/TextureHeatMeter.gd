extends Control

onready var textureProgress = $TextureProgress
onready var Game = get_node("/root/Game")

func _process(delta):
	textureProgress.material.set_shader_param("heat", (textureProgress.value/textureProgress.max_value) * 2 - 1)
	if Game != null:
		textureProgress.value = Game.overload

