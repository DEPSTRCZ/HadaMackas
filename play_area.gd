extends Node2D

const ColoredSprite = preload("res://colored_orb.tscn")

func _ready():
	fill_tilemap_circular()
	create_border_wall()
	
	for i in range(Global.max_orbs):
		spawn_orb(
			get_random_point_in_circle(Global.world_size.x/2-100),
			Global.orb_colors[randi_range(0,15)],
			randf_range(0.5,3)
		)		
	
func fill_tilemap_circular():
	var tile_size = 256
	var cols = int(Global.world_size.x / tile_size)+15
	var rows = int(Global.world_size.y / tile_size)+15
	var center = Vector2(cols / 2.0, rows / 2.0)
	var radius = min(cols, rows) / 2.0

	for x in range(cols):
		for y in range(rows):
			var dist = Vector2(x, y).distance_to(center)
			if dist < radius:
				# Offset tiles so (0,0) world = center of circle
				$TileMapLayer.set_cell(Vector2i(x - int(center.x), y - int(center.y)), 0, Vector2i(0, 0))

func create_border_wall():
	var tile_size = 256
	var cols = int(Global.world_size.x / tile_size)
	var rows = int(Global.world_size.y / tile_size)
	var radius_px = (min(cols, rows) / 2.0) * tile_size

	var static_body = StaticBody2D.new()
	static_body.position = Vector2.ZERO
	add_child(static_body)
	
	# Build a ring of small collision segments around the circle edge
	var segments = 64  # More = smoother border
	for i in range(segments):
		var angle_a = (float(i) / segments) * TAU
		var angle_b = (float(i + 1) / segments) * TAU
		
		var collision = CollisionShape2D.new()
		var segment = SegmentShape2D.new()
		segment.a = Vector2(cos(angle_a), sin(angle_a)) * radius_px
		segment.b = Vector2(cos(angle_b), sin(angle_b)) * radius_px
		collision.shape = segment
		static_body.add_child(collision)
		static_body.add_to_group("border")

	# Visual (colored border)
	var line = Line2D.new()
	line.width = 5
	line.default_color = Color.RED

	var points = []
	var color_segments = 64
	for i in range(color_segments + 1):
		var angle = TAU * i / color_segments
		points.append(Vector2(cos(angle), sin(angle)) * radius_px)

	line.points = points
	static_body.add_child(line)
	

func spawn_orb(pos: Vector2, color: Color,size: float) -> void:
	var s : ColoredSprite = ColoredSprite.instantiate()
	add_child(s)
	s.position = pos
	s.set_color(color)
	s.scale = Vector2(size, size)

func get_random_point_in_circle(radius):
	var angle = randf_range(0, TAU)
	var r = sqrt(randf()) * radius
	return Vector2(cos(angle), sin(angle)) * r
	
	
