# overworld.md

extends Node2D


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		# Get cell at "Base Layer" of TileMap
		var source_id = $TileMap.get_cell_source_id(1, get_map_position())

		# Use "wood_hoe" to make "farmland_dry"
		if Global.selected_item == "wood_hoe":
			if (source_id == 2 					# Source ID 2: "grass"
			or source_id == 8): 				# Source ID 8: "grass_path"
				$TileMap/player/dig_grass.play()
				set_cell(1, 21) 				# Source ID 21: "farmland_dry"
		
		# Use "wood_shovel" to make "grass_path"
		if Global.selected_item == "wood_shovel":
			if(source_id == 2 					# Source ID 2: "grass"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				$TileMap/player/step_grass.play()
				set_cell(1, 8) 					# Source ID 8: "grass_path"
		
		# Use "seeds_wheat" on "farmland_(dry/wet)" to plant "wheat"
		if Global.selected_item == "seeds_wheat":
			if(source_id == 20 					# Source ID 20: "farmland_wet"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				$TileMap/player/step_grass.play()
				set_cell(2, 22) 				# Source ID 22: "wheat"
				take_item("seeds_wheat")
		
		# Use "sapling_oak" on grass/path/farmland to plant "sapling_oak"
		if Global.selected_item == "sapling_oak":
			if(source_id == 2 					# Source ID 2: "grass",
			or source_id == 8 					# Source ID 8: "grass_path"
			or source_id == 20 					# Source ID 20: "farmland_wet"
			or source_id == 21): 				# Source ID 21: "farmland_dry"
				$TileMap/player/step_grass.play()
				set_cell(2, 9) 					# Source ID 9: "sappling_oak"
				take_item("sapling_oak")
		
		# Use "cobblestone" to place "cobblestone"
		if Global.selected_item == "cobblestone":
			$TileMap/player/step_stone.play()
			set_cell(2, 0) 						# Source ID 0: "cobblestone"
			take_item("cobblestone")
		
		# Use "log_oak" to place "log_oak"
		if Global.selected_item == "log_oak":
			$TileMap/player/step_wood.play()
			set_cell(2, 5) 						# Source ID 5: "log_oak"
			take_item("log_oak")
		
		# Use "log_oak_top" to place "log_oak_top"
		if Global.selected_item == "log_oak_top":
			$TileMap/player/step_wood.play()
			set_cell(2, 6) 						# Source ID 6: "log_oak_top"
			take_item("log_oak_top")
		
		# Use "planks_oak" to place "planks_oak"
		if Global.selected_item == "planks_oak":
			$TileMap/player/step_wood.play()
			set_cell(2, 7) 					# Source ID 7: "planks_oak"
			take_item("planks_oak")
	
	var inventory_visible = $TileMap/player/hud/Slots.visible
	if event.is_action_pressed("ui_select") and inventory_visible == false:
		# Get cell at "Breakable Layer" of TileMap
		var source_id = $TileMap.get_cell_source_id(2, get_map_position())
		
		# Pick up "(double/tall)_grass" and add "seeds_wheat" to inventory
		if (source_id == 10						# Source ID : "double_grass"
		or source_id == 11):					# Source ID : "tall_grass"
			$TileMap/player/strong1.stop()
			$TileMap/player/pop.play()
			$TileMap.erase_cell(2, get_map_position())
			give_item("seeds_wheat", 64)
		
		# Pick up "sappling_oak" and add to inventory
		if source_id == 9: 						# Source ID 9: "sappling_oak"
			$TileMap/player/strong1.stop()
			$TileMap/player/pop.play()
			$TileMap.erase_cell(2, get_map_position())
			give_item("sapling_oak", 64)
		
		# Pick up "wheat_7" and add "wheat" to inventory
		if source_id == 23: 					# Source ID 23: "wheat_7"
			$TileMap/player/strong1.stop()
			$TileMap/player/pop.play()
			$TileMap.erase_cell(2, get_map_position())
			give_item("wheat", 1)
		
		# Use "wood_axe" to cut "log_oak", "log_oak_top", and "planks_oak"
		if Global.selected_item == "wood_axe":
			# Check to the right, if facing right
			if Global.last_direction == Vector2.RIGHT:
				var tile_to_right = get_map_position(Vector2(16,0))
				var right_source_id = $TileMap.get_cell_source_id(2, tile_to_right)
				if (right_source_id == 5): 		# Source ID 5: "log_oak"
					$TileMap/player/strong1.stop()
					$TileMap/player/dig_wood.play()
					$TileMap.erase_cell(2, tile_to_right)
					give_item("log_oak", 64)
				elif (right_source_id == 6): 	# Source ID 6: "log_oak_top"
					$TileMap/player/strong1.stop()
					$TileMap/player/dig_wood.play()
					$TileMap.erase_cell(2, tile_to_right)
					give_item("log_oak_top", 64)
				elif (right_source_id == 7): 	# Source ID 7: "planks_oak"
					$TileMap/player/strong1.stop()
					$TileMap/player/dig_wood.play()
					$TileMap.erase_cell(2, tile_to_right)
					give_item("planks_oak", 64)
			# Check to the left, if facing left
			else:
				var tile_to_left = get_map_position(Vector2(-16,0))
				var left_source_id = $TileMap.get_cell_source_id(2, tile_to_left)
				if (left_source_id == 5): 		# Source ID 5: "log_oak"
					$TileMap/player/strong1.stop()
					$TileMap/player/dig_wood.play()
					$TileMap.erase_cell(2, tile_to_left)
					give_item("log_oak", 64)
				elif (left_source_id == 6): 	# Source ID 6: "log_oak_top"
					$TileMap/player/strong1.stop()
					$TileMap/player/dig_wood.play()
					$TileMap.erase_cell(2, tile_to_left)
					give_item("log_oak_top", 64)
				elif (left_source_id == 7): 	# Source ID 7: "planks_oak"
					$TileMap/player/strong1.stop()
					$TileMap/player/dig_wood.play()
					$TileMap.erase_cell(2, tile_to_left)
					give_item("planks_oak", 64)
		# Use "wood_pickaxe" to mine "cobblestone" and "stone"
		if Global.selected_item == "wood_pickaxe":
			# Check to the right, if facing right
			if Global.last_direction == Vector2.RIGHT:
				var tile_to_right = get_map_position(Vector2(16,0))
				var right_source_id = $TileMap.get_cell_source_id(2, tile_to_right)
				if (right_source_id == 0 		# Source ID 0: "cobblestone"
				or right_source_id == 18): 		# Source ID 18: "stone"
					$TileMap/player/strong1.stop()
					$TileMap/player/dig_stone.play()
					$TileMap.erase_cell(2, tile_to_right)
					give_item("cobblestone", 64)
			# Check to the left, if facing left
			else:
				var tile_to_left = get_map_position(Vector2(-16,0))
				var left_source_id = $TileMap.get_cell_source_id(2, tile_to_left)
				if (left_source_id == 0 		# Source ID 0: "cobblestone"
				or left_source_id == 18): 		# Source ID 18: "stone"
					$TileMap/player/strong1.stop()
					$TileMap/player/dig_stone.play()
					$TileMap.erase_cell(2, tile_to_left)
					give_item("cobblestone", 64)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.


func _physics_process(delta):
	# Check if player has fallen into the void
	var tilemap = $TileMap
	var source_id_layer_0 = tilemap.get_cell_source_id(0, get_map_position())
	var source_id_layer_1 = tilemap.get_cell_source_id(1, get_map_position())
	var source_id_layer_2 = tilemap.get_cell_source_id(2, get_map_position())
	if (source_id_layer_0 == -1
		and source_id_layer_1 == -1
		and source_id_layer_2 == -1):
			Global.is_falling = true
	else:
		Global.is_falling = false


# Gets the player's current map position
func get_map_position(offset=Vector2(0,0)):
	var player = $TileMap/player
	var tilemap = $TileMap
	var player_position = player.position + offset
	var map_position = tilemap.local_to_map(player_position)
	return map_position


# Adds the item to the player's inventory.
func give_item(item_name, stack_size = 1):
	var item = {}
	item.id = item_name
	item.stack_size = stack_size
	item.quantity = 1
	item.texture = "res://textures/" + item_name + ".png"
	Global.add_item_to_inventory(item)
	# Update the UI
	var hud_node = $TileMap/player/hud
	hud_node.show_actionbar_items()
	hud_node.show_inventory_items()


# Removes the item from the player's inventory
func take_item(item_name):
	Global.remove_item_from_inventory(item_name)
	# Update the UI
	var hud_node = $TileMap/player/hud
	hud_node.show_actionbar_items()
	hud_node.show_inventory_items()


# Set the tile at the player's position.
func set_cell(layer, source_id):
	var map_position = get_map_position()
	$TileMap.set_cell(layer, map_position, source_id, Vector2i(0, 0), 0)
