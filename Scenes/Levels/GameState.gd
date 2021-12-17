extends Node2D

var player

var pHealth
var pCoordY
var wLimit

func _ready():
	player = get_node("Player")

func _process(_float):
	pHealth = player.HEALTH
	pCoordY = player.position.y
	wLimit = player.WORLD_LIMIT


	if pHealth == 0 or pCoordY > wLimit:
		var _successChange = get_tree().change_scene("res://Scenes/Misc/GameOver/GameOver.tscn")
