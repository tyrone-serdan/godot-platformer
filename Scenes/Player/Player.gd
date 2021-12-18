extends KinematicBody2D

var playerVec = Vector2.ZERO

var GRAVITY = 80
var UP = Vector2(0,-1)

var SPEED = -1000
var JUMP = 1750
var WORLD_LIMIT = 4000
var HEALTH = 3
var BOOST = 2500

var easyModeVals = [15, 700]
var recentlyHurt = false
var amountJumped = 0
var coinsCollected = 0

signal animate
signal playSound

func _physics_process(_delta):
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

func coinCollect():
	coinsCollected += 1

func animate():
	emit_signal("animate", playerVec, is_on_floor())
	

