extends KinematicBody2D

#onready var anim = $PlayerAnim

var playerVec = Vector2.ZERO

# const DATA = [{"SPEED": -1000, "JUMP": 1750}, {"UP": Vector2(0,-1), "GRAVITY": 80}]

var GRAVITY # = DATA[1]["GRAVITY"]
var UP # = DATA[1]["UP"]
var SPEED # = DATA[0]["SPEED"]
var JUMP # = DATA[0]["JUMP"]
var WORLD_LIMIT
var HEALTH

var easyModeVals = [15, 700]
var amountJumped = 0
var recentlyHurt = false

signal animate

func _ready():
	# Id put this in a func but im lazy
	var globalVars = getFromJSON("res://Scenes/global.json")
	var playerVars = getFromJSON("res://Scenes/Player/Player.json")

	JUMP = playerVars.jump
	SPEED = playerVars.speed
	HEALTH = playerVars.health

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
	checkCollisions()

func checkCollisions():
	for i in get_slide_count():
		var collName = get_slide_collision(i).collider.name
		if collName == "TileMap":
			pass
		else:
			print(str(collName))


func playerMovement():
	# apply gravity here
	playerVec.y += GRAVITY

	# is la double jump code
	if is_on_floor(): 
		amountJumped = 0

	if Input.is_action_just_pressed("jump") and amountJumped < 2 and recentlyHurt == false:
		print('jumping! ' + str(amountJumped))
		playerVec.y -= JUMP
		amountJumped += 1

	playerVec.x = Input.get_action_strength("move_left") * SPEED - Input.get_action_strength("move_right") * SPEED

func checkGameOver():
	if position.y > WORLD_LIMIT or HEALTH == 0:
		var _successChange = get_tree().change_scene("res://Scenes/Misc/GameOver.tscn")

func hurtPlayer():
	# stops that weird gravity thingy pulling our jumps down
	position.y -= 1
	yield(get_tree(), "idle_frame")


	playerVec.y -= JUMP * 1
	recentlyHurt = true
	HEALTH -= 1
	yield(get_tree().create_timer(1.0), "timeout")
	recentlyHurt = false



func animate():
	emit_signal("animate", playerVec, is_on_floor())
	

