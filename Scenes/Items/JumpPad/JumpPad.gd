extends Area2D


signal animate

func padEntered(player:Node):
	emit_signal("animate")

	player.boost()