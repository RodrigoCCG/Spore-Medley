extends Node2D
@onready var room_array = [
	preload("res://Stages/Act3/Rooms/sampleroom.tscn")
]
var Background = preload("res://Assets/Environment/Backgrounds/Dscene BIRD_ background 1.png")
const next_act = "res://Stages/Act4/Act4.tscn"

@onready var baby = $Baby
var level_entry :Node2D
var level_exit :Area2D
var current_room: Node2D
var can_enter = true
var current_level: = 0
func _ready(): 
	var BGSet = get_parent().get_child(0).get_child(0).get_child(2).get_child(0)
	current_room = room_array[0].instantiate()
	add_child(current_room)
	level_entry = current_room.get_node("Entry")
	level_exit = current_room.get_node("Exit")
	baby.position = level_entry.position
	baby.HAS_FLUTE = true
	baby.HAS_TUBA = true
	baby.HAS_CYMBAL = true
	baby.HAS_GUITAR = false
	BGSet.texture = Background
	
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

func load_room(_which):
	var BGSet = get_parent().get_child(0).get_child(0).get_child(2).get_child(0)
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
	BGSet.offset.x = BGSet.offset.x - 150
	BGSet.offset.y = BGSet.offset.y - 25
	await get_tree().create_timer(1).timeout
	can_enter = true
