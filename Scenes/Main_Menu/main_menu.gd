extends Control
@onready var Act1 = preload("res://Stages/LVBatch1/LVB1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	$Camera2D.enabled = false
	var level_instance = Act1.instantiate()
	get_tree().get_root().add_child(level_instance)
	get_parent().remove_child(self)
	pass # Replace with function body.

func _on_options_pressed():
	$InputControl.visible = !$InputControl.visible
	pass # Replace with function body.
	
func _on_exit_pressed():
	get_tree().quit() 
	pass # Replace with function body.




