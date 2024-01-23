extends TileMap

var flip_timer = 5.0
var flip_cells
var flip_next = true

# Called when the node enters the scene tree for the first time.
func _ready():
	flip_cells = get_used_cells(1)
	for cell in flip_cells:
		set_cell(1,cell,1,Vector2i(2,1))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func flip_tiles():
	flip_next = false
	for cell in flip_cells:
		set_cell(1,cell,1,Vector2i(2,2))
	await get_tree().create_timer(flip_timer/3).timeout
	for cell in flip_cells:
		set_cell(1,cell,1,Vector2i(1,2))
	await get_tree().create_timer(flip_timer/3).timeout
	for cell in flip_cells:
		set_cell(1,cell,1,Vector2i(0,2))
	await get_tree().create_timer(flip_timer/3).timeout
	for cell in flip_cells:
		set_cell(1,cell,1,Vector2i(0,2),1)
	flip_next = true


func _on_baby_flip_platforms():
	if flip_next: flip_tiles()
	pass # Replace with function body.
