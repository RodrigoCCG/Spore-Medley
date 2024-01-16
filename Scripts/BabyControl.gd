extends CharacterBody2D

var HORIZONTAL_SPEED = 0.0
var HORIZONTAL_SPEED_CAP = 650.0
var JUMP_SPEED = -750.0
var ACCELERATION = 1.5
var DECCELETATION = .3
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y += JUMP_SPEED
	var direction = Input.get_axis("ui_left","ui_right")
	if direction:
		"""if is_on_floor():
			if direction * HORIZONTAL_SPEED < HORIZONTAL_SPEED_CAP:
				if HORIZONTAL_SPEED * direction < 0:
					HORIZONTAL_SPEED = 10 * direction * -1
				HORIZONTAL_SPEED += direction * ACCELERATION * HORIZONTAL_SPEED_CAP * delta
		else:
			"""
		HORIZONTAL_SPEED = direction * ACCELERATION * HORIZONTAL_SPEED_CAP
		velocity.x =  HORIZONTAL_SPEED
	else:
		if HORIZONTAL_SPEED < 10 and HORIZONTAL_SPEED > -10 : HORIZONTAL_SPEED = 0
		else: HORIZONTAL_SPEED *= DECCELETATION * delta
		velocity.x =  HORIZONTAL_SPEED		
	move_and_slide()
