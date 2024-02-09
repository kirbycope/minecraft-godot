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
	# todo: max inventory
	item.slot = len(inventory)
	inventory.append(item)


func get_inventory():
	return inventory
