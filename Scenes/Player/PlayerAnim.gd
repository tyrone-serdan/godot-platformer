extends AnimatedSprite



func _on_Player_animate(playerVec, onFloor):
	
	if onFloor:
		if playerVec.x > 0:
			play("Walk")
			flip_h = false
		elif playerVec.x < 0:
			play("Walk")
			flip_h = true
		else:
			play("Idle")
	if playerVec.y < 0:
		play("Jump")

