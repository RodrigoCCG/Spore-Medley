extends Node2D
@onready var room_array = [

	preload("res://Stages/LVBatch1/Rooms/lvb_1r_1.tscn"),
	preload("res://Stages/LVBatch1/Rooms/lvb_1r_2.tscn"),
	preload("res://Stages/LVBatch1/Rooms/lvb_1npc.tscn"),
	preload("res://Stages/LVBatch1/Rooms/tester.tscn")
]

@onready var baby = $Baby
var level_entry :Area2D
var level_exit :Area2D
var current_room: Node2D
var can_enter = true

func _ready():
	for room in room_array:
		room_array[room_array.find(room)] = room.instantiate()
	current_room = room_array[0]
	add_child(current_room)
	level_entry = current_room.get_node("Entry")
	level_entry.body_entered.connect(entered_entry)
	level_exit = current_room.get_node("Exit")
	level_exit.body_entered.connect(entered_exit)
	baby.position = level_entry.global_position+Vector2(100,0)
	baby.HAS_FLUTE = false
	baby.HAS_TUBA = false
	baby.HAS_CYMBAL = false
	baby.HAS_GUITAR = false



func entered_exit(_body):
	print("Touching Exit")
	call_deferred("load_room", +1)

func entered_entry(_body):
	print("Touching Entrance")
	call_deferred("load_room", -1)

func load_room(which):
	if !can_enter : return
	can_enter = false
	if room_array.find(current_room)+which < 0:
		baby.position = level_entry.global_position
		can_enter = true
		return
	var next_room = room_array[room_array.find(current_room)+which]
	remove_child(current_room)
	print("Current Room"+current_room.name)
	add_child(next_room)
	print("Next Room"+next_room.name)
	
	level_entry = next_room.get_node("Entry")
	level_entry.body_entered.connect(entered_entry)
	level_exit = next_room.get_node("Exit")
	level_exit.body_entered.connect(entered_exit)
	current_room = next_room
	call_deferred("positioner")

func positioner(which, _body):
	if which > 0:
		baby.position = level_entry.global_position
		print("Entry of "+level_entry.get_parent().name)
	elif which < 0:
		print("Exit of of "+level_exit.get_parent().name)
		baby.position = level_exit.global_position
	can_enter = true
