extends Node2D
@onready var room_1 = $Room1
@onready var room_2 = $Room2
@onready var room_3 = $Room3
@onready var baby = $Baby
@onready var r_1_entry = $Room1/R1Entry

func _ready():
	remove_child(room_2)
	remove_child(room_3)
	baby.position = r_1_entry.position


func _physics_process(_delta):
	load_room()
	

func load_room():
	pass



<<<<<<< Updated upstream:Stages/LVBatch1/LVB1.gd
func _on_r_1_exit_area_entered(_area):
	queue_free()
=======
func _on_r_1_exit_area_entered(area):
	remove_child(room_1)
	add_child(room_2)
	baby.position = r_2
>>>>>>> Stashed changes:Leveldesign/LVBatch1/LVB1.gd
