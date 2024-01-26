extends Node2D
@onready var beethoven = $Beethoven
@onready var camera_2d = $Camera2D
var RockingchairRotationDisplacement = 3
var animationcounter: int
var beethoven_talkable = false

func _physics_process(_delta):
	chair_rocking()
	if Input.is_action_just_pressed("up") and beethoven_talkable == true:
		beethoven_talk()

func chair_rocking():
	animationcounter = animationcounter + 1
	if animationcounter == 20:
		beethoven.rotation = deg_to_rad(-15)
		beethoven.position.x = beethoven.position.x - RockingchairRotationDisplacement
	elif animationcounter == 60:
		beethoven.rotation = deg_to_rad(-10)
		beethoven.position.x = beethoven.position.x + RockingchairRotationDisplacement
	elif animationcounter == 80:
		beethoven.rotation = deg_to_rad(-5)
		beethoven.position.x = beethoven.position.x + RockingchairRotationDisplacement
	elif animationcounter == 160:
		beethoven.rotation = deg_to_rad(0)
		beethoven.position.x = beethoven.position.x + RockingchairRotationDisplacement
	elif animationcounter == 190:
		beethoven.rotation = deg_to_rad(-5)
		beethoven.position.x = beethoven.position.x - RockingchairRotationDisplacement
	elif animationcounter == 200:
		beethoven.rotation = deg_to_rad(-10)
		beethoven.position.x = beethoven.position.x - RockingchairRotationDisplacement
		animationcounter = 0

func beethoven_talk():
	pass

func _on_area_2d_body_entered(_body):
	camera_2d.enabled = true
	get_parent().get_parent().get_child(0).get_child(2).enabled = false
	beethoven_talkable = true

func _on_area_2d_body_exited(_body):
	camera_2d.enabled = false
	get_parent().get_parent().get_child(0).get_child(2).enabled = true
	beethoven_talkable = false
