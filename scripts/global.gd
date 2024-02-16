# global.gd

extends Node


var day = true
var inventory = [null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null]
var is_falling = false
var last_direction = Vector2.RIGHT
var mobs_spawned_today = true
var player_can_move = true
var selected_item = ""
var time = 6
var time_of_day = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate time_scale based on desired cycle duration
	var time_scale = 24.0 / 300 # 300 Seconds == 5 minutes
	Global.time += delta * time_scale
	# Reset after completing a cycle
	if Global.time >= 24.0:
		Global.time = 0.0
		Global.mobs_spawned_today = false
	Global.time_of_day = fmod(Global.time, 24.0)
	if Global.time_of_day >= 6.0 and Global.time_of_day < 18.0:
		Global.day = true
	else:
		Global.day = false
		if Global.mobs_spawned_today == false:
			# Create a [Zombie]
			var scene_instance = load("res://scenes/zombie.tscn")
			scene_instance = scene_instance.instantiate()
			scene_instance.global_transform.origin = Vector2(250, 50)
			# Add [Zombie] to scene
			var root_node = get_tree().get_root()
			root_node.add_child(scene_instance)
			Global.mobs_spawned_today = true


# Add item to player's inventory.
func add_item_to_inventory(item):
	# Add existing item
	if inventory_contains_item(item.id):
		change_item_quantity(item.id, 1)
	# Add new item
	else:
		var slot = get_first_empty_slot_number()
		item.slot = slot
		Global.inventory[slot] = item
		update_hud()


# Change the given item's quantity to the player's inventory.
func change_item_quantity(item_id, change = 0) -> int:
	for item in Global.inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					item.quantity += change
					return item.quantity
	return -1


# Get the first empty slot of the player's inventory.
func get_first_empty_slot_number():
	var index = -1
	for i in range(len(Global.inventory)):
		if Global.inventory[i] == null:
			return i
	return index


# Get the slot number of the given item in the player's inventory.
func get_inventory_slot_number(item_id) -> int:
	for item in Global.inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					return item.slot
	return -1


# Check if the player's inventory contains the given item
func inventory_contains_item(item_id: String) -> bool:
	for item in Global.inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					return true
	return false


# Plays the sound matching the given scene path.
func play_sound(sound):
	var tree = get_tree()
	var current_scene = tree.get_current_scene()
	var sounds = current_scene.get_node("sounds/" + sound)
	sounds.play()


# Remove item from player's inventory.
func remove_item_from_inventory(item_id):
	# Remove existing item
	if inventory_contains_item(item_id):
		var quantity = change_item_quantity(item_id, -1)
		# Clear slot if none left
		if quantity == 0:
			var item_slot = get_inventory_slot_number(item_id)
			Global.inventory[item_slot] = null
		update_hud()


# Hack to silence player so other effects can be played.
func stop_player_sound():
	stop_sound("player/strong1")
	stop_sound("player/strong2")
	stop_sound("player/strong3")
	stop_sound("player/strong4")
	stop_sound("player/strong5")
	stop_sound("player/strong6")


# Stops the sound matching the given scene path.
func stop_sound(sound):
	var tree = get_tree()
	var current_scene = tree.get_current_scene()
	var sounds = current_scene.get_node("sounds/" + sound)
	sounds.stop()


# Update the HUD based on the player's status and inventory
func update_hud():
	var tree = get_tree()
	var current_scene = tree.get_current_scene()
	var hud = current_scene.get_node("TileMap/player/hud")
	hud.show_actionbar_items()
	hud.show_inventory_items()
