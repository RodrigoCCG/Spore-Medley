extends Node2D

var R1loader = preload("res://Stages/LVBatch1/Rooms/lvb_1r_1.tscn")
var R2loader = preload("res://Stages/LVBatch1/Rooms/lvb_1r_2.tscn")
var RNPCloader = preload("res://Stages/LVBatch1/Rooms/lvb_1npc.tscn")

func _ready():
	var R1instance = R1loader.instantiate()
	add_child(R1instance)
	R1instance.LVB1_R1_Exit_Right.connect(room_1_exit_right)


func deferred_r1():
	var R1instance = R1loader.instantiate()
	R1instance.LVB1_R1_Exit_Right.connect(room_1_exit_right)
	add_child(R1instance)

func room_1_exit_right():
	call_deferred("deferred_r2")

func deferred_r2():
	var R2instance = R2loader.instantiate()
	R2instance.LVB1_R2_Exit_Left.connect(room_2_exit_left)
	R2instance.LVB1_R2_Exit_Up.connect(room_2_exit_up)
	R2instance.LVB1_R2_Exit_Right.connect(room_2_exit_right)
	add_child(R2instance)

func room_2_exit_right():
	call_deferred("deferred_rnpc")

func room_2_exit_left():
	call_deferred("deferred_r1")

func room_2_exit_up(): 
	queue_free()

func deferred_rnpc():
	var RNPCinstance = RNPCloader.instantiate()
	RNPCinstance.LVB1_RNPC_Exit_Left.connect(room_NPC_exit_left)
	add_child(RNPCinstance)

func room_NPC_exit_left():
	call_deferred("deferred_r2")
