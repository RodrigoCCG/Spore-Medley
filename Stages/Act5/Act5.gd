extends Node2D
@onready var room_array = [
	preload("res://Stages/Act5/Rooms/sampleroom.tscn")
]

@onready var baby = $Baby
var level_entry :Area2D
var level_exit :Area2D
var current_room: Node2D
var can_enter = true
var Background = preload("res://Assets/Environment/Backgrounds/scene anyy_ background 3.png")

func _ready():
	var BGSet = get_parent().get_child(0).get_child(0).get_child(2).get_child(0)
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
	baby.HAS_CYMBAL = true
	baby.HAS_GUITAR = true
	BGSet.texture = Background


func _physics_process(_delta):
	if can_enter:
		if level_exit.overlaps_body(baby):
			print("Touching Exit")
			load_room(+1)

		#elif level_entry.overlaps_body(baby):
		#	print("Touching Entrance")
		#	load_room(-1)


func load_room(which):
	var BGSet = get_parent().get_child(0).get_child(0).get_child(2).get_child(0)
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
	remove_child(current_room)
	if which < 0: positioner(level_exit, BGSet)
	if which > 0: positioner(level_entry, BGSet)
	can_enter = true
	current_room = next_room

func positioner(where, BGSet):
	baby.global_position = where.global_position
	BGSet.offset.y = BGSet.offset.y - 25
