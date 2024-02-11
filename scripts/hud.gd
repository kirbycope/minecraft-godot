# hud.gd

extends CanvasLayer


var highlighted_slot = 0
var selected_slot = 1
@onready var action_bar_slot_images = [$ActionBar/Slot1/SlotTexture, $ActionBar/Slot2/SlotTexture, $ActionBar/Slot3/SlotTexture, $ActionBar/Slot4/SlotTexture,
	$ActionBar/Slot5/SlotTexture, $ActionBar/Slot6/SlotTexture, $ActionBar/Slot7/SlotTexture, $ActionBar/Slot8/SlotTexture, $ActionBar/Slot9/SlotTexture
]
@onready var inventory_slot_images = [$Slots/Slot1/SlotTexture, $Slots/Slot2/SlotTexture, $Slots/Slot3/SlotTexture, $Slots/Slot4/SlotTexture,
	$Slots/Slot5/SlotTexture, $Slots/Slot6/SlotTexture, $Slots/Slot7/SlotTexture, $Slots/Slot8/SlotTexture, $Slots/Slot9/SlotTexture,
	$Slots/Slot10/SlotTexture, $Slots/Slot11/SlotTexture, $Slots/Slot12/SlotTexture, $Slots/Slot13/SlotTexture, $Slots/Slot14/SlotTexture,
	$Slots/Slot15/SlotTexture, $Slots/Slot16/SlotTexture, $Slots/Slot17/SlotTexture, $Slots/Slot18/SlotTexture, $Slots/Slot19/SlotTexture,
	$Slots/Slot20/SlotTexture, $Slots/Slot21/SlotTexture, $Slots/Slot22/SlotTexture, $Slots/Slot23/SlotTexture, $Slots/Slot24/SlotTexture,
	$Slots/Slot25/SlotTexture, $Slots/Slot26/SlotTexture, $Slots/Slot27/SlotTexture, $Slots/Slot28/SlotTexture, $Slots/Slot29/SlotTexture,
	$Slots/Slot30/SlotTexture, $Slots/Slot31/SlotTexture, $Slots/Slot32/SlotTexture, $Slots/Slot33/SlotTexture, $Slots/Slot34/SlotTexture,
	$Slots/Slot35/SlotTexture, $Slots/Slot36/SlotTexture
]


# Called when an input event is triggered
func _input(event):
		# Inventory - Chest, show
		if $SingleChest.visible == false:
			if Global.player_on_chest and event.is_action_pressed("ui_select"):
				$SingleChest/ChestOpen.play()
				$ActionBar.visible = false
				$Food.visible = false
				$Hearts.visible = false
				$Inventory.visible = false
				$SingleChest.visible = true
				$Slots.visible = true
				$XPBar.visible = false
		# Inventory - Chest, hide
		else:
			if Global.player_on_chest == false or event.is_action_pressed("ui_cancel"):
				$SingleChest/ChestClosed.play()
				$ActionBar.visible = true
				$Food.visible = true
				$Hearts.visible = true
				$SingleChest.visible = false
				$Slots.visible = false
				$XPBar.visible = true
		# Inventory - Crafting Table, show
		if $CraftingTable.visible == false:
			if Global.player_on_crafting_table and event.is_action_pressed("ui_select"):
				$ActionBar.visible = false
				$CraftingTable.visible = true
				$Food.visible = false
				$Hearts.visible = false
				$Inventory.visible = false
				$Slots.visible = true
				$XPBar.visible = false
		# Inventory - Crafting Table, hide
		else:
			if Global.player_on_crafting_table == false or event.is_action_pressed("ui_cancel"):
				$ActionBar.visible = true
				$CraftingTable.visible = false
				$Food.visible = true
				$Hearts.visible = true
				$Slots.visible = false
				$XPBar.visible = true
		# Inventory - Player
		if $CraftingTable.visible == false and $SingleChest.visible == false:
			# Show
			if $Inventory.visible == false:
				if event.is_action_pressed("ui_accept"):
					get_tree().paused = true
					$ActionBar.visible = false
					$Inventory.visible = true
					$Food.visible = false
					$Hearts.visible = false
					$Slots.visible = true
					$XPBar.visible = false
			else:
				# Navigate
				if event.is_action_pressed("ui_down"):
					if highlighted_slot >= 28:
						highlighted_slot -= 27
					elif highlighted_slot >= 1:
						highlighted_slot += 9
				if event.is_action_pressed("ui_left"):
					if (highlighted_slot == 1
					or highlighted_slot == 10
					or highlighted_slot == 19
					or highlighted_slot == 28):
						highlighted_slot += 8
					else:
						highlighted_slot -= 1
				if event.is_action_pressed("ui_right"):
					if (highlighted_slot == 9
					or highlighted_slot == 18
					or highlighted_slot == 27
					or highlighted_slot == 36):
						highlighted_slot -= 8
					else:
						highlighted_slot += 1
				if event.is_action_pressed("ui_up"):
					if highlighted_slot < 10:
						highlighted_slot += 27
					else:
						highlighted_slot -= 9
				highlighted_slot = clamp(highlighted_slot, 1, 36)
				# Hide
				if event.is_action_pressed("ui_accept"):
					get_tree().paused = false
					highlighted_slot = 0
					$ActionBar.visible = true
					$Food.visible = true
					$Hearts.visible = true
					$Inventory.visible = false
					$Slots.visible = false
					$XPBar.visible = true
		if $Slots.visible:
			# Highlight inventory active slot
			clear_inventory_highlight()
			show_inventory_highlight()
		else:
			# Highlight ActionBar selected slot
			clear_slot_selection()
			determine_slot_selection(event)
			show_slot_selection()


# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.


# Clears the selected slot on the ActionBar.
func clear_slot_selection():
	$ActionBar/Slot1/SlotSelected.visible = false
	$ActionBar/Slot2/SlotSelected.visible = false
	$ActionBar/Slot3/SlotSelected.visible = false
	$ActionBar/Slot4/SlotSelected.visible = false
	$ActionBar/Slot5/SlotSelected.visible = false
	$ActionBar/Slot6/SlotSelected.visible = false
	$ActionBar/Slot7/SlotSelected.visible = false
	$ActionBar/Slot8/SlotSelected.visible = false
	$ActionBar/Slot9/SlotSelected.visible = false


# Determines slot to activate on the ActionBar.
func determine_slot_selection(event):
	if event.is_action_pressed("Slot_1"):
		selected_slot = 1
	elif event.is_action_pressed("Slot_2"):
		selected_slot = 2
	elif event.is_action_pressed("Slot_3"):
		selected_slot = 3
	elif event.is_action_pressed("Slot_4"):
		selected_slot = 4
	elif event.is_action_pressed("Slot_5"):
		selected_slot = 5
	elif event.is_action_pressed("Slot_6"):
		selected_slot = 6
	elif event.is_action_pressed("Slot_7"):
		selected_slot = 7
	elif event.is_action_pressed("Slot_8"):
		selected_slot = 8
	elif event.is_action_pressed("Slot_9"):
		selected_slot = 9
	elif event.is_action_pressed("Slot_Down"):
		selected_slot -= 1
		if selected_slot < 1:
			selected_slot = selected_slot + 9
	elif event.is_action_pressed("Slot_Up"):
		selected_slot += 1
		if selected_slot > 9:
			selected_slot = selected_slot - 9


# Sets a global for the item in the selected slot on the ActionBar.
func set_selected_item(texture_rect):
	var texture = texture_rect.texture
	if texture:
		var resource_path = texture.resource_path
		resource_path = resource_path.replace("res://textures/", "")
		resource_path = resource_path.replace(".png", "")
		Global.selected_item = resource_path
	else:
		Global.selected_item = ""


# Shows a frame on the selected slot on the ActionBar.
func show_slot_selection():
	if selected_slot == 1:
		$ActionBar/Slot1/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot1/SlotTexture)
	elif selected_slot == 2:
		$ActionBar/Slot2/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot2/SlotTexture)
	elif selected_slot == 3:
		$ActionBar/Slot3/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot3/SlotTexture)
	elif selected_slot == 4:
		$ActionBar/Slot4/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot4/SlotTexture)
	elif selected_slot == 5:
		$ActionBar/Slot5/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot5/SlotTexture)
	elif selected_slot == 6:
		$ActionBar/Slot6/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot6/SlotTexture)
	elif selected_slot == 7:
		$ActionBar/Slot7/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot7/SlotTexture)
	elif selected_slot == 8:
		$ActionBar/Slot8/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot8/SlotTexture)
	elif selected_slot == 9:
		$ActionBar/Slot9/SlotSelected.visible = true
		set_selected_item($ActionBar/Slot9/SlotTexture)


# Sets the textures for each item in the ActionBar.
func show_actionbar_items():
	var inventory = Global.inventory
	inventory = inventory.slice(0,9)
	for i in range(len(inventory)):
		if inventory[i] != null:
			action_bar_slot_images[i].texture = load(inventory[i].texture)
		else:
			action_bar_slot_images[i].texture = null


# Sets the textures for each item in the Inventory.
func show_inventory_items():
	var inventory = Global.inventory
	inventory = inventory.slice(0,36)
	for i in range(len(inventory)):
		if inventory[i] != null:
			if inventory[i].texture != null:
				inventory_slot_images[i].texture = load(inventory[i].texture)
		else:
			inventory_slot_images[i].texture = null


# Clears the highlight in the inventory
func clear_inventory_highlight():
	var slot_range = 36
	for i in slot_range:
		var slot_number = i + 1
		var node_path = "Slots/Slot" + str(slot_number) + "/SlotHighlighted"
		var node = get_node(node_path)
		node.visible = false


# Highlights the active inventory slot
func show_inventory_highlight():
	if highlighted_slot == 0:
		highlighted_slot = selected_slot
	var node_path = "Slots/Slot" + str(highlighted_slot) +"/SlotHighlighted"
	var node = get_node(node_path)
	node.visible = true
	var inventory = Global.inventory
	var inventory_slot = highlighted_slot - 1
