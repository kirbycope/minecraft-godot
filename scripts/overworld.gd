extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tilemap = $TileMap
	var tileset = tilemap.get_tileset()
	var patterns = tileset.get_patterns_count()
	print(patterns)
	# Works - Removes a cell at a given location
	#tilemap.erase_cell(1, Vector2i(-1,-1))
	var thing1 = tilemap.get_cell_tile_data(1, Vector2i(-1,-1))
	print(thing1)
	pass
