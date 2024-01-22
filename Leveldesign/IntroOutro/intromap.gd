extends Node2D
var load_baby = preload("res://Assets/Baby/Baby.tscn")

func _ready():
	var baby_instance = load_baby.instantiate()
	add_child(baby_instance)

func _physics_process(_delta):
	load_room()
	

func load_room():
	pass
