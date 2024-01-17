extends CharacterBody2D
@onready var animationbeta = $AnimatedSprite2D

var HORIZONTAL_SPEED = 0.0
var HORIZONTAL_SPEED_CAP = 650.0
var JUMP_SPEED = -900.0
var ACCELERATION = 1.5
var DECCELETATION = .3
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_mod = 1.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity_mod * gravity * delta
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y += JUMP_SPEED
	var direction = Input.get_axis("ui_left","ui_right")
	if direction:
		if direction * HORIZONTAL_SPEED < HORIZONTAL_SPEED_CAP:
			if HORIZONTAL_SPEED * direction < 0:
				HORIZONTAL_SPEED = 10 * direction * -1
			HORIZONTAL_SPEED += direction * ACCELERATION * HORIZONTAL_SPEED_CAP * delta
		velocity.x =  HORIZONTAL_SPEED
	else:
		if HORIZONTAL_SPEED < 10 and HORIZONTAL_SPEED > -10 : HORIZONTAL_SPEED = 0
		else: HORIZONTAL_SPEED *= DECCELETATION * delta
		velocity.x =  HORIZONTAL_SPEED
	move_and_slide()
	handle_animation()

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

