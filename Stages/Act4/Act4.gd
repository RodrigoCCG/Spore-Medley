extends Node2D
@onready var room_array = [
	preload("res://Stages/Act4/Rooms/Level4_1.tscn"),
	preload("res://Stages/Act4/Rooms/Level4_2.tscn"),
	preload("res://Stages/Act4/Rooms/Level4_3.tscn")
]

const next_act = "res://Stages/Act5/Act5.tscn"

@onready var baby = $Baby
var level_entry :Area2D
var level_exit :Area2D
var current_room: Node2D
var can_enter = true
var current_level: = 0
func _ready(): 
	current_room = room_array[0].instantiate()
	add_child(current_room)
	level_entry = current_room.get_node("Entry")
	level_exit = current_room.get_node("Exit")
	baby.position = level_entry.global_position+Vector2(100,0)
	baby.HAS_FLUTE = true
	baby.HAS_TUBA = true
	baby.HAS_CYMBAL = true
	baby.HAS_GUITAR = false
	
	
func _physics_process(_delta):
	if can_enter:
		if level_exit.overlaps_body(baby):
			can_enter = false
			baby.global_position = Vector2(-1000000000000,-100000000000000)
			current_level+=1
			print("Touching Exit of "+str(level_exit.get_parent().name))
			call_deferred("load_room",+1)
			baby.global_position = level_entry.global_position
	print(can_enter)
		#elif level_entry.overlaps_body(baby):
		#	print("Touching Entrance")
		#	load_room(-1)


func load_room(which):
	if current_level >= len(room_array):
		get_tree().get_root().add_child(preload(next_act).instantiate())
		queue_free()
		return
		
	var next_room = room_array[current_level].instantiate()
	
	print("Current Room"+current_room.name)
	print("Next Room"+next_room.name)
	
	level_entry = next_room.get_node("Entry")
	remove_child(current_room)
	current_room = next_room
	level_exit = next_room.get_node("Exit")
	add_child(next_room)
	await get_tree().create_timer(1).timeout
	can_enter = true

