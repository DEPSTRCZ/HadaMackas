extends Node2D

@export var world_size: Vector2 = Vector2(40000, 40000)

func _ready():
	fill_tilemap()

func fill_tilemap():
	var tile_size = 256
	var cols = int(world_size.x / tile_size)
	var rows = int(world_size.y / tile_size)
	
	for x in range(cols):
		for y in range(rows):
			$TileMapLayer.set_cell(Vector2i(x, y), 0, Vector2i(0, 0))
