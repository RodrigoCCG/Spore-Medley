extends Node2D
@onready var beethoven = $Beethoven
@onready var camera_2d = $Camera2D
@onready var textbox = $Textbox
@onready var beethovnimations = $Beethoven/Beethovnimations

@onready var Conversation = [
	preload("res://Assets/Characters/Dialogue/Beethoven/beethoven_textbox_1.png"),
	preload("res://Assets/Characters/Dialogue/Beethoven/beethoven_textbox_2.png"),
	preload("res://Assets/Characters/Dialogue/baby_textbox_newnimproved.png"),
	preload("res://Assets/Characters/Dialogue/Beethoven/beethoven_textbox_3.png"),
	preload("res://Assets/Characters/Dialogue/Beethoven/beethoven_textbox_4.png"),
	preload("res://Assets/Characters/Dialogue/Beethoven/beethoven_textbox_5.png"),
	preload("res://Assets/Characters/Dialogue/Beethoven/beethoven_textbox_6.png")
]
var dialogue_index = 0
var RockingchairRotationDisplacement = 3
var animationcounter: int
var beethoven_talkable = false

func _physics_process(_delta):
	chair_rocking()
	if Input.is_action_just_pressed("talk") and beethoven_talkable == true:
		beethoven_talk()
	handle_beethoven_animations()
	if dialogue_index == 7:
		get_parent().get_parent().get_child(0).HAS_FLUTE = true

func handle_beethoven_animations():
	if dialogue_index == 1 or dialogue_index == 2:
		beethovnimations.play("talking")
	elif dialogue_index > 3 and  beethoven_talkable:
		beethovnimations.play("talking")
	else:
		beethovnimations.play("default")

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
	textbox.visible = true
	if dialogue_index == 0: textbox.visible = true
	if dialogue_index == len(Conversation): 
		textbox.visible = false
		beethovnimations.play("default")
		dialogue_index = 0
		return
	textbox.texture = Conversation[dialogue_index]
	dialogue_index += 1

func _on_area_2d_body_entered(_body):
	camera_2d.enabled = true
	get_parent().get_parent().get_child(0).get_child(2).enabled = false
	beethoven_talkable = true

func _on_area_2d_body_exited(_body):
	camera_2d.enabled = false
	get_parent().get_parent().get_child(0).get_child(2).enabled = true
	beethoven_talkable = false
	textbox.visible = false
