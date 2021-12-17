extends Node2D

onready var player = $Player

var pHealth
var pCoordY
var wLimit


func _process(_float):
	pHealth = player.HEALTH
	pCoordY = player.position.y
	wLimit = player.WORLD_LIMIT


	if pHealth == 0 or pCoordY > wLimit:
		var _successChange = get_tree().change_scene("res://Scenes/Misc/GameOver/GameOver.tscn")
