extends AudioStreamPlayer
var flute_sounds = []
var dash_sounds = []
var walljump_sounds = []
var hook_sounds = []
var step_sounds = []
var was_step = false
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0,5):
		flute_sounds.append("res://Assets/Sound/SFX/Gameplay/Playing Flute/Playing_Flute_"+str(i+1)+".ogg")

	for i in range(0,5):
		dash_sounds.append("res://Assets/Sound/SFX/Gameplay/Dash/Dash_"+str(i+1)+".wav")
	
	for i in range(0,5):
		walljump_sounds.append("res://Assets/Sound/SFX/WallJump/PSGJ_WALLJUMP_v2_"+str(i+1)+".ogg")
		#walljump_sounds.append("res://Assets/Sound/SFX/Gameplay/Dash/Dash_"+str(i+1)+".wav")
	
	for i in range(0,5):
		hook_sounds.append("res://Assets/Sound/SFX/Gameplay/Grappling Hook/GRAPPLING_HOOK_"+str(i+1)+".ogg")
	
	for i in range(0,8):
		step_sounds.append("res://Assets/Sound/SFX/Footsteps/Dirt/FTS_D_"+str(i+1)+".ogg")
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
	volume_db = 0.0
	play()
	was_step = false
	pass
	
func play_hook():
	var sound = randi_range(0,len(hook_sounds)-1)
	stream = load(hook_sounds[sound])
	volume_db = 0.0
	play()
	was_step = false
	pass
	
func play_walljump():
	var sound = randi_range(0,len(walljump_sounds)-1)
	stream = load(walljump_sounds[sound])
	volume_db = 0.0
	play()
	was_step = false
	pass
	
func play_flute():
	var sound = randi_range(0,len(flute_sounds)-1)
	stream = load(flute_sounds[sound])
	volume_db = 0.0
	play()
	was_step = false
	await get_tree().create_timer(1).timeout
	pass

func play_steps():
	if (get_playback_position() > 0.4 and was_step) or !playing:
		var sound = randi_range(0,len(step_sounds)-1)
		stream = load(step_sounds[sound])
		volume_db = -10
		was_step = true
		play()
	
