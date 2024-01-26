extends TileMap

var flip_timer = 5.0
var flip_cells
var flip_next = true
@export var source_layer :int
@onready var baby :CharacterBody2D= get_parent().get_parent().get_child(0)

# Called when the node enters the scene tree for the first time.
func _ready():
	flip_cells = get_used_cells(1)
	for cell in flip_cells:
		set_cell(1,cell,source_layer,Vector2i(3,0))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("flute") and baby.is_on_floor() and baby.HAS_FLUTE:
		if flip_next: flip_tiles()
	pass # Replace with function body.

func flip_tiles():
	for cell in flip_cells:
		set_cell(1,cell,source_layer,Vector2i(0,2))
	if get_tree() == null: return
	await get_tree().create_timer(1.0/2.0).timeout
	for cell in flip_cells:
		set_cell(1,cell,source_layer,Vector2i(1,2))
	if get_tree() == null: return
	await get_tree().create_timer(1.0/5.0).timeout
	flip_next = false
	for cell in flip_cells:
		set_cell(1,cell,source_layer,Vector2i(2,2))
	if get_tree() == null: return
	await get_tree().create_timer(flip_timer/3).timeout
	for cell in flip_cells:
		set_cell(1,cell,source_layer,Vector2i(1,2))
	if get_tree() == null: return
	await get_tree().create_timer(flip_timer/3).timeout
	for cell in flip_cells:
		set_cell(1,cell,source_layer,Vector2i(0,2))
	if get_tree() == null: return
	await get_tree().create_timer(flip_timer/3).timeout
	for cell in flip_cells:
		set_cell(1,cell,source_layer,Vector2i(3,0))
	flip_next = true

