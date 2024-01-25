extends CharacterBody2D
@onready var animationbeta = $AnimatedSprite2D
@onready var sfx_bus = $SFX_Player
@onready var bgm_bus = $BGM_Player

#Movement Variables
@export var Spawn: int
var LAST_DIRECTION = 1
var HORIZONTAL_SPEED_CAP = 650.0
var ACCELERATION = 1.5
var DECCELETATION = 0.9
var AIR_DECCELETATION = .3
var JUMP_SPEED = -1100.0
var WAS_Falling
#Gravity Variables
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_mod = 1.5
#Dash Variables
var DASH_READY = true
const DASH_SPEED = 1200
const DASH_DURATION = 0.5
const DASH_COOLDOWN = 0.5
const DASH_DECCELERATION = 0.3
var DASHING = false
var WALL_JUMP = false
#Hook Variables
@onready var HOOK = $Hook
#Inventory
@export var HAS_FLUTE: bool
@export var HAS_TUBA: bool
@export var HAS_CYMBAL: bool
@export var HAS_GUITAR: bool
var FLUTE_COOLDOWN = false
#Platform Flipping
signal flip_platforms



func _physics_process(delta):
	if velocity.x < 0:
		LAST_DIRECTION = -1
	elif velocity.x > 0:
		LAST_DIRECTION = 1
	#Movement Controls
	var direction = Input.get_axis("left","right")
	player_movement(direction,delta)
	#Jump Controls
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += JUMP_SPEED
	if Input.is_action_just_pressed("flute") and is_on_floor():
		play_flute()
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
			sfx_bus.play_hook()
			HOOK.shoot(LAST_DIRECTION)
		if Input.is_action_just_released("shoot"):
			HOOK.release()
	if HOOK.hooked:
		hooked_movement(delta)
	#Base Movement Physics
	move_and_slide()
	#Animation
	handle_animation()

func play_flute():
	sfx_bus.play_flute()
	emit_signal("flip_platforms")
	pass

func hooked_movement(delta):
	#Get Hook Position and Rope Length
	var hook_pos = HOOK.tip_pos
	var rope_len = HOOK.rope_length
	var radius : Vector2 = global_position - hook_pos
	#Stop motion on rope too short
	if velocity.length() < 0.01 or radius.length() < 10: return
	#Calculate velocity added by swing
	var angle = acos(radius.dot(velocity) / (radius.length() * velocity.length()))
	var rad_vel = cos(angle) * velocity.length()
	velocity += radius.normalized() * -rad_vel
	#Stop player from pulling away from rope
	if global_position.distance_to(hook_pos) > rope_len : 
		global_position = hook_pos + radius.normalized() * (rope_len*1.1)
	#Swing player
	velocity += (hook_pos - global_position).normalized() * 15000 * delta
	pass

func player_movement(direction,delta):
	#Check for input
	if direction != 0 and !DASHING:
		#Movement based on input
		if direction * velocity.x < HORIZONTAL_SPEED_CAP:
			if velocity.x * direction < 0:
				velocity.x = 10 * direction * -1
			velocity.x += direction * ACCELERATION * HORIZONTAL_SPEED_CAP * delta
		#Decelerate Gradually
		elif direction * velocity.x > HORIZONTAL_SPEED_CAP and direction * LAST_DIRECTION > 0:
			velocity.x *= (1-(DASH_DECCELERATION * delta))
		else : velocity.x = HORIZONTAL_SPEED_CAP * direction
	else:
		#Movement with no input
		if !is_on_floor() :velocity.x *= (1-(AIR_DECCELETATION * delta)) #Air deceleration
		elif !DASHING and velocity.x * LAST_DIRECTION > HORIZONTAL_SPEED_CAP: velocity.x *= (1-(DECCELETATION * delta)) #Ground Deceleration
		elif !DASHING: velocity.x = 0 #Full Stop

func player_dash(direction):
	#Set Speed and Gravity to Dashing Motion
	sfx_bus.play_dash()
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
	#Move player up and away from wall
	velocity.y = JUMP_SPEED
	velocity.x = HORIZONTAL_SPEED_CAP * -LAST_DIRECTION
	#Remove player control
	DASHING = true
	await get_tree().create_timer(0.05).timeout
	#Wait until player has touched wall or started falling
	while velocity.y < 0:
		if is_on_wall():
			break
		if is_on_floor():
			DASHING = false
		await get_tree().create_timer(1.0/60.0).timeout
	#Return control to player
	DASHING = false

var animation_lock = false
func handle_animation():
	#Face Left and Right, remember last direction faced
	if velocity.x < 0:
		animationbeta.flip_h = true
	elif velocity.x > 0:
		animationbeta.flip_h = false
	else : animationbeta.flip_h = LAST_DIRECTION < 0
	#Animation cycles
	if !animation_lock:
		if velocity.x != 0 and is_on_floor():
			animationbeta.play("Walk")
		elif Input.is_action_just_pressed("jump"):
			animationbeta.play("Jump")
		elif velocity.y > 0:
			animationbeta.play("Fall")
		elif velocity.y < 0:
			animationbeta.play("Rise")
		elif velocity.x == 0 and velocity.y == 0:
			animationbeta.play("Idle")
		elif velocity.x == 0 and velocity.y == 0:
			animationbeta.play("Idle")
	
	
	if Input.is_action_just_pressed("flute") and HAS_FLUTE:
		animationbeta.play("Flute")
		animation_lock = true
	if Input.is_action_pressed("shoot") and HAS_GUITAR:
		if HOOK.hooked:
			animationbeta.play("Swing")
	
	if Input.is_action_just_pressed("shoot") and HAS_GUITAR:
		animationbeta.play("Guitar")
		animation_lock = true
	elif Input.is_action_pressed("shoot") and HAS_GUITAR and !animation_lock:
		animationbeta.play("Swing")
		animation_lock = true
	if Input.is_action_just_released("shoot"):
		animation_lock = false
	if Input.is_action_just_pressed("dash") and HAS_TUBA:
		animationbeta.play("Dash")
		animation_lock = true
		while animation_lock: await get_tree().create_timer(1.0/60.0).timeout
		animation_lock = true
		animationbeta.play("Dashing")
		await get_tree().create_timer(DASH_DURATION).timeout
		animation_lock = false



func _on_animated_sprite_2d_animation_finished():
	animation_lock = false
	pass # Replace with function body.
