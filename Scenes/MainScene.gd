extends Node2D

@onready var main_menu = preload("res://Scenes/Main_Menu/main_menu.tscn")
	
func instantiate_menu(): add_child(main_menu.instantiate())
