extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		# Get cell at "Base Layer" of TileMap
		var source_id = get_cell_source_id(1)
		
		# Use "wood_hoe" to make "farmland_dry"
		if Global.selected_item == "wood_hoe":
			if (source_id == 2 					# Source ID 2: "grass"
			or source_id == 8): 				# Source ID 8: "grass_path"
				set_cell(1, 21) 				# Source ID 21: "farmland_dry"
		
		# Use "wood_shovel" to make "grass_path"
		if Global.selected_item == "wood_shovel":
			if(source_id == 2 					# Source ID 2: "grass"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				set_cell(1, 8) 					# Source ID 8: "grass_path"
		
		# Use "seeds_wheat" on "farmland_(dry/wet)" to plant "wheat"
		if Global.selected_item == "seeds_wheat":
			if(source_id == 20 					# Source ID 20: "farmland_wet"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				set_cell(2, 22) 				# Source ID 22: "wheat"
		
		# Use "sapling_oak" on grass/path/farmland to plant "sapling_oak"
		if Global.selected_item == "sapling_oak":
			if(source_id == 2 					# Source ID 2: "grass",
			or source_id == 8 					# Source ID 8: "grass_path"
			or source_id == 20 					# Source ID 20: "farmland_wet"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				set_cell(2, 9) 					# Source ID 9: "sappling_oak"
		
	if event.is_action_pressed("ui_select"):
		# Get cell at "Breakable Layer" of TileMap
		var source_id = get_cell_source_id(2)
		if source_id == 9: # Source ID 9: "sappling_oak"
			$TileMap.erase_cell(2, get_map_position())
			give_item("sapling_oak")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Gets the player's current map position
func get_map_position():
	var player = $TileMap/player
	var tilemap = $TileMap
	var player_position = player.position
	var map_position = tilemap.local_to_map(player_position)
	return map_position


# Get the ID of the cell the player is standing on (see TileMap > TileSet > Tiles).
func get_cell_source_id(layer):
	return $TileMap.get_cell_source_id(layer, get_map_position())


# Get the friendly name of the given tile Source ID.
func get_tile_name(source_id):
	if (source_id == 0):
		return "cobblestone"
	elif (source_id == 1):
		return "dirt"
	elif (source_id == 2):
		return "grass"
	elif (source_id == 3):
		return "grass_side"
	elif (source_id == 4):
		return "bedrock"
	elif (source_id == 5):
		return "log_oak"
	elif (source_id == 6):
		return "oak_log_top"
	elif (source_id == 7):
		return "planks_oak"
	elif (source_id == 8):
		return "grass_path"
	elif (source_id == 9):
		return "sappling_oak"
	elif (source_id == 10):
		return "double_grass"
	elif (source_id == 11):
		return "tall_grass"
	elif (source_id == 12):
		return "chest"
	elif (source_id == 13):
		return "bed_feet"
	elif (source_id == 14):
		return "bed_head"
	elif (source_id == 15):
		return "leaves_oak"
	elif (source_id == 16):
		return "flower_rose_red"
	elif (source_id == 17):
		return "flower_rose_blue"
	elif (source_id == 19):
		return "crafting_table"
	elif (source_id == 20):
		return "farmland_wet"
	elif (source_id == 21):
		return "farmland_dry"
	elif (source_id == 22):
		return "wheat_1"
	elif (source_id == 23):
		return "wheat_7"
	elif (source_id == 24):
		return "water"


func give_item(item_name):
	var item = {}
	item.id = item_name
	item.texture = "res://textures/" + item_name + ".png"
	Global.add_item_to_inventory(item)
	# Update the UI
	var hud_node = $TileMap/player/hud
	hud_node.show_actionbar_items()
	hud_node.show_crafting_table_items()
	hud_node.show_inventory_items()
	hud_node.show_single_chest_items()


# Set the tile at the player's position.
func set_cell(layer, source_id):
	var map_position = get_map_position()
	$TileMap.set_cell(layer, map_position, source_id, Vector2i(0, 0), 0)
	if source_id == 21:
		$TileMap/player/dig_grass.play()
	elif source_id == 8:
		$TileMap/player/step_grass.play()
