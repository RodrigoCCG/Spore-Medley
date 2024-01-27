extends Control
@onready var Act1 = preload("res://Stages/Act1/LVB1.tscn")
@onready var Act2 = preload("res://Stages/Act2/Act2.tscn")
@onready var Act3 = preload("res://Stages/Act3/Act3.tscn")
@onready var Act4 = preload("res://Stages/Act4/Act4.tscn")
@onready var Act5 = preload("res://Stages/Act5/Act5.tscn")
@onready var mainmenu_c_layer = $mainmenuCLayer
@onready var actselect_c_layer = $actselectCLayer


func _on_start_pressed():
	mainmenu_c_layer.visible = false
	actselect_c_layer.visible = true

func _on_options_pressed():
	$InputControl.visible = !$InputControl.visible
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit() 
	pass # Replace with function body.



func _on_start_act_1_pressed():
	$Camera2D.enabled = false
	var level_instance = Act1.instantiate()
	get_tree().get_root().add_child(level_instance)
	get_parent().game_started = true
	queue_free()

func _on_start_act_2_pressed():
	$Camera2D.enabled = false
	var level_instance = Act2.instantiate()
	get_tree().get_root().add_child(level_instance)
	get_parent().game_started = true
	queue_free()

func _on_start_act_3_pressed():
	$Camera2D.enabled = false
	var level_instance = Act3.instantiate()
	get_tree().get_root().add_child(level_instance)
	get_parent().game_started = true
	queue_free()

func _on_start_act_4_pressed():
	$Camera2D.enabled = false
	var level_instance = Act4.instantiate()
	get_tree().get_root().add_child(level_instance)
	get_parent().game_started = true
	queue_free()

func _on_start_act_5_pressed():
	$Camera2D.enabled = false
	var level_instance = Act5.instantiate()
	get_tree().get_root().add_child(level_instance)
	get_parent().game_started = true
	queue_free()

func _on_return_pressed():
	mainmenu_c_layer.visible = true
	actselect_c_layer.visible = false
