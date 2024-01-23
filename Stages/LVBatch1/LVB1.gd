extends Node2D
var room_array = []
@onready var baby = $Baby
var level_entry
var level_exit
var current_room: Node2D

func _ready():
	for i in range(1,len(get_children())):
		room_array.append(get_children()[i])
	for i in range(1,len(room_array)):
		remove_child(room_array[i])
	current_room = room_array[0]
	level_entry = current_room.get_node("Entry")
	level_exit = current_room.get_node("Exit")
	baby.position = level_entry.global_position+Vector2(100,0)
	baby.HAS_FLUTE = false
	baby.HAS_TUBA = false
	baby.HAS_CYMBAL = false
	baby.HAS_GUITAR = false

func _physics_process(_delta):
	if level_exit.get_overlapping_bodies().find(baby) != -1:
		load_room(+1)
	if level_entry.get_overlapping_bodies().find(baby) != -1:
		load_room(-1)
	

func load_room(which):
	if room_array.find(current_room)+which < 0:
		baby.position = level_entry.global_position+Vector2(100,0)
		return
	var next_room = room_array[room_array.find(current_room)+which]
	add_child(next_room)
	remove_child(current_room)
	current_room = next_room
	level_entry = current_room.get_node("Entry")
	level_exit = current_room.get_node("Exit")
	baby.position = level_entry.global_position+Vector2(100,0)
	pass


