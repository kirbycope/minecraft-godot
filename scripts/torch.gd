extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Hide if not day
	$PointLight2D.visible = not Global.day


func _on_body_entered(body):
	if body.is_in_group("Player"):
		# Give player "torch"
		var item = {}
		item.id = "torch"
		item.stack_size = 1
		item.quantity = 1
		item.texture = "res://textures/torch.png"
		Global.add_item_to_inventory(item)
		queue_free()
