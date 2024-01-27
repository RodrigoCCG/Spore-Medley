extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Press "+ (InputMap.action_get_events("flute")[0].as_text())+" to play flute"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
