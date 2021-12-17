extends CanvasLayer

onready var player = get_parent()
var pHealth
var pCoins

signal updateText

func _process(_delta):
	pHealth = player.get("HEALTH")
	pCoins = 0
	emit_signal("updateText", pHealth, pCoins)
