extends CharacterBody2D
@onready var animationbeta = $AnimatedSprite2D

#Movement Variables
var HORIZONTAL_SPEED_CAP = 650.0
var ACCELERATION = 1.5
var DECCELETATION = .3
var AIR_DECCELETATION = .01
var JUMP_SPEED = -900.0
#Gravity Variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_mod = 1.5
#Dash Variables
var LAST_DIRECTION = 1
var DASH_READY = true
const DASH_SPEED = 1200
const DASH_DURATION = 0.5
const DASH_COOLDOWN = 0.5
var DASHING = false
var WALLGRAB = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(delta):
	#Jump Controls
	if not is_on_floor():
		velocity.y += gravity_mod * gravity * delta
	if (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_Z)) and is_on_floor():
		velocity.y += JUMP_SPEED
	if is_on_wall() and !is_on_floor():
		player_walljump(delta)
	#Movement Controls
	var direction = Input.get_axis("ui_left","ui_right")
	if direction and !DASHING:
		if direction < 0:
			LAST_DIRECTION = -1
		elif direction > 0:
			LAST_DIRECTION = 1
		if direction * velocity.x < HORIZONTAL_SPEED_CAP:
			if velocity.x * direction < 0:
				velocity.x = 10 * direction * -1
			velocity.x += direction * ACCELERATION * HORIZONTAL_SPEED_CAP * delta
	else:
		if velocity.x < 10 and velocity.x > -10 : velocity.x = 0
		elif !DASHING: 
			if is_on_floor() :velocity.x *= (1-DECCELETATION)
			else :velocity.x *= (1-AIR_DECCELETATION)
	#Dash
	if DASH_READY and Input.is_key_pressed(KEY_X):
		player_dash(LAST_DIRECTION, delta)
		
	move_and_slide()
	handle_animation()
	

func player_dash(direction, delta):
	#Set Speed and Gravity to Dashing Motion
	velocity.x = DASH_SPEED * direction
	velocity.y = 0
	DASHING = true
	var old_gravity = gravity_mod
	gravity_mod = 0
	DASH_READY = false 
	#Dash Duration
	await get_tree().create_timer(DASH_DURATION).timeout
	gravity_mod = old_gravity
	velocity.x = HORIZONTAL_SPEED_CAP * LAST_DIRECTION
	DASHING = false
	#Dash Cooldown
	await get_tree().create_timer(DASH_COOLDOWN).timeout
	while !is_on_floor():
		await get_tree().create_timer(delta).timeout
	DASH_READY = true
	
func player_walljump(delta):
	if WALLGRAB: return
	else: WALLGRAB = true
	if (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_Z)): 
		WALLGRAB = false
		return
	while is_on_wall() and !is_on_floor():
		await get_tree().create_timer(delta).timeout
		if (Input.is_key_pressed(KEY_SPACE) or Input.is_key_pressed(KEY_Z)):
			velocity.y = JUMP_SPEED
			LAST_DIRECTION *= -1
			velocity.x = HORIZONTAL_SPEED_CAP * LAST_DIRECTION
			DASHING = true
			await get_tree().create_timer(0.5).timeout
			DASHING = false
	WALLGRAB = false

func handle_animation():
	if LAST_DIRECTION < 0:
		animationbeta.flip_h = true
	elif LAST_DIRECTION > 0:
		animationbeta.flip_h = false

	if velocity.x != 0 and is_on_floor():
		animationbeta.play("Walk")
	elif Input.is_action_just_pressed("ui_accept"):
		animationbeta.play("Jump")
	elif velocity.y > 0:
		animationbeta.play("Fall")
	elif velocity.y < 0:
		animationbeta.play("Rise")
	elif velocity.x == 0 and velocity.y == 0:
		animationbeta.play("Idle")

