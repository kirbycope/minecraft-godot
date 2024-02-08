extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		var player = $TileMap/player
		var tilemap = $TileMap
		var player_position = player.position
		var map_position = tilemap.local_to_map(player_position)
		var tile_id = tilemap.get_cell_source_id(1, map_position)
		if (tile_id == 0):
			print("cobblestone")
		elif (tile_id == 1):
			print("dirt")
		elif (tile_id == 2):
			print("grass")
		elif (tile_id == 3):
			print("grass_side")
		elif (tile_id == 4):
			print("bedrock")
		elif (tile_id == 5):
			print("log_oak")
		elif (tile_id == 6):
			print("oak_log_top")
		elif (tile_id == 7):
			print("planks_oak")
		elif (tile_id == 8):
			print("grass_path")
		elif (tile_id == 9):
			print("sappling_oak")
		elif (tile_id == 10):
			print("double_grass")
		elif (tile_id == 11):
			print("tall_grass")
		elif (tile_id == 12):
			print("chest")
		elif (tile_id == 13):
			print("bed_feet")
		elif (tile_id == 14):
			print("bed_head")
		elif (tile_id == 15):
			print("leaves_oak")
		elif (tile_id == 16):
			print("flower_rose_red")
		elif (tile_id == 17):
			print("flower_rose_blue")
		elif (tile_id == 19):
			print("crafting_table")
		elif (tile_id == 20):
			print("farmland_wet")
		elif (tile_id == 21):
			print("farmland_dry")
		elif (tile_id == 22):
			print("wheat_1")
		elif (tile_id == 23):
			print("wheat_7")
		elif (tile_id == 24):
			print("water")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
