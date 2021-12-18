extends CanvasLayer

onready var player = get_parent()
var pHealth
var pCoins

signal updateText

func _process(_delta):
	pHealth = player.get("HEALTH")
	pCoins = player.get("coinsCollected")
	emit_signal("updateText", pHealth, pCoins)
