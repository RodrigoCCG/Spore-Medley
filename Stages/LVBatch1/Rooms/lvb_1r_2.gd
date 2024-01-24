extends Node2D
@onready var baby = $Baby
signal LVB1_R2_Exit_Left
signal LVB1_R2_Exit_Right
signal LVB1_R2_Exit_Up



func _on_r_2_exit_left_body_entered(_body):
	queue_free()
	emit_signal("LVB1_R2_Exit_Left")


func _on_r_2_exit_right_body_entered(_body):
	queue_free()
	emit_signal("LVB1_R2_Exit_Right")



func _on_r_2_exit_up_body_entered(_body):
	queue_free()
	emit_signal("LVB1_R2_Exit_Up")

