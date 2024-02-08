extends CanvasLayer


var selected_slot = 1
var action_bar_slots = [null, null, null, null, null, null, null, null, null]
@onready var action_bar_slot_images = [$ActionBar/Slot1/SlotTexture, $ActionBar/Slot2/SlotTexture, $ActionBar/Slot3/SlotTexture, $ActionBar/Slot4/SlotTexture,
	$ActionBar/Slot5/SlotTexture, $ActionBar/Slot6/SlotTexture, $ActionBar/Slot7/SlotTexture, $ActionBar/Slot8/SlotTexture, $ActionBar/Slot9/SlotTexture]

# Called when an input event is triggered
func _input(event):
		# Inventory - Chest, show
		if $Inventory.visible == false:
			if Global.player_on_chest and event.is_action_pressed("ui_select"):
				$Inventory/ChestOpen.play()
				$ActionBar.visible = false
				$Inventory.visible = true
		# Inventory - Chest, hide
		else:
			if Global.player_on_chest == false or event.is_action_pressed("ui_cancel"):
				$Inventory/ChestClosed.play()
				$ActionBar.visible = true
				$Inventory.visible = false
		# Inventory - Crafting Table, show
		if $CraftingTable.visible == false:
			if Global.player_on_crafting_table and event.is_action_pressed("ui_select"):
				$ActionBar.visible = false
				$CraftingTable.visible = true
		# Inventory - Crafting Table, hide
		else:
			if Global.player_on_crafting_table == false or event.is_action_pressed("ui_cancel"):
				$ActionBar.visible = true
				$CraftingTable.visible = false
		# Determine selected slot
		clear_slot_selection()
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
		show_slot_selection()


# Called when the node enters the scene tree for the first time.
func _ready():
	clear_slot_selection()
	show_slot_selection()
	show_actionbar_items()


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
	action_bar_slots = Global.get_inventory()
	action_bar_slots = action_bar_slots.slice(0,9)
	for i in range(len(action_bar_slots)):
		if action_bar_slots[i] != null:
			action_bar_slot_images[i].texture = load(action_bar_slots[i].texture)
			print(action_bar_slots[i])


func assign_selected_item(texture_rect):
	var texture = texture_rect.texture
	if texture:
		var resource_path = texture.resource_path
		if resource_path == "res://textures/wood_axe.png":
			Global.selected_item = "wood_axe"
		elif resource_path == "res://textures/wood_hoe.png":
			Global.selected_item = "wood_hoe"
		elif resource_path == "res://textures/wood_pickaxe.png":
			Global.selected_item = "wood_pickaxe"
		elif resource_path == "res://textures/wood_shovel.png":
			Global.selected_item = "wood_shovel"
		elif resource_path == "res://textures/wood_sword.png":
			Global.selected_item = "wood_sword"
		print(Global.selected_item)
