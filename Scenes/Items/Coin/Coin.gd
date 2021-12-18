extends Node2D


signal play
signal animate

func playerEnter(_body:Node):
	get_tree().call_group("player", "coinCollect")
	emit_signal("play")
	emit_signal("animate")
