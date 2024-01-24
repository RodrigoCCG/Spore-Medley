extends Node2D
signal LVB1_R1_Exit_Right



func _on_r_1_exit_body_entered(_body):
	emit_signal("LVB1_R1_Exit_Right")
	queue_free()
