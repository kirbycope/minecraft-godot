extends CanvasLayer


var selected_slot = 1


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
		draw_slot_selection()


# Called when the node enters the scene tree for the first time.
func _ready():
	clear_slot_selection()
	draw_slot_selection()


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


func draw_slot_selection():
	if selected_slot == 1:
		$ActionBar/Slot1/SlotSelected.visible = true
	elif selected_slot == 2:
		$ActionBar/Slot2/SlotSelected.visible = true
	elif selected_slot == 3:
		$ActionBar/Slot3/SlotSelected.visible = true
	elif selected_slot == 4:
		$ActionBar/Slot4/SlotSelected.visible = true
	elif selected_slot == 5:
		$ActionBar/Slot5/SlotSelected.visible = true
	elif selected_slot == 6:
		$ActionBar/Slot6/SlotSelected.visible = true
	elif selected_slot == 7:
		$ActionBar/Slot7/SlotSelected.visible = true
	elif selected_slot == 8:
		$ActionBar/Slot8/SlotSelected.visible = true
	elif selected_slot == 9:
		$ActionBar/Slot9/SlotSelected.visible = true