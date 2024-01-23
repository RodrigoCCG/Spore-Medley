extends AudioStreamPlayer
var flute_sounds = []
var dash_sounds = []
var walljump_sounds = []
var hook_sounds = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,23):
		flute_sounds.append("res://Assets/Sound/SFX/Gameplay/Playing Flute/Playing_Flute_"+str(i+1)+".ogg")

	for i in range(0,17):
		dash_sounds.append("res://Assets/Sound/SFX/Gameplay/Dash/Dash_"+str(i+1)+".wav")
	
	for i in range(0,1):
		walljump_sounds.append("res://Assets/Sound/SFX/Gameplay/Arrival on a plateform/Normal_Plateform_Arrival_9.ogg")
		#walljump_sounds.append("res://Assets/Sound/SFX/Gameplay/Dash/Dash_"+str(i+1)+".wav")
	
	for i in range(0,9):
		hook_sounds.append("res://Assets/Sound/SFX/Gameplay/Grappling Hook/GRAPPLING_HOOK_"+str(i+1)+".ogg")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func play_jump():
	pass

func play_walk():
	pass

func play_dash():
	var sound = randi_range(0,len(dash_sounds)-1)
	stream = load(dash_sounds[sound])
	play()
	pass
	
func play_hook():
	var sound = randi_range(0,len(hook_sounds)-1)
	stream = load(hook_sounds[sound])
	play()
	pass
	
func play_walljump():
	var sound = randi_range(0,len(walljump_sounds)-1)
	stream = load(walljump_sounds[sound])
	play()
	pass
	
func play_flute():
	var sound = randi_range(0,len(flute_sounds)-1)
	stream = load(flute_sounds[sound])
	play()
	await get_tree().create_timer(1).timeout
	pass
