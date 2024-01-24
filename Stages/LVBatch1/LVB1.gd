extends Node2D
@onready var room_array = [
	preload("res://Stages/LVBatch1/Rooms/lvb_1npc.tscn"),
	preload("res://Stages/LVBatch1/Rooms/lvb_1r_1.tscn"),
	preload("res://Stages/LVBatch1/Rooms/lvb_1r_2.tscn")
]
@onready var baby = $Baby
var level_entry :Area2D
var level_exit :Area2D
var current_room: Node2D
var can_enter = true

func _ready():
	for room in room_array:
		room_array[room_array.find(room)] = room.instantiate()
		
	for room in room_array:
		print(room.name)
	current_room = room_array[0]
	add_child(current_room)
	level_entry = current_room.get_node("Entry")
	level_exit = current_room.get_node("Exit")
	baby.position = level_entry.global_position+Vector2(100,0)
	baby.HAS_FLUTE = false
	baby.HAS_TUBA = false
	baby.HAS_CYMBAL = false
	baby.HAS_GUITAR = false

func _physics_process(delta):
	var is_touching_exit = level_exit.get_overlapping_bodies().find(baby) != -1
	var is_touching_entry = level_entry.get_overlapping_bodies().find(baby) != -1
	if is_touching_exit:
		if can_enter:
			print("Touching Exit")
			load_room(+1)
			await get_tree().create_timer(1.0/60.0).timeout
	elif is_touching_entry:
		if can_enter:
			print("Touching Entrance")
			load_room(-1)
			await get_tree().create_timer(1.0/60.0).timeout
	

func load_room(which):
	if !can_enter : return
	can_enter = false
	if room_array.find(current_room)+which < 0:
		baby.position = level_entry.global_position
		while level_entry.get_overlapping_bodies().find(baby) != -1: 
			print("me")
			await get_tree().create_timer(1.0/60.0).timeout
		can_enter = true
		return
	var next_room = room_array[room_array.find(current_room)+which]
	remove_child(current_room)
	print("Current Room"+current_room.name)
	add_child(next_room)
	print("Next Room"+next_room.name)
	
	level_entry = next_room.get_node("Entry")
	level_exit = next_room.get_node("Exit")
	current_room = next_room
	await get_tree().create_timer(1.0).timeout
	if which > 0:
		baby.position = level_entry.global_position
		print("Entry of "+level_entry.get_parent().name)
		while level_entry.get_overlapping_bodies().find(baby) != -1: 
			await get_tree().create_timer(1.0/60.0).timeout
	elif which < 0:
		print("Exit of of "+level_exit.get_parent().name)
		baby.position = level_exit.global_position
		while level_exit.get_overlapping_bodies().find(baby) != -1: 
			await get_tree().create_timer(1.0/60.0).timeout
	can_enter = true
	pass

