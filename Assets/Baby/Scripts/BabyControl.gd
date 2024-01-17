extends CharacterBody2D
@onready var animationbeta = $AnimatedSprite2D

var HORIZONTAL_SPEED = 0.0
var HORIZONTAL_SPEED_CAP = 650.0
var JUMP_SPEED = -900.0
var ACCELERATION = 1.5
var DECCELETATION = .3
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_mod = 1.5
var LAST_DIRECTION = 1
var DASH_READY = true
const DASH_SPEED = 800
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
	#Movement Controls
	var direction = Input.get_axis("ui_left","ui_right")
	if direction:
		if direction < 0:
			LAST_DIRECTION = -1
		elif direction > 0:
			LAST_DIRECTION = 1
		if direction * HORIZONTAL_SPEED < HORIZONTAL_SPEED_CAP:
			if HORIZONTAL_SPEED * direction < 0:
				HORIZONTAL_SPEED = 10 * direction * -1
			HORIZONTAL_SPEED += direction * ACCELERATION * HORIZONTAL_SPEED_CAP * delta
		velocity.x =  HORIZONTAL_SPEED
	else:
		if HORIZONTAL_SPEED < 10 and HORIZONTAL_SPEED > -10 : HORIZONTAL_SPEED = 0
		else: HORIZONTAL_SPEED *= DECCELETATION * delta
		velocity.x =  HORIZONTAL_SPEED
	#Dash
	if DASH_READY and Input.is_key_pressed(KEY_X):
		player_dash()
		
	if is_on_floor() and !DASH_READY:
		DASH_READY = true
		
	move_and_slide()
	handle_animation()
	

func player_dash():
	var time = get_tree().create_timer(2.0)
	velocity.x = DASH_SPEED * LAST_DIRECTION
	velocity.y = 0
	

func handle_animation():
	if velocity.x < 0:
		animationbeta.flip_h = true
	elif HORIZONTAL_SPEED > 0:
		animationbeta.flip_h = false

	if HORIZONTAL_SPEED != 0 and is_on_floor():
		animationbeta.play("Walk")
	elif Input.is_action_just_pressed("ui_accept"):
		animationbeta.play("Jump")
	elif velocity.y > 0:
		animationbeta.play("Fall")
	elif velocity.y < 0:
		animationbeta.play("Rise")
	elif velocity.x == 0 and velocity.y == 0:
		animationbeta.play("Idle")

