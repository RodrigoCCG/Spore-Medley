extends TileMap

var flip_timer = 5.0
var flip_cells
var flip_next = true

# Called when the node enters the scene tree for the first time.
func _ready():
	flip_cells = get_used_cells(1)
	for cell in flip_cells:
		set_cell(1,cell,1,Vector2i(1,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if flip_next: flip_tiles()
	pass

func flip_tiles():
	flip_next = false
	await get_tree().create_timer(flip_timer).timeout
	for cell in flip_cells:
		set_cell(1,cell,1,Vector2i(1,0))
	await get_tree().create_timer(flip_timer).timeout
	for cell in flip_cells:
		set_cell(1,cell,1,Vector2i(1,1))
	flip_next = true
