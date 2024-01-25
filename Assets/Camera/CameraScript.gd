extends Camera2D
const CAM_OFFSET_MAX = 150 * 0.75
const CAM_OFFSET_SPEED = 10 * 0.75
const DEFAULT_OFFSET = -300 * 0.75
const HOZ_OFFSET = 30 * 0.75
var DIRECTION = 1
var CAMERA_ZOOM = 0.55
@onready var baby = $".."


# Called when the node enters the scene tree for the first time.
func _ready():
	self.offset.y = DEFAULT_OFFSET
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var zoom_multi = get_window().size.y * CAMERA_ZOOM/1080.0
	set_zoom(Vector2i(1,1)*zoom_multi)
	var direction_vertical = Input.get_axis("up","down")
	if direction_vertical:
		if abs(self.offset.y - DEFAULT_OFFSET) < CAM_OFFSET_MAX: 
			self.offset.y += CAM_OFFSET_SPEED * direction_vertical
	else:
		if self.offset.y > DEFAULT_OFFSET+1 or self.offset.y < DEFAULT_OFFSET-1: 
			self.offset.y += (DEFAULT_OFFSET-self.offset.y)*(0.08)
	var direction_horizontal = Input.get_axis("left","right")
	if direction_horizontal:
		if direction_horizontal * self.offset.x < HOZ_OFFSET:
			self.offset.x += direction_horizontal * abs(self.offset.x -(direction_horizontal * HOZ_OFFSET) )*(0.1)
	else:
		if self.offset.x > +1 or self.offset.x < -1: 
			self.offset.x += (0-self.offset.x)*(0.05)
	
