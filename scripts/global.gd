# global.gd

extends Node


var inventory = [null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null, null, null, null, null,
	null, null, null, null, null, null]
var is_falling = false
var last_direction = Vector2.RIGHT
var player_on_chest = false
var player_on_crafting_table = false
var player_position = Vector2(0, 0)
var selected_item = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.


# Add item to player's inventory.
func add_item_to_inventory(item):
	# Add existing item
	if inventory_contains_item(item.id):
		change_item_quantity(item.id, 1)
	# Add new item
	else:
		var slot = get_first_empty_slot_number()
		item.slot = slot
		inventory[slot] = item


# Change the given item's quantity to the player's inventory.
func change_item_quantity(item_id, change = 0) -> int:
	for item in inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					item.quantity += change
					return item.quantity
	return -1


# Get the first empty slot of the player's inventory.
func get_first_empty_slot_number():
	var index = -1
	for i in range(len(inventory)):
		if inventory[i] == null:
			return i
	return index


# Get the slot number of the given item in the player's inventory.
func get_inventory_slot_number(item_id) -> int:
	for item in inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					return item.slot
	return -1


# Check if the player's inventory contains the given item
func inventory_contains_item(item_id: String) -> bool:
	for item in inventory:
		if item != null:
			if item.has("id"):
				if item.id == item_id:
					return true
	return false


# Remove item from player's inventory.
func remove_item_from_inventory(item_id):
	# Remove existing item
	if inventory_contains_item(item_id):
		var quantity = change_item_quantity(item_id, -1)
		# Clear slot if none left
		if quantity == 0:
			var item_slot = get_inventory_slot_number(item_id)
			inventory[item_slot] = null
