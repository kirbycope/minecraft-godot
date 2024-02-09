extends Node


var inventory = []
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
	pass


func add_item_to_inventory(item):
	var array_of_objects = inventory
	var search_value = item.id
	var property_to_check = "id"
	# Add existing item
	if arrayContainsObjectWithPropertyValue(array_of_objects, property_to_check, search_value):
		var object_name = search_value
		var property_name = "id"
		var value_to_add = item.quantity
		addToProperty(array_of_objects, property_name, object_name, value_to_add)
	# Add new item
	else:
		item.slot = len(inventory)
		inventory.append(item)


func get_inventory():
	return inventory


# Function to check if the array contains an object with the given property value
func arrayContainsObjectWithPropertyValue(array_to_check: Array, property_name: String, property_value: String) -> bool:
	for obj in array_to_check:
		# Check if the object has the property and if its value matches the given string
		if obj.has(property_name) and obj[property_name] == property_value:
			return true
	return false


# Function to add a value to a property of an object in the array
func addToProperty(array_to_modify: Array, property_name: String, object_name: String, value_to_add: int) -> bool:
	for obj in array_to_modify:
		if obj.has(property_name):
			var obj_property_name = obj[property_name]
			if obj_property_name == object_name:
				obj["quantity"] += value_to_add
				return true
	return false
