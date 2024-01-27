extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Press "+ (InputMap.action_get_events("shoot")[0].as_text())+" to Shoot hook"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
