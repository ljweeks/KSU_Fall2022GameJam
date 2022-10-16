extends Control


onready var compassHolder = $CompassHolder/Node2D
var compassPieceScene = preload("res://UI/CompassPiece.tscn")

var activePieces = {}


func _process(delta):
	
	var newTargets = get_tree().get_nodes_in_group("CompassTargets")
	for node in newTargets:
		if not activePieces.has(node):
			activePieces[node] = compassPieceScene.instance()
			compassHolder.add_child(activePieces[node])
			activePieces[node].global_position = compassHolder.global_position
	
	for node in activePieces.keys():
		if not node.is_in_group("CompassTargets"):
			activePieces[node].queue_free()
			activePieces.erase(node)
		else:
			activePieces[node].update_for_objective(node)
