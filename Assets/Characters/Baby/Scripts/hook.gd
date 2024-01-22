"""
This script controls the chain.
Modified Hook Demo by OptionalDev
Git: https://gitlab.com/godotdemos/hook-demo
"""
extends Node2D

var links # A slightly easier reference to the links
var tip_body	# A slightly easier reference to the Hook Tip
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip_pos := Vector2(0,0)			# The global position the tip should be in
var rope_length = 0
								# We use an extra var for this, because the chain is 
								# connected to the player and thus all .position
								# properties would get messed with when the player
								# moves.
var side = 0
const SPEED = 1500	# The speed with which the chain moves

var flying = false	# Whether the chain is moving through the air
var hooked = false	# Whether the chain has connected to a wall

func _ready():
	links = $Links
	tip_body = $Tip

# shoot() shoots the chain in a given direction
func shoot(start_side) -> void:
	side = start_side
	direction = Vector2(side,-1)	# Normalize the direction and save it
	flying = true					# Keep track of our current scan
	tip_pos = self.global_position + Vector2(side * 200,0)# reset the tip position to the player's position

# release() the chain
func release() -> void:
	flying = false	# Not flying anymore	
	hooked = false	# Not attached anymore

# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	self.visible = flying or hooked	# Only visible if flying or attached to something
	if not self.visible:
		return	# Not visible -> nothing to draw
	var local_pos = to_local(tip_pos)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	links.rotation = self.position.angle_to_point(local_pos) + deg_to_rad(90)
	tip_body.rotation = self.position.angle_to_point(local_pos) + deg_to_rad(90)
	links.position = local_pos						# The links are moved to start at the tip
	links.region_rect.size.y = local_pos.length()		# and get extended for the distance between (0,0) and the tip

# Every physics frame we update the tip position
func _physics_process(delta: float) -> void:
	tip_body.global_position = tip_pos	# The player might have moved and thus updated the position of the tip -> reset it
	if flying:
		var tip_colision = tip_body.move_and_collide(direction * SPEED * delta)
		# `if move_and_collide()` always moves, but returns true if we did collide
		if tip_colision:
			if tip_colision.get_collider().name != "CharacterBody2D":
				print(tip_colision.get_collider().name)
				rope_length = tip_pos.distance_to(get_parent().global_position)
				print(rope_length)
				hooked = true	# Got something!
				flying = false	# Not flying anymore
		if (tip_body.global_position - tip_pos).length() > 1000: release()
	tip_pos = tip_body.global_position	# set `tip` as starting position for next frame
