extends CharacterBody2D
@onready var animationbeta = $AnimatedSprite2D

#Movement Variables
var HORIZONTAL_SPEED_CAP = 650.0
var ACCELERATION = 1.5
var DECCELETATION = 0.9
var AIR_DECCELETATION = .3
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
const DASH_DECCELERATION = 0.3
var DASHING = false
var WALL_JUMP = false
#Hook Variables
var HOOK
#Inventory
var HAS_FLUTE = true
var HAS_TUBA = true
var HAS_CYMBAL = true
var HAS_GUITAR = true

# Called when the node enters the scene tree for the first time.
func _ready():
	HOOK = $Hook
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func _physics_process(delta):
	if velocity.x < 0:
		LAST_DIRECTION = -1
	elif velocity.x > 0:
		LAST_DIRECTION = 1
	#Movement Controls
	var direction = Input.get_axis("ui_left","ui_right")
	player_movement(direction,delta)
	#Jump Controls
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += JUMP_SPEED
	#Stop player from Wall Jumping/Dashing simultaneously
	if !DASHING:
		#Wall Jump
			if HAS_CYMBAL and !is_on_floor() and is_on_wall():
				if Input.is_action_just_pressed("jump")and direction * LAST_DIRECTION > 0 :
					player_walljump()
		#Dash
			if HAS_TUBA and DASH_READY and Input.is_action_just_pressed("dash"):
				player_dash(LAST_DIRECTION)
	#Gravity
	if !is_on_floor():
		velocity.y += gravity_mod * gravity * delta
	#Hookshot
	if HAS_GUITAR and HOOK != null:
		if Input.is_action_just_pressed("shoot"):
			HOOK.shoot(LAST_DIRECTION)
		if Input.is_action_just_released("shoot"):
			HOOK.release()
	if HOOK.hooked:
		hooked_movement(delta)
	#Base Movement Physics
	move_and_slide()
	#Animation
	handle_animation()

func hooked_movement(delta):
	var hook_pos = HOOK.tip_pos
	var rope_len = HOOK.rope_length
	var radius : Vector2 = global_position - hook_pos
	print(radius)
	print(radius.length())
	if velocity.length() < 0.01 or radius.length() < 10: return
	var angle = acos(radius.dot(velocity) / (radius.length() * velocity.length()))
	var rad_vel = cos(angle) * velocity.length()
	velocity += radius.normalized() * -rad_vel
	
	if global_position.distance_to(hook_pos) > rope_len : 
		global_position = hook_pos + radius.normalized() * rope_len
	
	velocity += (hook_pos - global_position).normalized() * 15000 * delta
	print(velocity)
	pass

func player_movement(direction,delta):
	#
	if direction != 0 and !DASHING:
		if direction * velocity.x < HORIZONTAL_SPEED_CAP:
			if velocity.x * direction < 0:
				velocity.x = 10 * direction * -1
			velocity.x += direction * ACCELERATION * HORIZONTAL_SPEED_CAP * delta
		elif direction * velocity.x > HORIZONTAL_SPEED_CAP and direction * LAST_DIRECTION > 0:
			velocity.x *= (1-(DASH_DECCELERATION * delta))
		else : velocity.x = HORIZONTAL_SPEED_CAP * direction
	else:
		if !is_on_floor() :velocity.x *= (1-(AIR_DECCELETATION * delta))
		elif !DASHING and velocity.x * LAST_DIRECTION > HORIZONTAL_SPEED_CAP: velocity.x *= (1-(DECCELETATION * delta))
		elif !DASHING: velocity.x = 0

func player_dash(direction):
	#Set Speed and Gravity to Dashing Motion
	DASH_READY = false 
	DASHING = true
	velocity.x = DASH_SPEED * direction
	velocity.y = 0
	var old_gravity = gravity_mod
	gravity_mod = 0
	#Dash Duration
	await get_tree().create_timer(DASH_DURATION).timeout
	gravity_mod = old_gravity
	DASHING = false
	#Dash Cooldown
	await get_tree().create_timer(DASH_COOLDOWN).timeout
	while !is_on_floor():
		await get_tree().create_timer(1.0/60.0).timeout
	DASH_READY = true
	
func player_walljump():
	velocity.y = JUMP_SPEED
	velocity.x = HORIZONTAL_SPEED_CAP * -LAST_DIRECTION
	DASHING = true
	await get_tree().create_timer(0.05).timeout
	while velocity.y < 0:
		if is_on_wall():
			break
		if is_on_floor():
			DASHING = false
		await get_tree().create_timer(1.0/60.0).timeout
	DASHING = false

func handle_animation():
	if velocity.x < 0:
		animationbeta.flip_h = true
	elif velocity.x > 0:
		animationbeta.flip_h = false
	else : animationbeta.flip_h = LAST_DIRECTION < 0

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
