extends TextEdit
@onready var input_box = get_parent()
var last_input
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_input_control_item_clicked(index, _at_position, _mouse_button_index):
	visible = true
	var action = input_box.get_item_text(index).split(":")[0].to_lower()
	var current_input : InputEvent = InputMap.action_get_events(action)[0]
	text = "Press ESC to cancel.\nPress a Key to Reassign: " + action.to_upper()
	while Input.is_anything_pressed(): await get_tree().create_timer(1.0/60.0).timeout
	while !Input.is_anything_pressed(): 
		await get_tree().create_timer(1.0/60.0).timeout
	var e = last_input
	if e.keycode == KEY_ESCAPE: 
		visible = false
		return
	InputMap.action_erase_event(action, current_input)
	InputMap.action_add_event(action, e)
	visible = false
	get_parent().load_keybinds()
	pass 
	
func _input(event):
	last_input = event
		
