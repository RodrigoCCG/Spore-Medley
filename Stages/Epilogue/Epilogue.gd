extends Node2D
@onready var room_array = [
	preload("res://Stages/Epilogue/Rooms/Epilogue.tscn"),
]
var BGM = preload("res://Assets/Sound/BGM/MUSIC_LVLEND_LOOPED.ogg")
var Background = preload("res://Assets/Environment/Backgrounds/scene anyy_ background 3.png")
@onready var baby = $Baby
var level_entry :Node2D
var level_exit :Area2D
var current_room: Node2D
var can_enter = true
var current_level: = 0
func _ready(): 
	var BGSet = get_parent().get_child(0).get_child(1)
	current_room = room_array[0].instantiate()
	add_child(current_room)
	level_entry = current_room.get_node("Entry")
	level_exit = current_room.get_node("Exit")
	baby.position = level_entry.global_position
	baby.HAS_FLUTE = true
	baby.HAS_TUBA = true
	baby.HAS_CYMBAL = true
	baby.HAS_GUITAR = true
	baby.get_child(5).stream = BGM
	baby.get_child(5).play()
	var cam :Camera2D = baby.get_child(2)
	cam.limit_right = 5000
	BGSet.texture = Background
	
func _physics_process(_delta):
	if can_enter:
		if level_exit.overlaps_body(baby):
			can_enter = false
			baby.global_position = Vector2(-1000000000000,-100000000000000)
			current_level+=1
			print("Touching Exit of "+str(level_exit.get_parent().name))
			call_deferred("load_room",+1)
			baby.position = level_entry.position


func load_room(_which):
	get_tree().quit() 
