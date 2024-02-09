extends CanvasLayer


var selected_slot = 1
@onready var action_bar_slot_images = [$ActionBar/Slot1/SlotTexture, $ActionBar/Slot2/SlotTexture, $ActionBar/Slot3/SlotTexture, $ActionBar/Slot4/SlotTexture,
	$ActionBar/Slot5/SlotTexture, $ActionBar/Slot6/SlotTexture, $ActionBar/Slot7/SlotTexture, $ActionBar/Slot8/SlotTexture, $ActionBar/Slot9/SlotTexture
]
@onready var crafting_table_slot_images = [$CraftingTable/Slot1/SlotTexture, $CraftingTable/Slot2/SlotTexture, $CraftingTable/Slot3/SlotTexture, $CraftingTable/Slot4/SlotTexture,
	$CraftingTable/Slot5/SlotTexture, $CraftingTable/Slot6/SlotTexture, $CraftingTable/Slot7/SlotTexture, $CraftingTable/Slot8/SlotTexture, $CraftingTable/Slot9/SlotTexture,
	$CraftingTable/Slot10/SlotTexture, $CraftingTable/Slot11/SlotTexture, $CraftingTable/Slot12/SlotTexture, $CraftingTable/Slot13/SlotTexture, $CraftingTable/Slot14/SlotTexture,
	$CraftingTable/Slot15/SlotTexture, $CraftingTable/Slot16/SlotTexture, $CraftingTable/Slot17/SlotTexture, $CraftingTable/Slot18/SlotTexture
]
@onready var inventory_slot_images = [$Inventory/Slot1/SlotTexture, $Inventory/Slot2/SlotTexture, $Inventory/Slot3/SlotTexture, $Inventory/Slot4/SlotTexture,
	$Inventory/Slot5/SlotTexture, $Inventory/Slot6/SlotTexture, $Inventory/Slot7/SlotTexture, $Inventory/Slot8/SlotTexture, $Inventory/Slot9/SlotTexture,
	$Inventory/Slot10/SlotTexture, $Inventory/Slot11/SlotTexture, $Inventory/Slot12/SlotTexture, $Inventory/Slot13/SlotTexture, $Inventory/Slot14/SlotTexture,
	$Inventory/Slot15/SlotTexture, $Inventory/Slot16/SlotTexture, $Inventory/Slot17/SlotTexture, $Inventory/Slot18/SlotTexture
]
@onready var single_chest_slot_images = [$SingleChest/Slot1/SlotTexture, $SingleChest/Slot2/SlotTexture, $SingleChest/Slot3/SlotTexture, $SingleChest/Slot4/SlotTexture,
	$SingleChest/Slot5/SlotTexture, $SingleChest/Slot6/SlotTexture, $SingleChest/Slot7/SlotTexture, $SingleChest/Slot8/SlotTexture, $SingleChest/Slot9/SlotTexture,
	$SingleChest/Slot10/SlotTexture, $SingleChest/Slot11/SlotTexture, $SingleChest/Slot12/SlotTexture, $SingleChest/Slot13/SlotTexture, $SingleChest/Slot14/SlotTexture,
	$SingleChest/Slot15/SlotTexture, $SingleChest/Slot16/SlotTexture, $SingleChest/Slot17/SlotTexture, $SingleChest/Slot18/SlotTexture
]


# Called when an input event is triggered
func _input(event):
		# Inventory - Chest, show
		if $SingleChest.visible == false:
			if Global.player_on_chest and event.is_action_pressed("ui_select"):
				$SingleChest/ChestOpen.play()
				$ActionBar.visible = false
				$Inventory.visible = false
				$SingleChest.visible = true
		# Inventory - Chest, hide
		else:
			if Global.player_on_chest == false or event.is_action_pressed("ui_cancel"):
				$SingleChest/ChestClosed.play()
				$ActionBar.visible = true
				$SingleChest.visible = false
		# Inventory - Crafting Table, show
		if $CraftingTable.visible == false:
			if Global.player_on_crafting_table and event.is_action_pressed("ui_select"):
				$ActionBar.visible = false
				$CraftingTable.visible = true
				$Inventory.visible = false
		# Inventory - Crafting Table, hide
		else:
			if Global.player_on_crafting_table == false or event.is_action_pressed("ui_cancel"):
				$ActionBar.visible = true
				$CraftingTable.visible = false
		# Inventory - Inventory, show
		if $CraftingTable.visible == false and $SingleChest.visible == false:
			if $Inventory.visible == false:
				if event.is_action_pressed("ui_accept"):
					$ActionBar.visible = false
					$Inventory.visible = true
			else:
				if event.is_action_pressed("ui_accept"):
					$ActionBar.visible = true
					$Inventory.visible = false
		# Highlight selected slot
		clear_slot_selection()
		determine_slot_selection(event)
		show_slot_selection()


# Called when the node enters the scene tree for the first time.
func _ready():
	clear_slot_selection()
	show_slot_selection()
	show_actionbar_items()
	show_crafting_table_items()
	show_inventory_items()
	show_single_chest_items()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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


func show_slot_selection():
	if selected_slot == 1:
		$ActionBar/Slot1/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot1/SlotTexture)
	elif selected_slot == 2:
		$ActionBar/Slot2/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot2/SlotTexture)
	elif selected_slot == 3:
		$ActionBar/Slot3/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot3/SlotTexture)
	elif selected_slot == 4:
		$ActionBar/Slot4/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot4/SlotTexture)
	elif selected_slot == 5:
		$ActionBar/Slot5/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot5/SlotTexture)
	elif selected_slot == 6:
		$ActionBar/Slot6/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot6/SlotTexture)
	elif selected_slot == 7:
		$ActionBar/Slot7/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot7/SlotTexture)
	elif selected_slot == 8:
		$ActionBar/Slot8/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot8/SlotTexture)
	elif selected_slot == 9:
		$ActionBar/Slot9/SlotSelected.visible = true
		assign_selected_item($ActionBar/Slot9/SlotTexture)


func show_actionbar_items():
	var inventory = Global.get_inventory()
	inventory = inventory.slice(0,9)
	for i in range(len(inventory)):
		if inventory[i] != null:
			action_bar_slot_images[i].texture = load(inventory[i].texture)
			# print(inventory[i]) # DEBUGGING


func show_crafting_table_items():
	var inventory = Global.get_inventory()
	for i in range(len(inventory)):
		if inventory[i] != null:
			crafting_table_slot_images[i].texture = load(inventory[i].texture)
			#print(inventory[i]) # DEBUGGING


func show_inventory_items():
	var inventory = Global.get_inventory()
	for i in range(len(inventory)):
		if inventory[i] != null:
			inventory_slot_images[i].texture = load(inventory[i].texture)
			#print(inventory[i]) # DEBUGGING


func show_single_chest_items():
	var inventory = Global.get_inventory()
	for i in range(len(inventory)):
		if inventory[i] != null:
			single_chest_slot_images[i].texture = load(inventory[i].texture)
			#print(inventory[i]) # DEBUGGING


func assign_selected_item(texture_rect):
	var texture = texture_rect.texture
	if texture:
		var resource_path = texture.resource_path
		resource_path = resource_path.replace("res://textures/", "")
		resource_path = resource_path.replace(".png", "")
		Global.selected_item = resource_path
	else:
		Global.selected_item = ""
	#print(Global.selected_item) # DEBUGGING
