extends KinematicBody2D

#onready var anim = $PlayerAnim

var playerVec = Vector2.ZERO

var GRAVITY # = DATA[1]["GRAVITY"]
var UP # = DATA[1]["UP"]
var SPEED # = DATA[0]["SPEED"]
var JUMP # = DATA[0]["JUMP"]
var WORLD_LIMIT
var HEALTH
var BOOST

var easyModeVals = [15, 700]
var amountJumped = 0
var recentlyHurt = false

var globalVars 
var playerVars

signal animate
signal playSound

func _ready():
	# Id put this in a func but im lazy
	globalVars = getFromJSON("res://Scenes/global.json")
	playerVars = getFromJSON("res://Scenes/Player/Player.json")

	JUMP = playerVars.jump
	SPEED = playerVars.speed
	HEALTH = playerVars.health
	BOOST = playerVars.boost

	UP = Vector2(globalVars.upX, globalVars.upY)
	GRAVITY = globalVars.gravity
	WORLD_LIMIT = globalVars.world_limit

func getFromJSON(jsonFile):
	var file = File.new()
	file.open(jsonFile, file.READ)

	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func _physics_process(_delta):

	checkGameOver()
	playerMovement()
	animate()
	playerVec = move_and_slide(playerVec, UP)


func playerMovement():
	# apply gravity here
	playerVec.y += GRAVITY

	# is la double jump code
	if is_on_floor(): 
		amountJumped = 0

	if Input.is_action_just_pressed("jump") and amountJumped < 2 and recentlyHurt == false:
		emit_signal("playSound", false)
		amountJumped += 1
		position.y -= 5
		yield(get_tree(), "idle_frame")

		playerVec.y -= JUMP

	playerVec.x = Input.get_action_strength("move_left") * SPEED - Input.get_action_strength("move_right") * SPEED

func checkGameOver():
	if position.y > WORLD_LIMIT or HEALTH == 0:
		var _successChange = get_tree().change_scene("res://Scenes/Misc/GameOver.tscn")
	

func hurtPlayer():
	
	HEALTH -= 1
	if HEALTH == 0: return

	emit_signal("playSound", true)

	# stops that weird gravity thingy pulling our jumps down
	position.y -= 1
	yield(get_tree(), "idle_frame")

	playerVec.y -= JUMP
	amountJumped += 1
	recentlyHurt = true

	yield(get_tree().create_timer(0.2), "timeout")
	recentlyHurt = false

func boost():
	playerVec.y -= BOOST



func animate():
	emit_signal("animate", playerVec, is_on_floor())
	

