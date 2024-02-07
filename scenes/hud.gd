extends CanvasLayer


var selected_slot = 1


# Called when an input event is triggered
func _input(event):
		clear_slot_selection()
		if event.is_action_pressed("Slot_1"):
			selected_slot = 1
		elif event.is_action_pressed("Slot_2"):
			selected_slot = 2
		draw_slot_selection()


# Called when the node enters the scene tree for the first time.
func _ready():
	clear_slot_selection()
	draw_slot_selection()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func clear_slot_selection():
	$Slot1/SlotSelected.visible = false
	$Slot2/SlotSelected.visible = false


func draw_slot_selection():
	if selected_slot == 1:
		$Slot1/SlotSelected.visible = true
	elif selected_slot == 2:
		$Slot2/SlotSelected.visible = true
