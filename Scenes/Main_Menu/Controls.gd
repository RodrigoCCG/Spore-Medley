extends ItemList


# Called when the node enters the scene tree for the first time.
func _ready():
	load_keybinds()
	pass # Replace with function body.

func load_keybinds():
	for i in range(item_count): remove_item(0)
	for action in InputMap.get_actions():
		if action.split("_",true,1)[0] != "ui":
			add_item(action.to_upper()+ ": "+ InputMap.action_get_events(action)[0].as_text())
