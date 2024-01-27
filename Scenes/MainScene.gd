extends Node2D
@onready var sprite_2d = $Sprite2D
@onready var batch_bg = $BatchBG

@onready var main_menu = preload("res://Scenes/Main_Menu/main_menu.tscn")
@export var game_started: bool
func instantiate_menu(): add_child(main_menu.instantiate())

func _physics_process(delta):
	if game_started:
		var campos = get_parent().get_child(1).get_child(0).get_child(2).get_child(0).position
		sprite_2d.position = campos
		batch_bg.position = campos
