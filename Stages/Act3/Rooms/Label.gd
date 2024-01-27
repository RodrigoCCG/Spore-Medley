extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "In the air, press "+ (InputMap.action_get_events("jump")[0].as_text())+" against a wall to wall Jump"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
