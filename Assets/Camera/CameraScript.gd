extends Node
const CAM_OFFSET_MAX = 150
const CAM_OFFSET_SPEED = 10
const DEFAULT_OFFSET = -175
const HOZ_OFFSET = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	self.offset.y = DEFAULT_OFFSET
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction_vertical = Input.get_axis("ui_up","ui_down")
	if direction_vertical:
		if abs(self.offset.y - DEFAULT_OFFSET) < CAM_OFFSET_MAX: 
			self.offset.y += CAM_OFFSET_SPEED * direction_vertical
	else:
		if self.offset.y > DEFAULT_OFFSET+1 or self.offset.y < DEFAULT_OFFSET-1: 
			self.offset.y += (DEFAULT_OFFSET-self.offset.y)*(0.1)
	var direction_horizontal = Input.get_axis("ui_left","ui_right")
	if direction_horizontal:
		if direction_horizontal * self.offset.x < HOZ_OFFSET:
			self.offset.x += direction_horizontal * abs(self.offset.x -(direction_horizontal * HOZ_OFFSET) )*(0.1)
		
