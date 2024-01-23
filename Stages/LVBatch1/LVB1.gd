extends Node2D
@onready var room_1 = $Room1
@onready var room_2 = $Room2
@onready var room_3 = $Room3
@onready var baby = $Baby
var level_entry
var level_exit
var current_room: Node2D

func _ready():
	remove_child(room_2)
	remove_child(room_3)
	current_room = room_1
	level_entry = current_room.get_node("Entry")
	level_exit = current_room.get_node("Exit")
	baby.position = level_entry.global_position
	baby.HAS_FLUTE = false
	baby.HAS_TUBA = false
	baby.HAS_CYMBAL = false
	baby.HAS_GUITAR = false

func _physics_process(_delta):
	if level_exit.get_overlapping_bodies().find(baby) != -1:
		load_room()
	

func load_room():
	add_child(room_2)
	remove_child(current_room)
	current_room = room_2
	level_entry = current_room.get_node("Entry")
	level_exit = current_room.get_node("Exit")
	baby.position = level_entry.global_position
	pass



func _on_r_1_exit_area_entered(_area):
	queue_free()
