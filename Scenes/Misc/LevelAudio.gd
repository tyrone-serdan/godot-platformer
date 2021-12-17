extends AudioStreamPlayer

var sp = load("res://SFX/Summer_Park.ogg")
var ca = load("res://SFX/Chiptune_Adventures_1.ogg")
var musicOptions = [sp,ca]
var randNum

func _ready():
	randomize()
	randNum = randi() % 2
	pickSong(randNum)


func pickSong(num):
	stream = musicOptions[num]
	autoplay = true
	volume_db = -13
	play()
