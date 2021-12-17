extends AudioStreamPlayer

var jump = load("res://SFX/jump1.ogg")
var pain = load("res://SFX/pain.ogg")

func playSound(gotHurt):
	if gotHurt: stream = pain
	else: stream = jump

	volume_db = -5
	play()



