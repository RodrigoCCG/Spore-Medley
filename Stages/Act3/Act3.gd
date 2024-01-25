extends Node2D
@onready var room_array = [
	preload("res://Stages/Act3/Rooms/sampleroom.tscn")
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
	baby.HAS_FLUTE = true
	baby.HAS_TUBA = true
	baby.HAS_CYMBAL = false
	baby.HAS_GUITAR = false
	
	
func _physics_process(_delta):
	if can_enter:
		if level_exit.overlaps_body(baby):
			print("Touching Exit")
			load_room(+1)

		#elif level_entry.overlaps_body(baby):
		#	print("Touching Entrance")
		#	load_room(-1)


func load_room(which):
	if !can_enter : return
	can_enter = false
	if room_array.find(current_room)+which < 0: 
		can_enter = true
		return
	var next_room = room_array[room_array.find(current_room)+which]
	print("Current Room"+current_room.name)
	add_child(next_room)
	print("Next Room"+next_room.name)
	level_entry  = next_room.get_node("Entry")
	level_exit = next_room.get_node("Exit")
	if which < 0: positioner(level_exit)
	if which > 0: positioner(level_entry)
	can_enter = true
	current_room = next_room

func positioner(where):
	baby.global_position = where.global_position
