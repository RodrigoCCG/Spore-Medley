extends Node2D
var level_loader = preload("res://Leveldesign/LVBatch1/LVB1.tscn")

func _ready():
	var level_instance = level_loader.instantiate()
	add_child(level_instance)
