# chest.gd

extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		Global.player_on_chest = true


func _on_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		Global.player_on_chest = false
