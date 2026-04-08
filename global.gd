# global.gd
extends Node

var world_size: Vector2 = Vector2(4000, 4000)
var world_center: Vector2 = world_size / 2.0  # Vector2(20000, 20000)

var orb_colors = [
	Color(1.0, 0.0, 0.6),   # neon pink
	Color(1.0, 0.2, 0.0),   # neon orange-red
	Color(1.0, 0.5, 0.0),   # neon orange
	Color(1.0, 1.0, 0.0),   # neon yellow
	Color(0.6, 1.0, 0.0),   # lime
	Color(0.0, 1.0, 0.0),   # neon green
	Color(0.0, 1.0, 0.5),   # green-cyan
	Color(0.0, 1.0, 1.0),   # neon cyan
	Color(0.0, 0.6, 1.0),   # sky neon blue
	Color(0.0, 0.3, 1.0),   # deep neon blue
	Color(0.3, 0.0, 1.0),   # indigo
	Color(0.6, 0.0, 1.0),   # neon purple
	Color(0.8, 0.0, 1.0),   # violet
	Color(1.0, 0.0, 1.0),   # neon magenta
	Color(1.0, 0.0, 0.3),   # hot pink
	Color(0.2, 1.0, 0.8)    # aqua neon
]

var max_orbs = 200
var max_orbs_xp = 30

var score = 0 # Keep zero
